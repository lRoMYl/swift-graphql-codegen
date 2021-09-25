//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct FieldCodeGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
  }

  func variableDeclaration(object: Structure, field: Field) throws -> String {
    let isRequired = object.isRequired(field: field, selectionMap: selectionMap)
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isRequired || isSelectable {
      let type: String
      if isRequired {
        let scalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
        type = field.type.type(for: scalarType)
      } else {
        var scalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
        if !scalarType.contains("?") {
          scalarType.append("?")
        }

        type = scalarType
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
