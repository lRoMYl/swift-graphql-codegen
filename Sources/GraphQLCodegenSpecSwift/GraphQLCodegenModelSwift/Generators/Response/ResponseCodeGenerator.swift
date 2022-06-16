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
  private let selectionMap: SelectionMap?
  private let entityNameProvider: EntityNameProviding

  init(entityNameMap: EntityNameMap, selectionMap: SelectionMap?, entityNameProvider: EntityNameProviding) {
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    return try schema.operations.map {
      try code(operation: $0)
    }.lines
  }
}

extension ResponseCodeGenerator {
  func code(operation: GraphQLAST.Operation) throws -> String {
    try operation.type.selectableFields(selectionMap: selectionMap).map {
      try code(field: $0, operation: operation)
    }.lines
  }

  func code(field: Field, operation: GraphQLAST.Operation) throws -> String {
    return """
    struct \(try entityNameProvider.responseDataName(for: field, with: operation)): \(entityNameProvider.responseType) {
      let \(field.name): \(try entityNameProvider.name(for: field.type))
    }
    """
  }
}
