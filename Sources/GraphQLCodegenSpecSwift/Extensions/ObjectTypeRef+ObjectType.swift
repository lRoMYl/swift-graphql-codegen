//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/9/21.
//

import GraphQLAST
import GraphQLCodegenNameSwift

extension ObjectTypeRef {
  func objectType(objectTypeMap: ObjectTypeMap, entityNameStrategy: EntityNamingStrategy) throws -> ObjectType? {
    let objectTypeName = try entityNameStrategy.name(for: self)

    return objectTypeMap[objectTypeName]
  }
}
