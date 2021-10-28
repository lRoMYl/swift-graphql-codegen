//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct RequestParameterEncodableGenerator {
  private let selectionMap: SelectionMap?
  private let scalarMap: ScalarMap

  init(selectionMap: SelectionMap?, scalarMap: ScalarMap) {
    self.selectionMap = selectionMap
    self.scalarMap = scalarMap
  }

  func encodingDeclaration(field: Field, schema: Schema) throws -> String {
    field.args.isEmpty
      ? emptyEncoder()
      : try codingKeys(with: field, objects: schema.objects)
  }
}

// MARK: - RequestParameterEncodableGenerator

private extension RequestParameterEncodableGenerator {
  func codingKeys(with field: Field, objects: [ObjectType]) throws -> String {
    let nestedFields = try field.nestedFields(
      objects: objects,
      scalarMap: scalarMap,
      excluded: [],
      selectionMap: selectionMap
    )
    let codingKeyDeclarations = try nestedFields.map { nestedfield in
      try nestedfield.args.compactMap {
        try $0.codingKeysDeclaration(with: nestedfield, rootField: field)
      }.lines
    }.lines

    return """
    private enum CodingKeys: String, CodingKey {
      \(codingKeyDeclarations)
    }
    """
  }

  func emptyEncoder() -> String {
    "func encode(to _: Encoder) throws {}"
  }
}

// MARK: - InputValue

private extension InputValue {
  func codingKeysDeclaration(with field: Field, rootField: Field) throws -> String {
    let isRootArgument = field.name == rootField.name && field.type == rootField.type

    let variableName = isRootArgument
      ? name.camelCase
      : rootField.name.camelCase + field.name.pascalCase + name.pascalCase
    let argumentName = isRootArgument
      ? (field.name + name.pascalCase).camelCase
      : rootField.name.camelCase + field.name.pascalCase + name.pascalCase
    
    return """
    \(docs)
    case \(variableName) = \"\(argumentName)\"
    """
  }
}
