//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

struct FieldCodeGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
  }

  func variableDeclaration(object: Structure, field: Field) throws -> String {
    let isRequired = object.isRequired(field: field, selectionMap: selectionMap)
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isRequired || isSelectable {
      var type: String = try entityNameStrategy.name(for: field.type)

      if isSelectable && !type.contains("?") {
        type.append("?")
      }

      return """
      \(field.docs)
      \(field.availability)
      let \(field.name.camelCase): \(type)
      """
    } else {
      return ""
    }
  }

  func codingKeyDeclaration(object: Structure, field: Field) -> String {
    let isRequired = object.isRequired(field: field, selectionMap: selectionMap)
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isRequired || isSelectable {
      return "case \(field.name.camelCase) = \"\(field.name)\""
    } else {
      return ""
    }
  }
}
