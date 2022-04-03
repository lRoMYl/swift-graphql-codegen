//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension ObjectType {
  func nestedFields(
    schema: Schema,
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

    let objectTypeMap = schema.objectTypeMap

    try self.selectableFields(selectionMap: selectionMap).forEach {
      fields.append(
        contentsOf: try $0.nestedTypeFields(
          schema: schema,
          excluded: [],
          scalarMap: scalarMap,
          selectionMap: selectionMap,
          objectTypeMap: objectTypeMap
        )
      )
    }

    return fields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: sortType)
  }
}
