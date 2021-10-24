//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import SwiftFormat

enum GraphQLCodegenMapperError: Error, LocalizedError {
  case formatError(context: String)

  var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self).formatError: \(context)"
    }
  }
}

public struct GraphQLCodegenMapperSwift {
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameProvider: EntityNameProviding

  /// Generators
  private let generators: [Generating]

  public init(
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameProvider: EntityNameProviding
  ) throws {
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameProvider = entityNameProvider

    self.generators = [
      HeaderGenerator(),
      MapperErrorGenerator(
        entityNameMap: self.entityNameMap,
        entityNameProvider: entityNameProvider
      ),
      SelectionMockGenerator(
        selectionMap: self.selectionMap,
        entityNameProvider: entityNameProvider
      ),
      SelectionDecoderGenerator(
        entityNameProvider: entityNameProvider,
        scalarMap: self.scalarMap,
        entityNameMap: self.entityNameMap,
        selectionMap: self.selectionMap
      ),
      RequestMapperGenerator(
        entityNameProvider: entityNameProvider,
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap
      )
    ]
  }

  public func code(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenMapperError
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
