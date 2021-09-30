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
    try operation.type.fields.map {
      try wrappedValueCode(field: $0, operation: operation)
    }.lines
  }

  func wrappedValueCode(field: Field, operation: GraphQLAST.Operation) throws -> String {
    return """
    extension GraphQLResponse where ResponseData == \(field.name.pascalCase)\(operation.type.name.pascalCase)Response {
      var wrappedValue: ReturnType? {
        return data.\(field.name) as? ReturnType
      }
    }
    """
  }
}
