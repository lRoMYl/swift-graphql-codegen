//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

struct RequestEncodableGenerator {
  private let selectionMap: SelectionMap?
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding

  init(selectionMap: SelectionMap?, scalarMap: ScalarMap, entityNameProvider: EntityNameProviding) {
    self.selectionMap = selectionMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
  }

  func encodingDeclaration(field: Field, schema: Schema) throws -> String {
    field.args.isEmpty
      ? emptyEncoder()
      : try codingKeys(with: field, objects: schema.objects, schema: schema)
  }
}

// MARK: - RequestParameterEncodableGenerator

private extension RequestEncodableGenerator {
  func codingKeys(with field: Field, objects: [ObjectType], schema: Schema) throws -> String {
    let nestedFields = try field.nestedFields(
      objects: objects,
      scalarMap: scalarMap,
      excluded: [],
      selectionMap: selectionMap,
      schemaMap: SchemaMap(schema: schema)
    )
    let codingKeyDeclarations = try nestedFields.map { nestedfield in
      try nestedfield.args.compactMap {
        try codingKeysDeclaration(with: $0, field: nestedfield, rootField: field)
      }.lines
    }.lines

    return """
    private enum CodingKeys: String, CodingKey {
      \(codingKeyDeclarations)
    }
    """
  }

  func codingKeysDeclaration(
    with inputValue: InputValue,
    field: Field,
    rootField: Field
  ) throws -> String {
    let codingKeyName = try entityNameProvider.operationVariableKeyName(
      with: inputValue,
      field: field,
      rootField: rootField
    )
    let operationVariableName = try entityNameProvider.operationVariableName(
      with: inputValue,
      field: field,
      rootField: rootField
    )

    return """
    \(inputValue.docs)
    case \(codingKeyName) = \"\(operationVariableName)\"
    """
  }

  func emptyEncoder() -> String {
    "func encode(to _: Encoder) throws {}"
  }
}
