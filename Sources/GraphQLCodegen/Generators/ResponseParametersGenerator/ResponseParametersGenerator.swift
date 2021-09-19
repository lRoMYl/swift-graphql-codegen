//
//  ResponseParameters.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 11/9/21.
//

import Foundation
import GraphQLAST

enum ResponseParametersError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ResponseParametersGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap
  private let selectionsGenerator: ResponseParametersSelectionsGenerator
  private let codingKeysGenerator: ResponseParametersCodingKeysGenerator

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
    self.selectionsGenerator = ResponseParametersSelectionsGenerator(
      scalarMap: scalarMap
    )
    self.codingKeysGenerator = ResponseParametersCodingKeysGenerator()
  }

  func declaration(schema: Schema) throws -> String {
    let responseParameters = try schema.operations.map {
      try operation($0, objects: schema.objects, scalarMap: scalarMap).lines
    }.lines

    return """
    // MARK: - RequestParameters

    \(responseParameters)
    """
  }
}

private extension ResponseParametersGenerator {
  func operation(_ operation: GraphQLAST.Operation, objects: [ObjectType], scalarMap: ScalarMap) throws -> [String] {
    let returnObject = try operation.returnObject()
    let operationTypeName = operation.type.name.lowercased()
    let requestParameterPrefix = operation.requestParameterPrefix

    let result = try returnObject.fields.map {
      try responseParameterDeclaration(
        operationTypeName: operationTypeName,
        requestParameterPrefix: requestParameterPrefix,
        objectMap: objects,
        field: $0
      )
    }

    return result
  }

  func responseParameterDeclaration(
    operationTypeName: String,
    requestParameterPrefix: String,
    objectMap: [ObjectType],
    field: Field
  ) throws -> String {
    let fieldName = field.name.pascalCase
    let reqeuestParametersName = "\(requestParameterPrefix)\(fieldName)RequestParameters"

    let operationVariables = field.operationVariables
    let operationArguments = try field.operationArguments()
    let argumentVariables = try field.argumentVariables(scalarMap: scalarMap)

    let selections = try selectionsGenerator.declaration(operationField: field, objects: objectMap)

    let codingKeys = try codingKeysGenerator.declaration(field: field)

    return """
      // MARK: - \(reqeuestParametersName)

      struct \(reqeuestParametersName): GraphQLRequestParameters {
        private let operationDefinitionFormat: String = \"\"\"
        \(operationTypeName) (\n\(operationVariables)
        ) {
        \(
          """
          \(field.name)(
          \(operationArguments)
          ) {
            ...\(fieldName)Fragment
          }
          """
        )

        %1$@
        \"\"\"

        var operationDefinition: String {
          String(
            format: operationDefinitionFormat,
            selections.declaration()
          )
        }

        // MARK: - Arguments

        \(argumentVariables)

        // MARK: - Request Type

        let requestType: GraphQLRequestType = .\(operationTypeName)

        \(selections)

        \(codingKeys)
      }
      """
  }
}

// MARK: - Operation

private extension GraphQLAST.Operation {
  func returnObject() throws -> ObjectType {
    switch self {
    case let .query(object), let .mutation(object):
      return object
    case .subscription:
      throw ResponseParametersError.notImplemented(context: "Subscription is not implemented yet")
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

// MARK: - Field

private extension Field {
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
  var operationVariables: String {
    args.compactMap {
      switch $0.type {
      case let .named(objectRef):
        let typeName: String
        switch objectRef {
        case let .enum(name), let .inputObject(name), let .scalar(name):
          typeName = name
        }

        return "    $\($0.name): \(typeName)"
      case let .nonNull(objectRef), let .list(objectRef):
        return "    $\($0.name): \(objectRef.argument)!"
      }
    }.lines
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
  func operationArguments() throws -> String {
    args.compactMap {
      return "    \($0.name): $\($0.name)"
    }.lines
  }

  func argumentVariables(scalarMap: ScalarMap) throws -> String {
    try args.compactMap { try $0.argumentVariableDeclaration(scalarMap: scalarMap) }.lines
  }
}

// MARK: - InputValue

private extension InputValue {
  func argumentVariableDeclaration(scalarMap: ScalarMap) throws -> String {
    let typeName = try type.scalarType(scalarMap: scalarMap)

    return """
    \(docs)
    let \(name.camelCase): \(typeName)
    """
  }
}
