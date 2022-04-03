//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import SwiftFormat

enum GraphQLCodegenDHApiClientSwiftError: Error, LocalizedError {
  case formatError(context: String)

  var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self).formatError: \(context)"
    }
  }
}

public struct GraphQLCodegenDHApiClientSwift {
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding
  private let apiClientPrefix: String

  /// Generators
  private let generators: [Generating]

  public init(
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    entityNameProvider: EntityNameProviding,
    apiClientPrefix: String
  ) throws {
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
    self.apiClientPrefix = apiClientPrefix

    self.generators = [
      HeaderGenerator(),
      ApiClientGenerator(
        selectionMap: selectionMap,
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap,
        entityNameProvider: self.entityNameProvider,
        apiClientPrefix: self.apiClientPrefix
      ),
      ResourceParametersGenerator(
        selectionMap: selectionMap,
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap,
        entityNameProvider: entityNameProvider,
        apiClientPrefix: self.apiClientPrefix
      )
    ]
  }

  public func code(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema).format() }.lines

    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenDHApiClientSwiftError
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
