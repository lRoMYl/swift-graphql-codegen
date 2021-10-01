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
    switch self.type {
    case .nonNull:
      return false
    default:
      return true
    }
  }
}

extension Structure {
  /*
   Whitelisted field for selections.

   If selectionMap and selectionItemMap is not nil, the fields will be on a whitelisted basis
   and any fields not in the `required`, `selectable` will not be available in the generated model

   However, if the selectionItemMap is empty then all the fields are whitelisted by default
   */
  func selectionFields(with selectionMap: SelectionMap?) -> [Field] {
    guard
      let selectionMap = selectionMap,
      let selectionItemMap = selectionMap[name]
    else { return fields }

    return fields.filter {
      selectionItemMap.required.contains($0.name) ||
        selectionItemMap.selectable.contains($0.name)
    }
  }

  func isRequired(field: Field, selectionMap: SelectionMap?) -> Bool {
    guard let selectionMap = selectionMap, let selectionItemMap = selectionMap[name] else {
      return !field.isOptional
    }

    return selectionItemMap.required.contains(field.name)
  }

  func isSelectable(field: Field, selectionMap: SelectionMap?) -> Bool {
    guard let selectionMap = selectionMap, let selectionItemMap = selectionMap[name] else {
      return field.isOptional
    }

    return selectionItemMap.selectable.contains(field.name)
  }

  /*
   Whitelisted fields for selectable field.
   Do not be confused with selectionFields
   */
  func selectableFields(selectionMap: SelectionMap?) -> [Field] {
    fields.filter { field in
      let isSelectable = self.isSelectable(field: field, selectionMap: selectionMap)

      return isSelectable
    }.sorted(by: { $0.name < $1.name })
  }

	func requiredFields(selectionMap: SelectionMap?) -> [Field] {
		fields.filter { field in
			return isRequired(field: field, selectionMap: selectionMap)
		}.sorted(by: { $0.name < $1.name })
	}
}
