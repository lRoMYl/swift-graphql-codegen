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

enum ResourceGeneratorError: Error, LocalizedError {
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ResourceParametersGenerator: Generating {
  private let namespace: String
  private let namespaceExtension: String
  private let repositoryPrefix: String

  private let entityNameMap: EntityNameMap

  init(namespace: String = "", entityNameMap: EntityNameMap) {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
    self.repositoryPrefix = entityNameMap.repositoryPrefix
    self.entityNameMap = entityNameMap
  }

  /// TODO: Inject headers, timeoutInterval, preventRetry
  func code(schema: Schema) throws -> String {
    let diContainerName = entityNameMap.resourceParametersDIContainer(repositoryPrefix: repositoryPrefix)
    let resourceParametersName = entityNameMap.resourceParametersName(repositoryPrefix: repositoryPrefix)
    let resourceParameterImplementing = entityNameMap.resourceParametersImplementing(repositoryPrefix: repositoryPrefix)

    return """

    // MARK: - \(resourceParametersName)

    protocol \(resourceParameterImplementing) {
      func servicePath(with resourceParameters: \(resourceParametersName)) -> String
      func headers(with resourceParameters: \(resourceParametersName)) -> [String: String]?
      func timeoutInterval(with resourceParameters: \(resourceParametersName)) -> TimeInterval?
      func preventRetry(with resourceParameters: \(resourceParametersName)) -> Bool
      func preventAddingLanguageParameters(with resourceParameters: \(resourceParametersName)) -> Bool
    }

    final class \(diContainerName) {
      static let shared = \(diContainerName)()

      var implementation: \(resourceParameterImplementing)?
    }

    enum \(resourceParametersName): ResourceParameters {
      private static var diContainer = \(diContainerName).shared

      \(try schema.operations.map { try resourceParametersCases(with: $0).lines }.lines)

      func bodyFormat() -> HttpBodyFormat {
        .JSON
      }

      func httpMethod() -> RequestHttpMethod {
        .post
      }

      func servicePath() -> String {
        Self.diContainer.implementation?.servicePath(with: self) ?? ""
      }

      func headers() -> [String: String]? {
        Self.diContainer.implementation?.headers(with: self) ?? nil
      }

      func timeoutInterval() -> TimeInterval? {
        Self.diContainer.implementation?.timeoutInterval(with: self) ?? nil
      }

      func preventRetry() -> Bool {
        Self.diContainer.implementation?.preventRetry(with: self) ?? false
      }

      func preventAddingLanguageParameters() -> Bool {
        Self.diContainer.implementation?.preventAddingLanguageParameters(with: self) ?? false
      }

      func bodyParameters() -> Any? {
        switch self {
        \(try schema.operations.map{ try bodyParametersCases(with: $0).lines }.lines)
        }
      }

      private func bodyParameters<T>(parameters: T) -> [String: Any] where T: GraphQLRequestParameter {
        guard
          let data = try? JSONEncoder().encode(\(entityNameMap.request)(parameters: parameters))
        else { return [:]  }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
          .flatMap {
            $0 as? [String: Any]
          } ?? [:]
      }
    }
    """
  }
}

extension ResourceParametersGenerator {
  func resourceParametersCases(with operation: GraphQLAST.Operation) throws -> [String] {
    let enumCases = operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)
      let requestParameterName = namespaceExtension +
        field.requestEntityObjectParameterName(operation: operation, entityNameMap: entityNameMap)

      return """
      case \(enumName)(parameters: \(requestParameterName))
      """
    }

    return enumCases
  }

  func bodyParametersCases(with operation: GraphQLAST.Operation) throws -> [String] {
    let enumCases = operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)

      return """
      case let .\(enumName)(parameters):
        return bodyParameters(parameters: parameters)
      """
    }

    return enumCases
  }
}
