//
//  GraphQLCodegen.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

enum GraphQLCodegenSpecSwiftError: Error, LocalizedError {
  case formatError(context: String)

  var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self): \(context)"
    }
  }
}

public struct GraphQLCodegenSpecSwift {
  private let namespace: String
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let generators: [GraphQLCodeGenerating]

  public init(
    namespace: String?,
    scalarMap: ScalarMap?,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap?
  ) throws {
    try selectionMap?.validate()

    self.namespace = namespace ?? ""
    self.scalarMap = ScalarMap.default.merging(
      scalarMap ?? [:],
      uniquingKeysWith: { (_, new) in new }
    )
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap ?? EntityNameMap.default

    self.generators = [
      HeaderCodeGenerator(namespace: self.namespace, entityNameMap: self.entityNameMap),
      EnumCodeGenerator(scalarMap: self.scalarMap),
      ObjectCodeGenerator(scalarMap: self.scalarMap, selectionMap: self.selectionMap),
      InputObjectCodeGenerator(scalarMap: self.scalarMap),
      RequestParameterGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap
      ),
      FooterCodeGenerator(namespace: self.namespace)
    ]
  }

  public func generate(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let formattedCode: String
    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenSpecSwiftError
        .formatError(
          context: """
            \(error)
            Raw text:
            \(code)
            """
        )
    }
    return formattedCode
  }
}
