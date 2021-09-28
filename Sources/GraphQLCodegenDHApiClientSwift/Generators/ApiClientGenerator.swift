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
  private let apiClientInterfacePostfix: String = "ApiClientImplementing"
  private let apiClientPostfix: String = "ApiClient"

  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameStrategy: EntityNamingStrategy

  init(entityNameMap: EntityNameMap, scalarMap: ScalarMap, entityNameStrategy: EntityNamingStrategy) {
    self.apiClientPrefix = entityNameMap.apiClientPrefix
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameStrategy = entityNameStrategy
  }

  func code(schema: Schema) throws -> String {
    """
    \(try self.protocolCode(with: schema.operations))

    // MARK: - \(apiClientPrefix)\(apiClientInterfacePostfix)

    final class \(apiClientPrefix)\(apiClientPostfix): \(apiClientPrefix)\(apiClientInterfacePostfix) {
      private let restClient: RestClient
      private let scheduler: SchedulerType

      init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.restClient = restClient
        self.scheduler = scheduler
      }

      \(try schema.operations.map { try funcCode(with: $0).lines }.lines)


    }

    private extension \(apiClientPrefix)\(apiClientPostfix) {
      \(try schema.operations.map { try executeCode(with: $0) }.lines)
    }
    """
  }
}

extension ApiClientGenerator {
  func protocolCode(with operation: GraphQLAST.Operation) throws -> String {
    let funcDeclarations: [String] = try operation.type.fields.map {
      try funcSignatureCode(field: $0, operation: operation)
    }

    return funcDeclarations.lines
  }

  func protocolCode(with operations: [GraphQLAST.Operation]) throws -> String {
    return """
    protocol \(apiClientPrefix)\(apiClientInterfacePostfix) {
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

    let codes = try operation.type.fields.map {
      """
      \(try funcSignatureCode(field: $0, operation: operation)) {
        let resource = \(entityNameMap.resourceParametersName(apiClientPrefix: apiClientPrefix))
          .\($0.enumName(with: operation))(parameters: parameters)

        return executeGraphQL\(operationName)(resource: resource)
      }
      """
    }

    return codes
  }

  func funcSignatureCode(field: Field, operation: GraphQLAST.Operation) throws -> String {
    let responseDataText = try entityNameStrategy.name(for: field.type)

    let parametersName = field.requestEntityObjectParameterName(
      operation: operation,
      entityNameMap: entityNameMap
    )

    return """
    func \(field.funcName(with: operation))(
      with parameters: \(parametersName)
    ) -> \(responseGenericCode(text: responseDataText))
    """
  }

  /// Executation for operation type is generated only if its defined in the schema
  /// E.g. If the schema have no mutation, no mutation object will be present in the schema, thus executeGraphQL cannot be generated respectively
  func executeCode(with operation: GraphQLAST.Operation) throws -> String {
    let operationName = operation.type.name.pascalCase
    let responseType = entityNameMap.objects + "." + operation.type.name.pascalCase
    let responseDataText = "\(entityNameMap.response)<\(responseType), T>"

    return """
    func executeGraphQL\(operationName)<T>(
      resource: ResourceParameters
    ) -> \(responseGenericCode(text: "T")) where T: Codable {
      let request: \(responseGenericCode(text: responseDataText)) = restClient
        .executeRequest(resource: resource)

      return request
        .map { apiResponse in
          return ApiResponse(
            data: apiResponse.data?.wrappedValue,
            httpURLResponse: apiResponse.httpURLResponse,
            metaData: apiResponse.metaData
          )
        }
        .subscribeOn(scheduler)
    }
    """
  }

  func responseGenericCode(text: String) -> String {
    "Single<ApiResponse<\(text)>>"
  }
}
