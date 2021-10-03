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
  private let entityNameProvider: EntityNameProviding

  init(entityNameMap: EntityNameMap, scalarMap: ScalarMap, entityNameProvider: EntityNameProviding) {
    self.apiClientPrefix = entityNameMap.apiClientPrefix
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let resourceParametersName = entityNameMap.resourceParametersName(apiClientPrefix: apiClientPrefix)
    let resourceBodyParametersName = entityNameMap.resourceBodyParametersName(apiClientPrefix: nil)
    let resourceBodyParametersNameWithPrefix = entityNameMap.resourceBodyParametersName(apiClientPrefix: apiClientPrefix)
    let resourceParameterProviding = entityNameMap.resourceParametersProviding(apiClientPrefix: apiClientPrefix)

    return """

    // MARK: - \(resourceParametersName)

    protocol \(resourceParameterProviding) {
      func servicePath(with resourceParameters: \(resourceBodyParametersNameWithPrefix)) -> String
      func headers(with resourceParameters: \(resourceBodyParametersNameWithPrefix)) -> [String: String]?
      func timeoutInterval(with resourceParameters: \(resourceBodyParametersNameWithPrefix)) -> TimeInterval?
      func preventRetry(with resourceParameters: \(resourceBodyParametersNameWithPrefix)) -> Bool
      func preventAddingLanguageParameters(with resourceParameters: \(resourceBodyParametersNameWithPrefix)) -> Bool
    }

    struct \(resourceParametersName): ResourceParameters {
      enum \(resourceBodyParametersName) {
        \(try schema.operations.map { try resourceParametersCases(with: $0).lines }.lines)

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

      private let provider: \(resourceParameterProviding)?
      private let resourceBodyParameters: \(resourceBodyParametersName)

      init(
        provider: \(resourceParameterProviding)?,
        resourceBodyParameters: \(resourceBodyParametersName)
      ) {
        self.provider = provider
        self.resourceBodyParameters = resourceBodyParameters
      }

      func bodyFormat() -> HttpBodyFormat {
        .JSON
      }

      func httpMethod() -> RequestHttpMethod {
        .post
      }

      func servicePath() -> String {
        provider?.servicePath(with: resourceBodyParameters) ?? ""
      }

      func headers() -> [String: String]? {
        provider?.headers(with: resourceBodyParameters) ?? nil
      }

      func timeoutInterval() -> TimeInterval? {
        provider?.timeoutInterval(with: resourceBodyParameters) ?? nil
      }

      func preventRetry() -> Bool {
        provider?.preventRetry(with: resourceBodyParameters) ?? false
      }

      func preventAddingLanguageParameters() -> Bool {
        provider?.preventAddingLanguageParameters(with: resourceBodyParameters) ?? false
      }

      func bodyParameters() -> Any? {
        return resourceBodyParameters.bodyParameters()
      }
    }
    """
  }
}

extension ResourceParametersGenerator {
  func resourceParametersCases(with operation: GraphQLAST.Operation) throws -> [String] {
    let enumCases = try operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)
      let requestParameterName = try entityNameProvider.requestParameterName(for: field, with: operation)

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
