//
//  File.swift
//
//
//  Created by Romy Cheah on 19/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

struct RequestVariablesGenerator {
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

  /**
   - Operation variables is functionalities in GraphQL which allow injection of a list of variables on the root operation.
   - Variables are marked with `$` prefix
   - Required/mandatory field have a `!` prefix, optional field have no prefix
   - GraphQL example syntax for variables is `($productId: String!, $isAvailable: Bool, $vendorId: String)`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) { // Here
     product(id: $productId, isAvailable: $isAvailable) {
      name
     }
     vendor(id: $vendorId) {
      name
     }
   }
   ~~~
   */

  func operationVariablesDeclaration(with field: Field, schema: Schema) throws -> [(key: String, value: String)]? {
    var variables = [(String, String)]()

    try field.args.forEach {
      let operationVariableName = try entityNameProvider.operationVariableName(
        with: $0,
        field: field,
        rootField: field
      )
      let key = "$\(operationVariableName)"

      variables.append((key, "\(key): \($0.type.argument)"))
    }

    return variables
  }

  /// Optional variables that might be required depending on the selected fields
  func operationSubVariablesDeclaration(with field: Field, schema: Schema) throws -> [(key: String, value: String)]? {
    var nestedFields = try field.nestedFields(
      objects: schema.objects,
      scalarMap: scalarMap,
      excluded: [],
      selectionMap: selectionMap,
      schemaMap: SchemaMap(schema: schema)
    )

    // Remove the original field as its handled by operationVariablesDeclaration
    if let index = nestedFields.firstIndex(of: field) {
      nestedFields.remove(at: index)
    }

    var variables = [(String, String)]()

    try nestedFields.forEach { nestedField in
      try nestedField.args.forEach {
        let operationVariableName = try entityNameProvider.operationVariableName(
          with: $0,
          field: nestedField,
          rootField: field
        )

        let key = "$\(operationVariableName)"
        variables.append((key, "\(key): \($0.type.argument)"))
      }
    }

    guard !variables.isEmpty else {
      return nil
    }

    return variables
  }

  /**
   - Operation argument is the operation variables passed from the root the selection
   - Operation argument have `$` prefix
   - Example of operation agument is `id: $productId, isAvailable: $isAvailable` and `id: $vendorId`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) {
    product(id: $productId, isAvailable: $isAvailable) { // Here
      name
    }
    vendor(id: $vendorId) { // Here
      name
    }
   }
   ~~~
   */
  func operationArgumentsDeclaration(with field: Field) throws -> [String] {
    try field.args.compactMap {
      let operationVariableName = try entityNameProvider.operationVariableName(
        with: $0,
        field: field,
        rootField: field
      )

      return "\($0.name): $\(operationVariableName)"
    }
  }

  /**
   - Swift argument variables
   */
  func argumentVariablesDeclaration(field: Field, schema: Schema) throws -> String {
    let nestedFields = try field.nestedFields(
      objects: schema.objects,
      scalarMap: scalarMap,
      excluded: [],
      selectionMap: selectionMap,
      schemaMap: SchemaMap(schema: schema)
    )
    let argumentVariables = try nestedFields.compactMap {
      let argumentVariablesDeclaration = try self.argumentVariablesDeclaration(
        field: $0,
        rootField: field
      )

      guard !argumentVariablesDeclaration.isEmpty else {
        return nil
      }

      return argumentVariablesDeclaration.lines
    }.lines

    return argumentVariables
  }
}

private extension RequestVariablesGenerator {
  func argumentVariablesDeclaration(field: Field, rootField: Field) throws -> [String] {
    try field.args.compactMap {
      let typeName = try entityNameProvider.name(for: $0.type)
      let variableName = field.name == rootField.name && field.type == rootField.type
        ? $0.name.camelCase
        // If the variable is a nested query, use rootField and field as prefix to prevent name collision
        : "\(rootField.name.camelCase)\(field.name.pascalCase)\($0.name.pascalCase)"

      return [
        $0.docs,
        "let \(variableName): \(typeName)"
      ]
        .compactMap { $0.isEmpty ? nil : $0 }
      .lines
    }
  }
}
