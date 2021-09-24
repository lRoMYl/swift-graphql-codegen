//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
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
  private let entityNameMap: EntityNameMap

  init(namespace: String = "", entityNameMap: EntityNameMap) {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
    self.entityNameMap = entityNameMap
  }

  /// TODO: Inject headers, timeoutInterval, preventRetry
  func code(schema: Schema) throws -> String {
    """
    enum \(namespace)Resource: ResourceParameters {
      \(try schema.operations.map { try resourceParametersCases(with: $0).lines }.lines)

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
        \(try schema.operations.map{ try bodyParametersCases(with: $0).lines }.lines)
        }
      }

      private func bodyParameters<T>(request: \(entityNameMap.request)<T>) -> [String: Any] where T: Encodable {
        guard
          let data = try? JSONEncoder().encode(request)
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
      let requestParameterName = field.requestParameterName(with: operation)

      return """
      case \(enumName)(request: \(entityNameMap.request)<\(namespace).\(requestParameterName)>)
      """
    }

    return enumCases
  }

  func bodyParametersCases(with operation: GraphQLAST.Operation) throws -> [String] {
    let enumCases = operation.type.fields.map { field -> String in
      let enumName = field.enumName(with: operation)

      return """
      case let .\(enumName)(request):
        return bodyParameters(request: request)
      """
    }

    return enumCases
  }
}
