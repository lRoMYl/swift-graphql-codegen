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
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.name })

    return fieldMap
  }

  func nestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> [Field] {
    let fields = try self.fields.flatMap {
      try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: [])
    }

    return fields.unique(by: { $0.name })
  }
}
