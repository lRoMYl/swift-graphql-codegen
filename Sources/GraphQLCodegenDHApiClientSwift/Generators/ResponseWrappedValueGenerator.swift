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
  private let responseEntityName: String

  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap

  init(entityNameMap: EntityNameMap, scalarMap: ScalarMap) {
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap

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
    let operationName: String = entityNameMap.objects + "." + operation.type.name.pascalCase
    let cases = try operation.type.fields.map {
      """
      case is \(try $0.type.namedType.type(scalarMap: scalarMap, entityNameMap: entityNameMap)).Type:
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
