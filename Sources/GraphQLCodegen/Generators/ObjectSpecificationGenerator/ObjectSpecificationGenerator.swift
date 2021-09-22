//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

struct ObjectSpecificationGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let fieldSpecificationGenerator: FieldSpecificationGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.fieldSpecificationGenerator = FieldSpecificationGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap
    )
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - Objects

    \(
      try schema.objects.compactMap {
        try $0.declaration(
          objects: schema.objects,
          scalarMap: scalarMap,
          fieldSpecificationGenerator: fieldSpecificationGenerator
        )
      }.lines
    )

    \(
      try schema.interfaces.compactMap {
        try $0.declaration(
          objects: schema.objects,
          scalarMap: scalarMap,
          fieldSpecificationGenerator: fieldSpecificationGenerator
        )
      }.lines
    )
    """
  }
}

private extension Structure {
  func declaration(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    fieldSpecificationGenerator: FieldSpecificationGenerator
  ) throws -> String {
    let name = self.name.pascalCase
    let sortedFields = fields.sorted(by: { $0.name < $1.name })

    let fieldsVariable = try sortedFields
      .map { try fieldSpecificationGenerator.variableDeclaration(object: self, field: $0) }
      .lines
    let fieldsCodingKey = sortedFields
      .map { fieldSpecificationGenerator.codingKeyDeclaration(object: self, field: $0) }
      .lines

    return """
    struct \(name): Decodable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
