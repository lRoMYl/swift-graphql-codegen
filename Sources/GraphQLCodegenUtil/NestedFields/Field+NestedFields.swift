//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension Field {
  func nestedFields(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    excluded: [Field],
    selectionMap: SelectionMap?,
    sortType: FieldSortType = .name
  ) throws -> [Field] {
    guard
      let returnObjectType = objects.first(where: { $0.name == type.namedType.name })
    else {
      return []
    }

    var fields = [Field]()

    switch returnObjectType.kind {
    case .object, .interface, .union:
      fields.append(self)
    case .enumeration, .inputObject, .scalar:
      break
    }

    try returnObjectType.selectableFields(selectionMap: selectionMap).filter {
      $0.type.namedType != self.type.namedType && !excluded.contains($0)
    }.forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object, .interface, .union:
          fields.append($0)
        case .enum, .scalar:
          break
        }
      case .list, .nonNull:
        fields.append(
          contentsOf: try $0.nestedFields(
            objects: objects,
            scalarMap: scalarMap,
            excluded: excluded + fields,
            selectionMap: selectionMap
          )
        )
      }
    }

    return fields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: sortType)
  }
}
