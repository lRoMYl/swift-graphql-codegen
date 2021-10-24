//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

public extension Field {
  var isOptional: Bool {
    switch type {
    case .nonNull:
      return false
    default:
      return true
    }
  }
}

public extension Structure {
  func isSelectable(field: Field, selectionMap: SelectionMap?) -> Bool {
    guard
      let selectionMap = selectionMap,
      let selectableFields = selectionMap.first(where: { key, _ in key == name })?.value
    else { return true }

    return selectableFields.contains(field.name)
  }

  /*
   Whitelisted fields for selectable field.
   Do not be confused with selectionFields
   */
  func selectableFields(selectionMap: SelectionMap?) -> [Field] {
    fields.filter { field in
      isSelectable(field: field, selectionMap: selectionMap)
    }.sorted(by: .name)
  }
}
