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

enum GraphQLCodegenApiClientSwiftError: Error, LocalizedError {
  case formatError(context: String)

  var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self).formatError: \(context)"
    }
  }
}

public enum ApiClientStrategy: String {
  case `default`
  case rxSwift
}

public struct GraphQLCodegenApiClientSwift {
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding
  private let apiClientPrefix: String
  private let apiClientStrategy: ApiClientStrategy

  /// Generators
  private let generators: [Generating]

  public init(
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    entityNameProvider: EntityNameProviding,
    apiClientPrefix: String,
    apiClientStrategy: ApiClientStrategy
  ) throws {
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
    self.apiClientPrefix = apiClientPrefix
    self.apiClientStrategy = apiClientStrategy

    var generators: [Generating] = [
      HeaderGenerator(apiClientStrategy: self.apiClientStrategy),
      ApiClientGenerator(
        selectionMap: selectionMap,
        entityNameMap: self.entityNameMap,
        scalarMap: self.scalarMap,
        entityNameProvider: self.entityNameProvider,
        apiClientPrefix: self.apiClientPrefix,
        apiClientStrategy: self.apiClientStrategy
      )
    ]

    switch apiClientStrategy {
    case .default:
      break
    case .rxSwift:
      generators.append(
        ApiClientRxGenerator(
          selectionMap: selectionMap,
          entityNameMap: self.entityNameMap,
          scalarMap: self.scalarMap,
          entityNameProvider: self.entityNameProvider,
          apiClientPrefix: self.apiClientPrefix
        )
      )
    }

    self.generators = generators
  }

  public func code(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema).format() }.lines

    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenApiClientSwiftError
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
