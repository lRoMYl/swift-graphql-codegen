//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/10/21.
//

import GraphQLAST

public extension Field {
  func returnObjectType(schemaMap: SchemaMap) throws -> ObjectType? {
    switch type.namedType {
    case .object:
      guard let objectType = try schemaMap.objectTypeMap.value(from: type.namedType) else { return nil }

      return objectType
    default:
      return nil
    }
  }
}
