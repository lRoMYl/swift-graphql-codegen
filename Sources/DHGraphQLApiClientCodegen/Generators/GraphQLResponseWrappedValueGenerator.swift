//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenUtil

struct GraphQLResponseWrappedValueGenerator: Generating {
  private let namespace: String
  private let namespaceExtension: String

  init(namespace: String = "") {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
  }

  func code(schema: Schema) throws -> String {
    """
    \(try schema.operations.map { try wrappedValueCode(with: $0) }.lines)
    """
  }
}

extension GraphQLResponseWrappedValueGenerator {
  func wrappedValueCode(with operation: GraphQLAST.Operation) throws -> String {
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
