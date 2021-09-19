//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

struct ObjectSpecificationGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap
  private let objectFieldSpecificationGenerator: ObjectFieldSpecificationGenerator

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
    self.objectFieldSpecificationGenerator = ObjectFieldSpecificationGenerator(scalarMap: scalarMap)
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - Objects

    \(
      try schema.objects.compactMap {
        try $0.declaration(
          objects: schema.objects,
          scalarMap: scalarMap,
          objectFieldSpecificationGenerator: objectFieldSpecificationGenerator
        )
      }.lines
    )
    """
  }
}

private extension ObjectType {
  func declaration(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    objectFieldSpecificationGenerator: ObjectFieldSpecificationGenerator
  ) throws -> String {
    let name = self.name.pascalCase
    let fieldsVariable = try allFields(objects: objects)
      .map { try objectFieldSpecificationGenerator.variableDeclaration(field: $0) }
      .lines
    let fieldsCodingKey = allFields(objects: objects)
      .map { objectFieldSpecificationGenerator.codingKeyDeclaration(field: $0) }
      .lines

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
