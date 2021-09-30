//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct ResponseCodeGenerator: GraphQLCodeGenerating {
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  init(entityNameMap: EntityNameMap, entityNameStrategy: EntityNamingStrategy) {
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
  }

  func code(schema: Schema) throws -> String {
    return try schema.operations.map {
      try code(operation: $0)
    }.lines
  }
}

extension ResponseCodeGenerator {
  func code(operation: GraphQLAST.Operation) throws -> String {
    try operation.type.fields.map {
      try code(field: $0, operation: operation)
    }.lines
  }

  func code(field: Field, operation: GraphQLAST.Operation) throws -> String {
    return """
    struct \(try entityNameStrategy.responseDataName(for: field, with: operation)): \(entityNameMap.responseData) {
      let \(field.name): \(try entityNameStrategy.name(for: field.type))

      var wrappedValue: \(try entityNameStrategy.name(for: field.type)) {
        return \(field.name)
      }
    }
    """
  }
}
