//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension ObjectType {
  func nestedFieldMap(objects: [ObjectType], scalarMap: ScalarMap, selectionMap: SelectionMap?) throws -> FieldMap {
    let fieldMap = try selectableFields(selectionMap: selectionMap).flatMap {
      try $0.nestedTypeFields(objects: objects, scalarMap: scalarMap, excluded: [], selectionMap: selectionMap)
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.type.namedType.name })

    return fieldMap
  }

  func nestedFields(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    sortType: FieldSortType = .name
  ) throws -> [Field] {
    var fields = [Field]()

    switch kind {
    case .object, .interface, .union:
      fields.append(Field(with: self))
    case .enumeration, .inputObject, .scalar:
      break
    }

    try self.selectableFields(selectionMap: selectionMap).forEach {
      fields.append(
        contentsOf: try $0.nestedTypeFields(
          objects: objects,
          scalarMap: scalarMap,
          excluded: [],
          selectionMap: selectionMap
        )
      )
    }

    return fields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: sortType)
  }
}
