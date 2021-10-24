//
//  Structure+ObjectType.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension ObjectType: Structure {
  public var possibleTypes: [ObjectTypeRef] {
    [ObjectTypeRef.named(ObjectRef.object(name))]
  }

  public var isCompositeType: Bool { false }
}

public extension ObjectTypeRef {
  func objectType(objectTypeMap: ObjectTypeMap) throws -> ObjectType {
    return try objectTypeMap.value(from: self)
  }
}
