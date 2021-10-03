//
//  File.swift
//  
//
//  Created by Romy Cheah on 1/10/21.
//

import GraphQLAST
import GraphQLCodegenNameSwift

extension UnionType: Structure {
  var fields: [Field] { [] }
}

extension UnionType {
  func possibleObjectTypes(objectTypeMap: ObjectTypeMap, entityNameProvider: EntityNameProviding) throws -> [ObjectType] {
    try possibleTypes.compactMap {
      try $0.objectType(objectTypeMap: objectTypeMap)
    }
  }
}
