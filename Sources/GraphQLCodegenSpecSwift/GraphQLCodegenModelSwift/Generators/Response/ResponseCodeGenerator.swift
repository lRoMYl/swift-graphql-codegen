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
    let responseName = try entityNameProvider.responseDataName(for: field, with: operation).pascalCase
    let fieldName = field.name.camelCase

    return """
    struct \(responseName): \(entityNameProvider.responseType) {
      let \(fieldName): \(try entityNameProvider.name(for: field.type))
    }
    """
  }
}
