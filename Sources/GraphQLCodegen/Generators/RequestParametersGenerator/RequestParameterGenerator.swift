//
//  ResponseParameters.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 11/9/21.
//

import Foundation
import GraphQLAST

enum RequestParameterError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct RequestParameterGenerator: GraphQLSpecificationGenerating {
  private let classType = "GraphQLRequestParameter"
  private let classPrefix = "RequestParameter"

  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let selectionsGenerator: RequestParameterSelectionsGenerator
  private let codingKeysGenerator: RequestParameterEncodableGenerator
  private let variablesGenerator: RequestParameterVariablesGenerator
  private let operationDefinitionGenerator: RequestParameterOperationDefinitionGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.selectionsGenerator = RequestParameterSelectionsGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap
    )
    self.codingKeysGenerator = RequestParameterEncodableGenerator()
    self.variablesGenerator = RequestParameterVariablesGenerator(scalarMap: scalarMap)
    self.operationDefinitionGenerator = RequestParameterOperationDefinitionGenerator(
      scalarMap: scalarMap,
      variablesGenerator: variablesGenerator
    )
  }

  func declaration(schema: Schema) throws -> String {
    let responseParameters = try schema.operations.map {
      try operation($0, objects: schema.objects, scalarMap: scalarMap).lines
    }.lines

    return """
    // MARK: - \(classType)

    \(responseParameters)
    """
  }
}

private extension RequestParameterGenerator {
  func operation(_ operation: GraphQLAST.Operation, objects: [ObjectType], scalarMap: ScalarMap) throws -> [String] {
    let returnObject = try operation.returnObject()
    let operationTypeName = operation.type.name.lowercased()

    let result: [String] = try returnObject.fields.map { field in
      let requestParameterName = self.requestParameterName(operation: operation, field: field)

      return try requestParameterDeclaration(
        operationTypeName: operationTypeName,
        requestParameterName: requestParameterName,
        objectMap: objects,
        scalarMap: scalarMap,
        field: field
      )
    }

    return result
  }

  func requestParameterDeclaration(
    operationTypeName: String,
    requestParameterName: String,
    objectMap: [ObjectType],
    scalarMap: ScalarMap,
    field: Field
  ) throws -> String {
    let operationDefinition = try operationDefinitionGenerator.declaration(operationTypeName: operationTypeName, field: field)

    let argumentVariables = try variablesGenerator.argumentVariablesDeclaration(with: field)

    let selections = try selectionsGenerator.declaration(operationField: field, objects: objectMap)

    let codingKeys = try codingKeysGenerator.declaration(field: field)

    let text = """
      // MARK: - \(requestParameterName)

      struct \(requestParameterName): \(classType) {
        // MARK: - Request Type

        let requestType: GraphQLRequestType = .\(operationTypeName)

        \(operationDefinition)

        \(argumentVariables)

        \(selections)

        \(codingKeys)
      }
      """

    return text
  }

  func requestParameterName(operation: GraphQLAST.Operation, field: Field) -> String {
    let requestParameterPrefix = operation.requestParameterPrefix
    let fieldName = field.name.pascalCase

    return "\(requestParameterPrefix)\(fieldName)\(classPrefix)"
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

  /// Custom name prefix to prevent collision for the same operation object for Query, Mutation and Subscription
  var requestParameterPrefix: String {
    switch self {
    case .query:
      return ""
    case .mutation:
      return "Update"
    case .subscription:
      return "Subscribe"
    }
  }
}
