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

struct GraphQLResponseWrappedValueGenerator: Generating {
  private let responseEntityName: String

  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameStrategy: EntityNamingStrategy

  init(entityNameMap: EntityNameMap, scalarMap: ScalarMap, entityNameStrategy: EntityNamingStrategy) {
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameStrategy = entityNameStrategy

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
    let operationName: String = try entityNameStrategy.name(for: operation.type)
    let cases = try operation.type.fields.map {
      """
      case is \(try entityNameStrategy.name(for: $0.type)).Type:
        return data.\($0.name.camelCase) as? ReturnType
      """
    }.lines

    return """
    // MARK: - \(responseEntityName)+\(operationName)WrappedValue

    extension \(responseEntityName) where OperationType == \(operationName) {
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
