//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum ObjectCodeGeneratorError: Error, LocalizedError {
  case emptyFields(name: String)

  var errorDescription: String? {
    switch self {
    case let .emptyFields(name):
      return "\(Self.self): No fields was whitelisted for \(name) object"
    }
  }
}

struct ObjectCodeGenerator: GraphQLCodeGenerating {
  private let isThrowableGetterEnabled: Bool
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(
    isThrowableGetterEnabled: Bool,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) {
    self.isThrowableGetterEnabled = isThrowableGetterEnabled
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
    let schemaMap = try SchemaMap(schema: schema)

    let objects = try schema.operations.map {
      try $0.returnObject()
        .nestedFields(schema: schema, scalarMap: scalarMap, selectionMap: selectionMap)
        .unique(by: { $0.type.namedType.name })
        .sorted(by: .namedType)
        .compactMap {
          try $0.returnObjectType(schemaMap: schemaMap)
        }
    }
      .reduce([], +)

    let code = try objects.map {
      try declaration($0)
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.object)

    \(code)

    """
  }
}

extension ObjectCodeGenerator {
  func declaration(_ objectType: ObjectType) throws -> String {
    let sortedFields = objectType.isOperation
      ? objectType.selectableFields(selectionMap: selectionMap).sorted(by: .name)
      : objectType.selectableFields(selectionMap: selectionMap)

    let fieldsVariable = try sortedFields
      .compactMap { try fieldSpecificationGenerator.internalVariableDeclaration(object: objectType, field: $0) }
      .joined(separator: "\n")
    let fieldsVariableFunction = try sortedFields
      .compactMap {
        try fieldSpecificationGenerator.publicVariableDeclaration(
          object: objectType,
          field: $0,
          isThrowableGetterEnabled: isThrowableGetterEnabled
        )
      }
      .joined(separator: "\n\n")
    let initializer = try fieldSpecificationGenerator.initializerDeclaration(with: objectType, fields: sortedFields)

    let fieldsCodingKey = try sortedFields
      .compactMap { try fieldSpecificationGenerator.codingKeyDeclaration(object: objectType, field: $0) }
      .lines

    guard !fieldsCodingKey.isEmpty || !fieldsCodingKey.isEmpty else {
      throw ObjectCodeGeneratorError.emptyFields(name: objectType.name)
    }

    let responseName = try entityNameProvider.name(for: objectType)

    // Due to a PD-Kami requiring the ApiModel to be Codable, we cannot generate an object
    // with Decodable conformance
    return """
    struct \(responseName): Codable {
      \(fieldsVariable)

      \(fieldsVariableFunction)

      \(initializer)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
