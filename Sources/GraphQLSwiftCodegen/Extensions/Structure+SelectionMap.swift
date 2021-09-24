//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLAST

extension Structure {
  func isRequired(field: Field, selectionMap: SelectionMap?) -> Bool {
    // By default, if selection map is nil all field is treated as required
    guard let selectionMap = selectionMap else {
      return true
    }

    // If selection map is present but no selectionItemMap is not found, this field is required
    guard let selectionItemMap = selectionMap[name] else {
      return true
    }

    return selectionItemMap.required.contains(field.name)
  }

  func isSelectable(field: Field, selectionMap: SelectionMap?) -> Bool {
    // By default, if selection map is nil all field is treated as required
    guard let selectionMap = selectionMap else {
      return false
    }

    // If selection map is present but no selectionItemMap is found, this field is not selectable
    guard let selectionItemMap = selectionMap[name] else {
      return false
    }

    return selectionItemMap.selectable.contains(field.name)
  }

  func selectableFields(objects: [ObjectType], selectionMap: SelectionMap?) -> [Field] {
    fields.filter { field in
      let isRequired = self.isRequired(field: field, selectionMap: selectionMap)
      let isSelectable = self.isSelectable(field: field, selectionMap: selectionMap)

      return isRequired || isSelectable
    }.sorted(by: { $0.name < $1.name })
  }
}
