//
//  File.swift
//  
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLCodegenUtil
import GraphQLAST

struct InputObjectSpecificationGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap
  private let objectFieldSpecificationGenerator: InputObjectFieldSpecificationGenerator

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
    self.objectFieldSpecificationGenerator = InputObjectFieldSpecificationGenerator(scalarMap: scalarMap)
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - Input Objects

    \(
      try schema.inputObjects.compactMap {
        try $0.declaration(
          scalarMap: scalarMap,
          objectFieldSpecificationGenerator: objectFieldSpecificationGenerator
        )
      }.lines
    )
    """
  }
}

// MARK: - InputObjectType

private extension InputObjectType {
  func declaration(
    scalarMap: ScalarMap,
    objectFieldSpecificationGenerator: InputObjectFieldSpecificationGenerator
  ) throws -> String {
    let name = self.name.pascalCase

    let fieldsVariable = try inputFields
      .map { try objectFieldSpecificationGenerator.variableDeclaration(input: $0) }
      .lines
    let fieldsCodingKey = inputFields
      .map { objectFieldSpecificationGenerator.codingKeyDeclaration(input: $0) }
      .lines

    return """
    struct \(name): Encodable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}

