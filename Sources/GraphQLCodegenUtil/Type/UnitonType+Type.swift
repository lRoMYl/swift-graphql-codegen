//
//  File.swift
//
//
//  Created by Romy Cheah on 1/10/21.
//

import GraphQLAST

extension UnionType: Structure {
  public var fields: [Field] { [] }
}

public extension UnionType {
  func possibleObjectTypes(objectTypeMap: ObjectTypeMap) throws -> [ObjectType] {
    try possibleTypes.compactMap {
      try $0.objectType(objectTypeMap: objectTypeMap)
    }
  }

  var isCompositeType: Bool { true }
}
