//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST

extension Field {
  func allNestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> [Field] {
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

    try returnObjectType.fields.filter { $0.name == self.name }.forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object:
          fields.append($0)
        case .enum, .interface, .scalar, .union:
          break
        }
      case .list, .nonNull:
        fields.append(contentsOf: try $0.allNestedFields(objects: objects, scalarMap: scalarMap))
      }
    }

    return fields.unique(by: { $0.name })
  }
}
