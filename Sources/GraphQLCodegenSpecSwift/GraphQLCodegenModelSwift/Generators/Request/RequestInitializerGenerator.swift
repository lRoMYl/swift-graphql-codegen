//
//  File.swift
//
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

struct RequestInitializerGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let selectionMap: SelectionMap?
  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?,
    entityNameProvider: EntityNameProviding
  ) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap
    self.entityNameProvider = entityNameProvider
  }

  func declaration(with field: Field, schema: Schema) throws -> String {
    let nestedFields = try field.nestedFields(
      objects: schema.objects,
      scalarMap: scalarMap,
      excluded: [],
      selectionMap: selectionMap,
      schemaMap: SchemaMap(schema: schema)
    )

    let arguments: String = try nestedFields.reduce(into: [String]()) { result, nestedField in
      result.append(contentsOf: try nestedField.args.map {
        try argumentDeclaration(inputValue: $0, field: nestedField, rootField: field)
      })
    }
    .sorted(by: { $0 < $1 })
    .joined(separator: ",\n")

    let assignments = try nestedFields.reduce(into: [String]()) { result, nestedField in
      result.append(contentsOf: try nestedField.args.map {
        try assignmentDeclaration(inputValue: $0, field: nestedField, rootField: field)
      })
    }
    .sorted(by: { $0 < $1 })
    .lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }

  func declaration(with operation: GraphQLAST.Operation) throws -> String {
    let fields = operation.type.selectableFields(selectionMap: selectionMap)
    let arguments = try fields.map {
      "\($0.name.camelCase): \(try entityNameProvider.requestParameterName(for: $0, with: operation))? = nil"
    }
    .joined(separator: ",\n")

    let assignments = fields.map {
      let argumentName = $0.name.camelCase
      return "self.\(argumentName) = \(argumentName)"
    }.lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }
}

private extension RequestInitializerGenerator {
  func argumentDeclaration(inputValue: InputValue, field: Field, rootField: Field) throws -> String {
    let key = try entityNameProvider.operationVariableKeyName(with: inputValue, field: field, rootField: rootField)
    let typeName = try entityNameProvider.name(for: inputValue.type)

    return "\(key): \(typeName)"
  }

  func assignmentDeclaration(inputValue: InputValue, field: Field, rootField: Field) throws -> String {
    let isRootArgument = field.name == rootField.name && field.type == rootField.type
    let argumentName = isRootArgument
      ? inputValue.name.camelCase
      : rootField.name.camelCase + field.name.pascalCase + inputValue.name.pascalCase

    return "self.\(argumentName) = \(argumentName)"
  }
}
