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

struct GraphQLResponseWrappedValueGenerator: Generating {
  private let namespace: String
  private let namespaceExtension: String
  private let responseEntityName: String

  private let entityNameMap: EntityNameMap

  init(namespace: String = "", entityNameMap: EntityNameMap) {
    self.namespace = namespace
    self.namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."
    self.entityNameMap = entityNameMap

    self.responseEntityName = entityNameMap.response
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
    // MARK: - \(responseEntityName)+\(operationName)WrappedValue

    extension \(responseEntityName) where OperationType == \(namespaceExtension)\(operationName) {
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
