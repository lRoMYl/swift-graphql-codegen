//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension InputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    try inverted.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }
}

extension InvertedInputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    switch self {
    case let .named(named):
      switch named {
      case let .scalar(scalar):
        return try scalarMap.scalar(scalar)
      case let .enum(enm):
        return "\(entityNameMap.enums).\(enm.pascalCase)"
      case let .inputObject(inputObject):
        return "\(entityNameMap.inputObjects).\(inputObject.pascalCase)"
      }
    case let .list(subref):
      return "[\(try subref.type(scalarMap: scalarMap, entityNameMap: entityNameMap))]"
    case let .nullable(subref):
      return "\(try subref.type(scalarMap: scalarMap, entityNameMap: entityNameMap))?"
    }
  }
}
