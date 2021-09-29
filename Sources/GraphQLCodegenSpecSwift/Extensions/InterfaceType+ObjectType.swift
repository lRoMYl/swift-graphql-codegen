//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/9/21.
//

import GraphQLAST
import GraphQLCodegenNameSwift

extension InterfaceType {
  func possibleObjectTypes(objectTypeMap: ObjectTypeMap, entityNameStrategy: EntityNamingStrategy) throws -> [ObjectType] {
    try possibleTypes.compactMap {
      try $0.objectType(objectTypeMap: objectTypeMap, entityNameStrategy: entityNameStrategy)
    }
  }
}
