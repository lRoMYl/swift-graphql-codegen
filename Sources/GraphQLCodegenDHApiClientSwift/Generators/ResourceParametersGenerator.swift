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

enum ResourceGeneratorError: Error, LocalizedError {
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ResourceParametersGenerator: Generating {
  private let apiClientPrefix: String

  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameStrategy: EntityNamingStrategy

  init(entityNameMap: EntityNameMap, scalarMap: ScalarMap, entityNameStrategy: EntityNamingStrategy) {
    self.apiClientPrefix = entityNameMap.apiClientPrefix
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameStrategy = entityNameStrategy
  }

  /// TODO: Inject headers, timeoutInterval, preventRetry
  func code(schema: Schema) throws -> String {
    let diContainerName = entityNameMap.resourceParametersDIContainer(apiClientPrefix: apiClientPrefix)
    let resourceParametersName = entityNameMap.resourceParametersName(apiClientPrefix: apiClientPrefix)
    let resourceParameterProviding = entityNameMap.resourceParametersProviding(apiClientPrefix: apiClientPrefix)

    return """

    // MARK: - \(resourceParametersName)

    protocol \(resourceParameterProviding) {
      func servicePath(with resourceParameters: \(resourceParametersName)) -> String
      func headers(with resourceParameters: \(resourceParametersName)) -> [String: String]?
      func timeoutInterval(with resourceParameters: \(resourceParametersName)) -> TimeInterval?
      func preventRetry(with resourceParameters: \(resourceParametersName)) -> Bool
      func preventAddingLanguageParameters(with resourceParameters: \(resourceParametersName)) -> Bool
    }

    final class \(diContainerName) {
      static let shared = \(diContainerName)()

      var providing: \(resourceParameterProviding)?
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
        Self.diContainer.providing?.servicePath(with: self) ?? ""
      }

      func headers() -> [String: String]? {
        Self.diContainer.providing?.headers(with: self) ?? nil
      }

      func timeoutInterval() -> TimeInterval? {
        Self.diContainer.providing?.timeoutInterval(with: self) ?? nil
      }

      func preventRetry() -> Bool {
        Self.diContainer.providing?.preventRetry(with: self) ?? false
      }

      func preventAddingLanguageParameters() -> Bool {
        Self.diContainer.providing?.preventAddingLanguageParameters(with: self) ?? false
      }

      func bodyParameters() -> Any? {
        switch self {
        \(try schema.operations.map{ try bodyParametersCases(with: $0).lines }.lines)
        }
      }

      private func bodyParameters<T>(parameters: T) -> [String: Any] where T: \(entityNameMap.requestParameter) {
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
    let enumCases = try operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)
      let requestParameterName = try entityNameStrategy.requestParameterName(for: field, with: operation)

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
