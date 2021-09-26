//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

enum RepositoryGeneratorError: Error, LocalizedError {
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct RepositoryGenerator: Generating {
  private let namespace: String
  private let namespaceExtension: String
  private let entityNameMap: EntityNameMap

  init(namespace: String, entityNameMap: EntityNameMap) {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
    self.entityNameMap = entityNameMap
  }

  func code(schema: Schema) throws -> String {
    """
    \(try self.protocolCode(with: schema.operations))

    // MARK: - \(namespace)Repositoring

    final class \(namespace)Repository: \(namespace)Repositoring {
      private let restClient: RestClient
      private let scheduler: SchedulerType

      init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.restClient = restClient
        self.scheduler = scheduler
      }

      \(try schema.operations.map { try funcCode(with: $0).lines }.lines)


    }

    private extension \(namespace)Repository {
      \(try schema.operations.map { try executeCode(with: $0) }.lines)
    }
    """
  }
}

extension RepositoryGenerator {
  func protocolCode(with operation: GraphQLAST.Operation) throws -> String {
    let funcDeclarations: [String] = try operation.type.fields.map {
      try funcSignatureCode(field: $0, operation: operation)
    }

    return funcDeclarations.lines
  }

  func protocolCode(with operations: [GraphQLAST.Operation]) throws -> String {
    return """
    protocol \(namespace)Repositoring {
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
        let resource = \(entityNameMap.resourceParametersName(namespace: namespace))
          .\($0.enumName(with: operation))(parameters: parameters)

        return executeGraphQL\(operationName)(resource: resource)
      }
      """
    }

    return codes
  }

  func funcSignatureCode(field: Field, operation: GraphQLAST.Operation) throws -> String {
    let responseDataText = namespaceExtension + field.type.namedType.name.pascalCase

    return """
    func \(field.funcName(with: operation))(
      with parameters: \(namespaceExtension)\(field.requestParameterName(with: operation))
    ) -> \(responseGenericCode(text: responseDataText))
    """
  }

  /// Executation for operation type is generated only if its defined in the schema
  /// E.g. If the schema have no mutation, no mutation object will be present in the schema, thus executeGraphQL cannot be generated respectively
  func executeCode(with operation: GraphQLAST.Operation) throws -> String {
    let operationName = operation.type.name.pascalCase
    let responseDataText = "\(entityNameMap.response)<\(namespaceExtension)\(operationName), T>"

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
