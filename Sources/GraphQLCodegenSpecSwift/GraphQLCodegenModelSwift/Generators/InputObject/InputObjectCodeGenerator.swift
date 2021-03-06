//
//  File.swift
//
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

struct InputObjectCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let objectFieldCodeGenerator: InputObjectFieldCodeGenerator

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider

    self.objectFieldCodeGenerator = InputObjectFieldCodeGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    let codes = try schema.inputObjects.sorted(by: { $0.name > $1.name }).compactMap {
      try declaration(inputObjectType: $0)
    }.lines

    guard !codes.isEmpty else { return "" }

    return """
    // MARK: - Input Objects

    \(codes)
    """
  }
}

// MARK: - InputObjectType

private extension InputObjectCodeGenerator {
  func declaration(
    inputObjectType: InputObjectType
  ) throws -> String {
    let name = try entityNameProvider.name(for: inputObjectType)

    let fieldsVariable = try inputObjectType.inputFields
      .map { try objectFieldCodeGenerator.variableDeclaration(input: $0) }
      .lines
    let fieldsCodingKey = inputObjectType.inputFields
      .map { objectFieldCodeGenerator.codingKeyDeclaration(input: $0) }
      .lines

    return """
    struct \(name): \(entityNameProvider.requestType) {
      \(fieldsVariable)

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
