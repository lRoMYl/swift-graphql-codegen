//
//  File.swift
//  
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLCodegenUtil
import GraphQLAST
import GraphQLCodegenConfig

struct InputObjectCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let objectFieldCodeGenerator: InputObjectFieldCodeGenerator

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.objectFieldCodeGenerator = InputObjectFieldCodeGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap
    )
  }

  func code(schema: Schema) throws -> String {
    """
    // MARK: - Input Objects

    enum \(entityNameMap.inputObjects) {}

    extension \(entityNameMap.inputObjects) {
      \(
        try schema.inputObjects.compactMap {
          try $0.declaration(
            scalarMap: scalarMap,
            objectFieldSpecificationGenerator: objectFieldCodeGenerator
          )
        }.lines
      )
    }
    """
  }
}

// MARK: - InputObjectType

private extension InputObjectType {
  func declaration(
    scalarMap: ScalarMap,
    objectFieldSpecificationGenerator: InputObjectFieldCodeGenerator
  ) throws -> String {
    let name = self.name.pascalCase

    let fieldsVariable = try inputFields
      .map { try objectFieldSpecificationGenerator.variableDeclaration(input: $0) }
      .lines
    let fieldsCodingKey = inputFields
      .map { objectFieldSpecificationGenerator.codingKeyDeclaration(input: $0) }
      .lines

    // Due to a PD-Kami requiring the ApiModel to be Codable, we cannot generate an object
    // with Decodable conformance
    return """
    struct \(name): Codable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}

