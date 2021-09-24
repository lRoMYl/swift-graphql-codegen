//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
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

  init(namespace: String = "") {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
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

      \(try schema.operations.map { try executeCode(with: $0) }.lines)
    }
    """
  }
}

private extension Field {
  func funcSignatureCode(namespaceExtension: String) throws -> String {
    """
    func \(name.camelCase)(
      with request: GraphQLRequest<\(namespaceExtension)\(name.pascalCase)RequestParameter>
    ) -> Single<ApiResponse<\(namespaceExtension)\(name.pascalCase)>>
    """
  }
}

extension RepositoryGenerator {
  func protocolCode(with operation: GraphQLAST.Operation) throws -> String {
    let funcDeclarations: [String]

    switch operation {
    case let .query(objectType):
      funcDeclarations = try objectType.fields.map {
        try $0.funcSignatureCode(namespaceExtension: namespaceExtension)
      }
    case let .mutation(objectType):
      funcDeclarations = []
    case .subscription:
      throw RepositoryGeneratorError.notImplemented(
        context: "Subscription is not implemented"
      )
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

    switch operation {
    case let .query(objectType):
      return try objectType.fields.map {
        """
        \(try $0.funcSignatureCode(namespaceExtension: namespaceExtension)) {
          let resource = \(namespace)Resource.campaigns(request: request)

          return executeGraphQL\(operationName)(resource: resource)
        }
        """
      }
    case let .mutation(objectType):
      return []
    case .subscription:
      throw RepositoryGeneratorError.notImplemented(
        context: "Subscription is not implemented"
      )
    }
  }

  /// Executation for operation type is generated only if its defined in the schema
  /// E.g. If the schema have no mutation, no mutation object will be present in the schema, thus executeGraphQL cannot be generated respectively
  func executeCode(with operation: GraphQLAST.Operation) throws -> String {
    let operationName = operation.type.name.pascalCase

    return """
    func executeGraphQL\(operationName)<T>(
      resource: ResourceParameters
    ) -> Single<ApiClient.ApiResponse<T>> where T: Codable {
      let graphQLRequest: Single<ApiResponse<GraphQLResponse<\(namespaceExtension)\(operationName), T>>> = restClient
        .executeRequest(resource: resource)

      return graphQLRequest
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
}
