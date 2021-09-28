//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
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

  /// Generators
  private let generators: [Generating]

  public init(entityNameMap: EntityNameMap?, scalarMap: ScalarMap?) throws {
    self.entityNameMap = entityNameMap ?? .default
    self.scalarMap = ScalarMap.default.merging(
      scalarMap ?? [:],
      uniquingKeysWith: { (_, new) in new }
    )

    self.generators = [
      HeaderGenerator(),
      ApiClientGenerator(
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap
      ),
      ResourceParametersGenerator(entityNameMap: self.entityNameMap, scalarMap: self.scalarMap),
      GraphQLResponseWrappedValueGenerator(
        entityNameMap: self.entityNameMap,
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
