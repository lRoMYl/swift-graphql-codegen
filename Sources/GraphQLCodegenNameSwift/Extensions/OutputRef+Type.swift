//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension OutputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    try inverted.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }

  func genericType(scalarMap: ScalarMap, entityNameMap: EntityNameMap, identifier: String) throws -> String {
    try inverted.genericType(identifier: identifier)
  }
}

extension InvertedOutputTypeRef {
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

  func genericType(identifier: String) throws -> String {
    switch self {
    case .named:
      return identifier
    case let .nullable(subRef):
      return "\(try subRef.genericType(identifier: identifier))?"
    case let .list(subRef):
      return "[\(try subRef.genericType(identifier: identifier))]"
    }
  }
}

extension OutputRef {
  /// Returns an internal reference to the given output type ref.
  func type(scalarMap: ScalarMap, entityNameMap: EntityNameMap) throws -> String {
    switch self {
    case let .scalar(scalar):
      return try scalarMap.scalar(scalar)
    case let .enum(enm):
      return "\(enm.pascalCase)\(entityNameMap.enum)"
    case let .object(type):
      return "\(type.pascalCase)\(entityNameMap.object)"
    case let .interface(type):
      return "\(type.pascalCase)\(entityNameMap.interface)"
    case let .union(type):
      return "\(type.pascalCase)\(entityNameMap.union)"
    }
  }
}
