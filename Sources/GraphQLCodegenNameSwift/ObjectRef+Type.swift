//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension ObjectTypeRef {
  /// Returns an internal type for a given object type ref.
  func type(entityNameMap: EntityNameMap) throws -> String {
    try namedType.type(entityNameMap: entityNameMap)
  }
}


public extension ObjectRef {
  /// Returns an internal reference to the given object type ref.
  func type(entityNameMap: EntityNameMap) throws -> String {
    name.pascalCase + entityNameMap.object
  }
}
