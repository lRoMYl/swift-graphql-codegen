//
//  GraphQLCodegen.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

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
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  private let generators: [GraphQLCodeGenerating]

  public init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy

    self.generators = [
      HeaderCodeGenerator(entityNameMap: self.entityNameMap),
      EnumCodeGenerator(
        scalarMap: self.scalarMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      ObjectCodeGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      InputObjectCodeGenerator(
        scalarMap: self.scalarMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      InterfaceCodeGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      UnionCodeGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      RequestParameterGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap,
        entityNameStrategy: self.entityNameStrategy
      ),
      ResponseCodeGenerator(
        entityNameMap: self.entityNameMap,
        entityNameStrategy: entityNameStrategy
      )
    ]
  }

  public func code(schema: Schema) throws -> String {
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
