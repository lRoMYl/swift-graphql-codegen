//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

extension Field {
  var isOptional: Bool {
    switch type {
    case .nonNull:
      return false
    default:
      return true
    }
  }
}

extension Structure {
  func isRequired(field: Field, selectionMap: SelectionMap?) -> Bool {
    return false
  }

  func isSelectable(field: Field, selectionMap: SelectionMap?) -> Bool {
    return true
  }

  /*
   Whitelisted fields for selectable field.
   Do not be confused with selectionFields
   */
  func selectableFields(selectionMap: SelectionMap?) -> [Field] {
    fields.filter { field in
      isSelectable(field: field, selectionMap: selectionMap)
    }.sorted()
  }

  func requiredFields(selectionMap: SelectionMap?) -> [Field] {
    fields.filter { field in
      isRequired(field: field, selectionMap: selectionMap)
    }.sorted()
  }
}
