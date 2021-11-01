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

  init(
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    entityNameProvider: EntityNameProviding,
    apiClientPrefix: String
  ) {
    self.apiClientPrefix = apiClientPrefix
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let resourceParametersName = entityNameMap.resourceParametersName(apiClientPrefix: apiClientPrefix)
    let resourceBodyParametersName = entityNameMap.resourceBodyParametersName(apiClientPrefix: nil)
    let resourceBodyParametersNameWithPrefix = entityNameMap.resourceBodyParametersName(apiClientPrefix: apiClientPrefix)
    let resourceParameterConfigurating = entityNameMap.resourceParametersConfiguratingName(apiClientPrefix: apiClientPrefix)
    let resourceParameterConfiguratorVariable = entityNameMap.resourceParametersConfiguratorVariableName()
    let selectionsName = entityNameMap.selections
    let requestParameterName = entityNameMap.requestParameter

    return """

    // MARK: - \(resourceParametersName)

    protocol \(resourceParameterConfigurating) {
      func servicePath(with bodyParameters: \(resourceBodyParametersNameWithPrefix)) -> String
      func headers(with bodyParameters: \(resourceBodyParametersNameWithPrefix)) -> [String: String]?
      func timeoutInterval(with bodyParameters: \(resourceBodyParametersNameWithPrefix)) -> TimeInterval?
      func preventRetry(with bodyParameters: \(resourceBodyParametersNameWithPrefix)) -> Bool
      func preventAddingLanguageParameters(with bodyParameters: \(resourceBodyParametersNameWithPrefix)) -> Bool
    }

    struct \(resourceParametersName): ResourceParameters {
      enum \(resourceBodyParametersName) {
        \(try schema.operations.map { try resourceParametersCases(with: $0).lines }.lines)

        func bodyParameters() -> Any? {
          switch self {
          \(try schema.operations.map { try bodyParametersCases(with: $0).lines }.lines)
          }
        }

        private func bodyParameters<T>(request: T, selections: \(selectionsName)) -> [String: Any] where T: \(requestParameterName) {
          guard
            let data = try? JSONEncoder().encode(\(entityNameMap.request)(parameters: request, selections: selections))
          else { return [:] }

          return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap {
              $0 as? [String: Any]
            } ?? [:]
        }
      }

      private let \(resourceParameterConfiguratorVariable): \(resourceParameterConfigurating)?
      private let resourceBodyParameters: \(resourceBodyParametersName)

      init(
        \(resourceParameterConfiguratorVariable): \(resourceParameterConfigurating)?,
        resourceBodyParameters: \(resourceBodyParametersName)
      ) {
        self.\(resourceParameterConfiguratorVariable) = \(resourceParameterConfiguratorVariable)
        self.resourceBodyParameters = resourceBodyParameters
      }

      func bodyFormat() -> HttpBodyFormat {
        .JSON
      }

      func httpMethod() -> RequestHttpMethod {
        .post
      }

      func servicePath() -> String {
        \(resourceParameterConfiguratorVariable)?.servicePath(with: resourceBodyParameters) ?? ""
      }

      func headers() -> [String: String]? {
        \(resourceParameterConfiguratorVariable)?.headers(with: resourceBodyParameters) ?? nil
      }

      func timeoutInterval() -> TimeInterval? {
        \(resourceParameterConfiguratorVariable)?.timeoutInterval(with: resourceBodyParameters) ?? nil
      }

      func preventRetry() -> Bool {
        \(resourceParameterConfiguratorVariable)?.preventRetry(with: resourceBodyParameters) ?? false
      }

      func preventAddingLanguageParameters() -> Bool {
        \(resourceParameterConfiguratorVariable)?.preventAddingLanguageParameters(with: resourceBodyParameters) ?? false
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
    var enumCases = try operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)
      let requestParameterName = try entityNameProvider.requestParameterName(for: field, with: operation)
      let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)

      return """
      case \(enumName)(request: \(requestParameterName), selections: \(selectionsName))
      """
    }

    let requestName = try entityNameProvider.requestParameterName(with: operation)
    let selectionsName = try entityNameProvider.selectionsName(with: operation)
    enumCases.append(
      "case \(operation.funcName)(request: \(requestName), selections: \(selectionsName))"
    )

    return enumCases
  }

  func bodyParametersCases(with operation: GraphQLAST.Operation) throws -> [String] {
    let selectionsName = entityNameMap.selections

    var enumCases = operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)

      return """
      case let .\(enumName)(request, selections):
        return bodyParameters(request: request, selections: selections as \(selectionsName))
      """
    }

    enumCases.append(
      """
      case let .\(operation.funcName)(request, selections):
        return bodyParameters(request: request, selections: selections as \(selectionsName))
      """
    )

    return enumCases
  }
}
