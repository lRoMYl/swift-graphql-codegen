//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension ObjectType {
  func nestedFieldMap(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    let fieldMap = try fields.flatMap {
      try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: [])
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.type.namedType.name })

    return fieldMap
  }

  func nestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> [Field] {
    var fields = [Field]()

    switch kind {
    case .object, .interface, .union:
      fields.append(Field(with: self))
    case .enumeration, .inputObject, .scalar:
      break
    }

    try self.fields.forEach {
      fields.append(contentsOf: try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: []))
    }

    return fields.unique(by: { $0.type.namedType.name })
  }
}
