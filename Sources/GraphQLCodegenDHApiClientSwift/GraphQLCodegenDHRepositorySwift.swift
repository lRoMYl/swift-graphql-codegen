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
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding

  /// Generators
  private let generators: [Generating]

  public init(entityNameMap: EntityNameMap, scalarMap: ScalarMap, entityNameProvider: EntityNameProviding) throws {
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider

    self.generators = [
      HeaderGenerator(),
      ApiClientGenerator(
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap,
        entityNameProvider: self.entityNameProvider
      ),
      ResourceParametersGenerator(
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap,
        entityNameProvider: entityNameProvider
      ),
      SelectionMockGenerator(
        entityNameProvider: entityNameProvider
      ),
      SelectionDecoderGenerator(
        entityNameProvider: entityNameProvider,
        scalarMap: self.scalarMap,
        entityNameMap: self.entityNameMap
      ),
      RequestMapperGenerator(
        entityNameProvider: entityNameProvider,
        scalarMap: self.scalarMap
      )
    ]
  }

  public func code(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

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
