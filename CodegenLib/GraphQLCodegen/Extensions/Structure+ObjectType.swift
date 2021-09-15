//
//  Structure+ObjectType.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

extension ObjectType: Structure {
  var possibleTypes: [ObjectTypeRef] {
    [ObjectTypeRef.named(ObjectRef.object(name))]
  }
}
