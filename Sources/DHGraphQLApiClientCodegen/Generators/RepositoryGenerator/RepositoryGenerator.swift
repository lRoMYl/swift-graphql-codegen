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
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import ApiClient
    import RxSwift

    \(try self.protocolDeclaration(operations: schema.operations))

    // MARK: - \(namespace)Repositoring

    final class \(namespace)Repository: \(namespace)Repositoring {
      private let restClient: RestClient
      private let scheduler: SchedulerType

      init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        self.restClient = restClient
        self.scheduler = scheduler
      }

      \(try schema.operations.map { try declaration(operation: $0).lines }.lines)

      \(try schema.operations.map { try executeDeclaration(operation: $0) }.lines)
    }

    enum \(namespace)Resource: ResourceParameters {
      case campaigns(request: GraphQLRequest<\(namespace).CampaignsRequestParameter>)

      func bodyFormat() -> HttpBodyFormat {
        .JSON
      }

      func httpMethod() -> RequestHttpMethod {
        .post
      }

      func servicePath() -> String {
        "query"
      }

      func headers() -> [String: String]? {
        [:]
      }

      func timeoutInterval() -> TimeInterval? {
        nil
      }

      func preventRetry() -> Bool {
        true
      }

      func bodyParameters() -> Any? {
        switch self {
        case let .campaigns(request):
          let bodyParameters = request.bodyParameters()
          return bodyParameters
        }
      }
    }

    \(try schema.operations.map { try wrappedValue(operation: $0) }.lines)
    """
  }
}

private extension Field {
  func funcDeclaration(namespaceExtension: String) throws -> String {
    """
    func \(name.camelCase)(
      with request: GraphQLRequest<\(namespaceExtension)\(name.pascalCase)RequestParameter>
    ) -> Single<ApiResponse<\(namespaceExtension)\(name.pascalCase)>>
    """
  }
}

extension RepositoryGenerator {
  func protocolDeclaration(operation: GraphQLAST.Operation) throws -> String {
    let funcDeclarations: [String]

    switch operation {
    case let .query(objectType):
      funcDeclarations = try objectType.fields.map {
        try $0.funcDeclaration(namespaceExtension: namespaceExtension)
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

  func protocolDeclaration(operations: [GraphQLAST.Operation]) throws -> String {
    return """
    protocol \(namespace)Repositoring {
      \(
        try operations.map {
          try protocolDeclaration(operation: $0)
        }.lines
      )
    }
    """
  }

  func declaration(operation: GraphQLAST.Operation) throws -> [String] {
    switch operation {
    case let .query(objectType):
      return try objectType.fields.map {
        """
        \(try $0.funcDeclaration(namespaceExtension: namespaceExtension)) {
          let resource = \(namespace)Resource.campaigns(request: request)

          return executeGraphQLQuery(resource: resource)
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
  func executeDeclaration(operation: GraphQLAST.Operation) throws -> String {
    let operationName: String = operation.type.name.pascalCase

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

  func wrappedValue(operation: GraphQLAST.Operation) throws -> String {
    let operationName: String = operation.type.name.pascalCase
    let cases = operation.type.fields.map {
      """
      case is \(namespaceExtension)\($0.name.pascalCase).Type:
        return data.\($0.name.camelCase) as? ReturnType
      """
    }.lines

    return """
    // MARK: - GraphQLResponse+\(operationName)WrappedValue

    extension GraphQLResponse where OperationType == \(namespaceExtension)\(operationName) {
      var wrappedValue: ReturnType? {
        switch ReturnType.self {
        \(cases)
        default:
          return nil
        }
      }
    }
    """
  }
}
