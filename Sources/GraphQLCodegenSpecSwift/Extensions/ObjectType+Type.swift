//
//  Structure+ObjectType.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

extension ObjectType: Structure {
  var possibleTypes: [ObjectTypeRef] {
    [ObjectTypeRef.named(ObjectRef.object(name))]
  }
}

extension ObjectTypeRef {
  func objectType(objectTypeMap: ObjectTypeMap, entityNameStrategy: EntityNamingStrategy) throws -> ObjectType? {
    let objectTypeName = try entityNameStrategy.name(for: self)

    return objectTypeMap[objectTypeName]
  }
}
