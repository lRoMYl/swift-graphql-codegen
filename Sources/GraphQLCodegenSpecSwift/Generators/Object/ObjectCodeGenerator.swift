//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct ObjectCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap
    )
  }

  func code(schema: Schema) throws -> String {
    return """
    // MARK: - \(entityNameMap.objects)

    enum \(entityNameMap.objects) {}

    extension \(entityNameMap.objects) {
      \(
        try schema.objects.compactMap {
          try $0.declaration(
            objects: schema.objects,
            scalarMap: scalarMap,
            fieldSpecificationGenerator: fieldSpecificationGenerator
          )
        }.lines
      )
    }

    """
  }
}

// MARK: - Structure

private extension Structure {
  func declaration(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    fieldSpecificationGenerator: FieldCodeGenerator
  ) throws -> String {
    let sortedFields = fields.sorted(by: { $0.name < $1.name })

    let fieldsVariable = try sortedFields
      .map { try fieldSpecificationGenerator.variableDeclaration(object: self, field: $0) }
      .lines
    let fieldsCodingKey = sortedFields
      .map { fieldSpecificationGenerator.codingKeyDeclaration(object: self, field: $0) }
      .lines

    // Due to a PD-Kami requiring the ApiModel to be Codable, we cannot generate an object
    // with Decodable conformance
    return """
    struct \(objectName): Codable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
