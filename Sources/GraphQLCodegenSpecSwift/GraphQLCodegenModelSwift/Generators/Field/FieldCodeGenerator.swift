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
  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func variableDeclaration(object: Structure, field: Field) throws -> String? {
    if object.isOperation {
      // If structure is operation, all fields are generated with optional
      let type: String = try entityNameProvider.name(for: field.type)

      return "let \(field.name.camelCase): Optional<\(type)>"
    } else {
      // Else infer optionality from SelectionMap or Schema
      let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

      if isSelectable {
        let type: String = try entityNameProvider.name(for: field.type)

        let texts: [String] = [
          field.docs,
          field.availability,
          "let \(field.name.camelCase): Optional<\(type)>"
        ]

        return texts.filter { !$0.isEmpty }.lines
      } else {
        return nil
      }
    }
  }

  func codingKeyDeclaration(object: Structure, field: Field) -> String? {
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isSelectable {
      return "case \(field.name.camelCase) = \"\(field.name)\""
    } else {
      return nil
    }
  }
}