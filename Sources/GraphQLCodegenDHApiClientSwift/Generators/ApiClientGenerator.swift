//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum ApiClientGeneratorError: Error, LocalizedError {
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ApiClientGenerator: Generating {
  private let apiClientPrefix: String

  private let apiClientName: String
  private let apiClientErrorName: String
  private let apiClientProtocolName: String

  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding

  init(
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    entityNameProvider: EntityNameProviding,
    apiClientPrefix: String
  ) {
    self.apiClientPrefix = apiClientPrefix
    self.apiClientName = entityNameMap.apiClientName(apiClientPrefix: apiClientPrefix)
    self.apiClientErrorName = entityNameMap.apiClientErrorName(apiClientPrefix: apiClientPrefix)
    self.apiClientProtocolName = entityNameMap.apiClientProtocolName(apiClientPrefix: apiClientPrefix)
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let resourceParametersConfigurating = entityNameMap.resourceParametersConfiguratingName(apiClientPrefix: apiClientPrefix)
    let resourceParametersConfiguratorVariable = entityNameMap.resourceParametersConfiguratorVariableName()

    return """
    // MARK: - \(apiClientProtocolName)

    \(try protocolCode(with: schema.operations))

    enum \(apiClientErrorName): Error, LocalizedError {
      case missingData(context: String)

      var errorDescription: String? {
        switch self {
        case let .missingData(context):
          return "\\(Self.self): \\(context)"
        }
      }
    }

    final class \(apiClientName): \(apiClientProtocolName) {
      private let restClient: RestClient
      private let scheduler: SchedulerType
      private let \(resourceParametersConfiguratorVariable): \(resourceParametersConfigurating)?

      init(
        restClient: RestClient,
        scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
        \(resourceParametersConfiguratorVariable): \(resourceParametersConfigurating)? = nil
      ) {
        self.restClient = restClient
        self.scheduler = scheduler
        self.\(resourceParametersConfiguratorVariable) = \(resourceParametersConfiguratorVariable)
      }

      \(try schema.operations.map { try funcCode(with: $0).lines }.lines)
    }

    private extension \(apiClientName) {
      \(try schema.operations.map { try executeCode(with: $0) }.lines)
    }
    """
  }
}

extension ApiClientGenerator {
  func protocolCode(with operation: GraphQLAST.Operation) throws -> String {
    var funcDeclarations: [String] = try operation
      .type
      .selectableFields(selectionMap: selectionMap).map {
        try funcSignatureCode(field: $0, operation: operation)
      }

    funcDeclarations.insert(try funcSignatureCode(operation: operation), at: 0)

    return funcDeclarations.lines
  }

  func protocolCode(with operations: [GraphQLAST.Operation]) throws -> String {
    return """
    protocol \(apiClientProtocolName) {
      \(
        try operations.map {
          try protocolCode(with: $0)
        }.lines
      )
    }
    """
  }

  func funcCode(with operation: GraphQLAST.Operation) throws -> [String] {
    let operationName = operation.type.name.pascalCase
    let resourceParameterName = entityNameMap.resourceParametersName(apiClientPrefix: apiClientPrefix)
    let resourceParametersConfiguratorVariable = entityNameMap.resourceParametersConfiguratorVariableName()

    var codes: [String] = try operation.type.selectableFields(selectionMap: selectionMap).map {
      let funcSignature = try funcSignatureCode(field: $0, operation: operation)
      let enumName = $0.enumName(with: operation)

      return """
      \(funcSignature) {
        let resource = \(resourceParameterName)(
          \(resourceParametersConfiguratorVariable): \(resourceParametersConfiguratorVariable),
          resourceBodyParameters: .\(enumName)(request: request, selections: selections)
        )

        return executeGraphQL\(operationName)(
          resource: resource
        )
      }
      """
    }

    // Root operation
    let responseText = try entityNameProvider.responseDataName(with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"
    let requestQueryName = entityNameProvider.requestQueryName

    codes.append("""
    \(try funcSignatureCode(operation: operation)) {
      let resource = \(resourceParameterName)(
        \(resourceParametersConfiguratorVariable): \(resourceParametersConfiguratorVariable),
        resourceBodyParameters: .\(operation.funcName)(request: request, selections: selections)
      )

      let response: \(responseGenericCode(text: responseDataText)) = executeGraphQLQuery(resource: resource)

      return response
        .map { result in
          let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
            \(
              operation.type.selectableFields(selectionMap: selectionMap).map {
                "(request.\($0.name), result.data?.data?.\($0.name))"
              }.joined(separator: ",\n")
            )
          ]

          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw \(apiClientErrorName).missingData(
                context: "Missing data for \\(request.requestType.rawValue) { \\(request.\(requestQueryName)) }"
              )
            }
          }

          return result
        }
    }
    """)

    return codes
  }

  func funcSignatureCode(field: Field, operation: GraphQLAST.Operation) throws -> String {
    let responseText = try entityNameProvider.responseDataName(for: field, with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"

    let parametersName = try entityNameProvider.requestParameterName(for: field, with: operation)
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)

    return """
    func \(field.funcName())(
      with request: \(parametersName),
      selections: \(selectionsName)
    ) -> \(responseGenericCode(text: responseDataText))
    """
  }

  func funcSignatureCode(operation: GraphQLAST.Operation) throws -> String {
    let responseText = try entityNameProvider.responseDataName(with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"

    let parametersName = try entityNameProvider.requestParameterName(with: operation)
    let selectionsName = try entityNameProvider.selectionsName(with: operation)

    return """
    func \(operation.funcName)(
      with request: \(parametersName),
      selections: \(selectionsName)
    ) -> \(responseGenericCode(text: responseDataText))
    """
  }

  /// Executation for operation type is generated only if its defined in the schema
  /// E.g. If the schema have no mutation, no mutation object will be present in the schema, thus executeGraphQL cannot be generated respectively
  func executeCode(with operation: GraphQLAST.Operation) throws -> String {
    let operationName = operation.type.name.pascalCase
    let genericResponse = "Response"
    let responseDataText = "\(entityNameMap.response)<\(genericResponse)>"
    let responseGenericCode = self.responseGenericCode(text: responseDataText)
    let responseDataGenericCode = self.responseGenericCode(text: responseDataText)

    return """
    func executeGraphQL\(operationName)<\(genericResponse)>(
      resource: ResourceParameters
    ) -> \(responseGenericCode) where \(genericResponse): Codable {
      let request: \(responseDataGenericCode) = restClient
        .executeRequest(resource: resource)

      return request
        .map { apiResponse in
          return ApiResponse(
            data: apiResponse.data,
            httpURLResponse: apiResponse.httpURLResponse,
            metaData: apiResponse.metaData
          )
        }
        .subscribe(on: scheduler)
    }
    """
  }

  func responseGenericCode(text: String) -> String {
    "Single<ApiResponse<\(text)>>"
  }
}
