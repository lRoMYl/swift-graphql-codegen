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
  private let entityNameStrategy: EntityNamingStrategy

  private let selectionsGenerator: RequestParameterSelectionsGenerator
  private let codingKeysGenerator: RequestParameterEncodableGenerator
  private let variablesGenerator: RequestParameterVariablesGenerator
  private let operationDefinitionGenerator: RequestParameterOperationDefinitionGenerator
  private let initializerGenerator: RequestParameterInitializerGenerator

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy

    self.selectionsGenerator = RequestParameterSelectionsGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap
    )
    self.codingKeysGenerator = RequestParameterEncodableGenerator()
    self.variablesGenerator = RequestParameterVariablesGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameStrategy: entityNameStrategy
    )
    self.operationDefinitionGenerator = RequestParameterOperationDefinitionGenerator(
      scalarMap: scalarMap,
      variablesGenerator: variablesGenerator
    )
    self.initializerGenerator = RequestParameterInitializerGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameStrategy: entityNameStrategy
    )

    // Initialize entity name variable
    self.entityName = entityNameMap.requestParameter
  }

  func code(schema: Schema) throws -> String {
    let responseParameters = try schema.operations.map {
      let requestEntityObjectName = $0.requestEntityObjectName(entityNameMap: entityNameMap)

      return """
      // MARK: - \(requestEntityObjectName)

      enum \(requestEntityObjectName) {}

      extension \(requestEntityObjectName) {
        \(try operation($0, objects: schema.objects, interfaces: schema.interfaces).lines)
      }
      """
    }.lines

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
    objects: [ObjectType],
    interfaces: [InterfaceType]
  ) throws -> [String] {
    let returnObject = try operation.returnObject()

    let result: [String] = try returnObject.fields.map { field in

      return try requestParameterDeclaration(
        operation: operation,
        objectMap: objects,
        interfaceMap: interfaces,
        scalarMap: scalarMap,
        entityNameMap: entityNameMap,
        field: field
      )
    }

    return result
  }

  func requestParameterDeclaration(
    operation: GraphQLAST.Operation,
    objectMap: [ObjectType],
    interfaceMap: [InterfaceType],
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    field: Field
  ) throws -> String {
    let requestParameterName = field.requestParameterName(operation: operation)

    let operationDefinition = try operationDefinitionGenerator.declaration(
      operation: operation,
      field: field
    )

    let argumentVariables = try variablesGenerator.argumentVariablesDeclaration(
      field: field
    )

    let selections = try selectionsGenerator.declaration(
      field: field,
      objects: objectMap,
      interfaces: interfaceMap
    )

    let codingKeys = try codingKeysGenerator.declaration(field: field)

    let initializer = try initializerGenerator.declaration(field: field)

    let text = """
      // MARK: - \(requestParameterName)

      struct \(requestParameterName): \(entityName) {
        // MARK: - \(entityNameMap.requestType)

        let requestType: \(entityNameMap.requestType) = .\(operation.requestTypeName)

        \(operationDefinition)

        \(argumentVariables)

        \(selections)

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
