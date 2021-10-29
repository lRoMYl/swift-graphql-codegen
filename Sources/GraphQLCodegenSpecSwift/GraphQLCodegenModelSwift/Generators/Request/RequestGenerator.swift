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
import GraphQLCodegenUtil

enum RequestParameterError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct RequestGenerator: GraphQLCodeGenerating {
  private let entityName: String

  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let codingKeysGenerator: RequestEncodableGenerator
  private let variablesGenerator: RequestVariablesGenerator
  private let initializerGenerator: RequestInitializerGenerator
  private let operationDefinitionGenerator: RequestOperationDefinitionGenerator

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

    self.codingKeysGenerator = RequestEncodableGenerator(
      selectionMap: selectionMap,
      scalarMap: scalarMap,
      entityNameProvider: entityNameProvider
    )
    self.variablesGenerator = RequestVariablesGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      selectionMap: selectionMap,
      entityNameProvider: entityNameProvider
    )
    self.initializerGenerator = RequestInitializerGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      selectionMap: selectionMap,
      entityNameProvider: entityNameProvider
    )
    self.operationDefinitionGenerator = RequestOperationDefinitionGenerator(
      variablesGenerator: variablesGenerator,
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

// MARK: - RequestGenerator

private extension RequestGenerator {
  func operation(
    _ operation: GraphQLAST.Operation,
    schema: Schema
  ) throws -> [String] {
    let returnObject = try operation.returnObject()

    var result: [String] = try returnObject.selectableFields(selectionMap: selectionMap).map { field in
      try requestParameterDeclaration(
        operation: operation,
        schema: schema,
        field: field
      )
    }

    result.append(try requestParameterDeclaration(operation: operation, schema: schema))

    return result
  }

  func requestParameterDeclaration(
    operation: GraphQLAST.Operation,
    schema: Schema,
    field: Field
  ) throws -> String {
    let requestParameterName = try entityNameProvider.requestParameterName(for: field, with: operation)
    let rootSelectionKey = try entityNameProvider
      .fragmentName(for: field.type.namedType)
      .map { "\"\(field.name.uppercasedFirstLetter())\($0)\"" } ?? ""

    let argumentVariables = try variablesGenerator.argumentVariablesDeclaration(field: field, schema: schema)

    let codingKeys = try codingKeysGenerator.encodingDeclaration(field: field, schema: schema)

    let initializer = try initializerGenerator.declaration(with: field, schema: schema)

    let operationDefinition = try operationDefinitionGenerator.declaration(
      operation: operation,
      field: field,
      schema: schema
    )

    let operationArgumentCode: String = try variablesGenerator.operationVariablesDeclaration(with: field, schema: schema)
      .map {"\n\($0)"} ?? ""

    let text = """
    /// \(requestParameterName)
    struct \(requestParameterName): \(entityName) {
      // MARK: - \(entityNameMap.requestType)

      let requestType: \(entityNameMap.requestType) = .\(operation.requestTypeName)
      let requestName: String = "\(field.name)"
      let rootSelectionKeys: Set<String> = [\(rootSelectionKey)]

      \(argumentVariables)

      \(codingKeys)

      \(initializer)

      \(operationDefinition)

      func operationArguments() -> String {
        \"\"\"\(operationArgumentCode)
        \"\"\"
      }

      func fragments(with selections: GraphQLSelections) -> String {
        selections.declaration(for: self.requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }
    """

    return text
  }

  func requestParameterDeclaration(
    operation: GraphQLAST.Operation,
    schema _: Schema
  ) throws -> String {
    let returnObject = try operation.returnObject()
    let fields = returnObject.selectableFields(selectionMap: selectionMap)

    let requestParameterName = "\(try entityNameProvider.requestParameterName(with: operation))"
    let fieldsCode: String = try fields.map { field in
      let requestParameterName = try entityNameProvider.requestParameterName(for: field, with: operation)

      return "let \(field.name): \(requestParameterName)?"
    }.lines

    let privateFieldsCode = """
    private var requests: [GraphQLRequesting] {
      let requests: [GraphQLRequesting?] = [
        \(fields.map { $0.name }.joined(separator: ",\n"))
      ]

      return requests.compactMap { $0 }
    }
    """

    let initializer = try initializerGenerator.declaration(with: operation)

    let text = """
    struct \(requestParameterName): \(entityName) {
      let requestType: \(entityNameMap.requestType) = .\(operation.requestTypeName)
      let requestName: String = ""
      var rootSelectionKeys: Set<String> {
        return requests.reduce(into: Set<String>()) { result, request in
          request.rootSelectionKeys.forEach {
            result.insert($0)
          }
        }
      }

      \(fieldsCode)

      \(privateFieldsCode)

      \(initializer)

      func encode(to encoder: Encoder) throws {
        try requests.forEach {
          try $0.encode(to: encoder)
        }
      }

      func operationDefinition() -> String {
        requests
          .map { $0.operationDefinition() }
          .joined(separator: "\\n")
      }

      func operationArguments() -> String {
        requests
        .map { $0.operationArguments() }
        .joined(separator: "\\n")
      }

      func fragments(with selections: GraphQLSelections) -> String {
        requests.map {
          selections.declaration(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
        }.joined(separator: "\\n")
      }
    }
    """

    return text
  }
}
