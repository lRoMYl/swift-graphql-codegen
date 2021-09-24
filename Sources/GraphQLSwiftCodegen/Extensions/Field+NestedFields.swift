//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST

extension Field {
  func nestedFields(
    objects: [ObjectType],
    scalarMap: ScalarMap,
    excluded: [Field]
  ) throws -> [Field] {
    guard
      let returnObjectType = objects.first(where: { $0.name == type.namedType.name })
    else {
      return []
    }

    var fields = [Field]()

    switch returnObjectType.kind {
    case .object, .interface:
      fields.append(self)
    case .enumeration, .inputObject, .scalar, .union:
      break
    }

    try returnObjectType.fields.filter {
      $0.name != self.name && !excluded.contains($0)
    }.forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object:
          fields.append($0)
        case .enum, .interface, .scalar, .union:
          break
        }
      case .list, .nonNull:
        fields.append(
          contentsOf: try $0.nestedFields(
            objects: objects,
            scalarMap: scalarMap,
            excluded: excluded + fields
          )
        )
      }
    }

    return fields.unique(by: { $0.name })
  }
}
