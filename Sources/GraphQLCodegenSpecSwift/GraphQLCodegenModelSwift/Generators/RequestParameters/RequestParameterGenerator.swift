//
//  ResponseParameters.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 11/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

enum RequestParameterError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct RequestParameterGenerator: GraphQLCodeGenerating {
  private let entityName: String

  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let codingKeysGenerator: RequestParameterEncodableGenerator
  private let variablesGenerator: RequestVariablesGenerator
  private let initializerGenerator: RequestParameterInitializerGenerator

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

    self.codingKeysGenerator = RequestParameterEncodableGenerator()
    self.variablesGenerator = RequestVariablesGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
    self.initializerGenerator = RequestParameterInitializerGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )

    // Initialize entity name variable
    self.entityName = entityNameMap.requestParameter
  }

  func code(schema: Schema) throws -> String {
    let responseParameters = try schema.operations.map {
      """
      \(try operation($0, schema: schema).lines)
      """
    }.lines

    guard !responseParameters.isEmpty else { return "" }

    return """
    // MARK: - \(entityName)

    \(responseParameters)
    """
  }
}

// MARK: - RequestParameterGenerator

private extension RequestParameterGenerator {
  func operation(
    _ operation: GraphQLAST.Operation,
    schema: Schema
  ) throws -> [String] {
    let returnObject = try operation.returnObject()

    let result: [String] = try returnObject.fields.map { field in
      try requestParameterDeclaration(
        operation: operation,
        schema: schema,
        scalarMap: scalarMap,
        entityNameMap: entityNameMap,
        field: field
      )
    }

    return result
  }

  func requestParameterDeclaration(
    operation: GraphQLAST.Operation,
    schema _: Schema,
    scalarMap _: ScalarMap,
    entityNameMap: EntityNameMap,
    field: Field
  ) throws -> String {
    let requestParameterName = try entityNameProvider.requestParameterName(for: field, with: operation)

    let argumentVariables = try variablesGenerator.argumentVariablesDeclaration(
      field: field
    )

    let codingKeys = try codingKeysGenerator.declaration(field: field)

    let initializer = try initializerGenerator.declaration(field: field)

    let text = """
    /// \(requestParameterName)
    struct \(requestParameterName): \(entityName) {
      // MARK: - \(entityNameMap.requestType)

      let requestType: \(entityNameMap.requestType) = .\(operation.requestTypeName)

      \(argumentVariables)

      \(codingKeys)

      \(initializer)
    }
    """

    return text
  }
}

// MARK: - Operation

private extension GraphQLAST.Operation {
  func returnObject() throws -> ObjectType {
    switch self {
    case let .query(object), let .mutation(object):
      return object
    case let .subscription(object):
      print("Warning, subscription is not implemented yet")
      return object
    }
  }
}
