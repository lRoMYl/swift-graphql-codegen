//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct ObjectCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider

    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    let code = try schema.objects.compactMap {
      try $0.declaration(
        objects: schema.objects,
        scalarMap: scalarMap,
        fieldSpecificationGenerator: fieldSpecificationGenerator,
        entityNameProvider: entityNameProvider
      )
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.object)

    \(code)

    """
  }
}

// MARK: - Structure

private extension ObjectType {
  func declaration(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    fieldSpecificationGenerator: FieldCodeGenerator,
    entityNameProvider: EntityNameProviding
  ) throws -> String {
    let sortedFields = fields.sorted(by: { $0.name < $1.name })

    let fieldsVariable = try sortedFields
      .map { try fieldSpecificationGenerator.variableDeclaration(object: self, field: $0) }
      .joined(separator: "\n\n")
    let fieldsCodingKey = sortedFields
      .map { fieldSpecificationGenerator.codingKeyDeclaration(object: self, field: $0) }
      .lines

    // Due to a PD-Kami requiring the ApiModel to be Codable, we cannot generate an object
    // with Decodable conformance
    return """
    struct \(try entityNameProvider.name(for: self)): Codable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
