//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public extension OutputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    try inverted.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }
}

public extension InvertedOutputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    switch self {
    case let .named(scalar):
      return try scalar.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
    case let .nullable(subRef):
      return "\(try subRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap))?"
    case let .list(subRef):
      return "[\(try subRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap))]"
    }
  }
}

public extension OutputRef {
  /// Returns an internal reference to the given output type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    switch self {
    case let .scalar(scalar):
      return try scalarMap.scalar(scalar)
    case let .enum(enm):
      return "\(entityNameMap.enums).\(enm.pascalCase)"
    case let .object(type):
      return "\(entityNameMap.objects).\(type.pascalCase)"
    case let .interface(type):
      return "\(entityNameMap.interfaces).\(type.pascalCase)"
    case let .union(type):
      return "\(entityNameMap.unions).\(type.pascalCase)"
    }
  }
}
