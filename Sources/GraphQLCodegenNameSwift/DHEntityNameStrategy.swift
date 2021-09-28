//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

public final class DHEntityNameStrategy: EntityNamingStrategy {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  public init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  public func name(for typeRef: OutputTypeRef) throws -> String {
    try typeRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }

  public func name(for typeRef: InputTypeRef) throws -> String {
    try typeRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }
}

private extension InputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap) throws -> String {
    try inverted.type(scalarMap: scalarMap)
  }
}

private extension InvertedInputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap) throws -> String {
    switch self {
    case let .named(named):
      switch named {
      case let .scalar(scalar):
        return try scalarMap.scalar(scalar)
      case let .enum(enm):
        return "\(enm.pascalCase)"
      case let .inputObject(inputObject):
        return "\(inputObject.pascalCase)"
      }
    case let .list(subref):
      return "[\(try subref.type(scalarMap: scalarMap))]"
    case let .nullable(subref):
      return "\(try subref.type(scalarMap: scalarMap))?"
    }
  }
}

private extension OutputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap) throws -> String {
    try inverted.type(scalarMap: scalarMap)
  }
}

private extension InvertedOutputTypeRef {
  /// Returns an internal type for a given input type ref.
  func type(scalarMap: ScalarMap) throws -> String {
    switch self {
    case let .named(scalar):
      return try scalar.type(scalarMap: scalarMap)
    case let .nullable(subRef):
      return "\(try subRef.type(scalarMap: scalarMap))?"
    case let .list(subRef):
      return "[\(try subRef.type(scalarMap: scalarMap))]"
    }
  }
}

private extension OutputRef {
  /// Returns an internal reference to the given output type ref.
  func type(scalarMap: ScalarMap) throws -> String {
    switch self {
    case let .scalar(scalar):
      return try scalarMap.scalar(scalar)
    case let .enum(enm):
      return "\(enm.pascalCase)"
    case let .object(type):
      return "\(type.pascalCase)"
    case let .interface(type):
      return "\(type.pascalCase)"
    case let .union(type):
      return "\(type.pascalCase)"
    }
  }
}
