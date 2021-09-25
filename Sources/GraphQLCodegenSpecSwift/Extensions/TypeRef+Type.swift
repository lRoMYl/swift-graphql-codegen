//
//  FIeld.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

// MARK: - TypeRef

extension TypeRef {
  /// Returns a wrapped instance of a given type respecting the reference.
  func type(for name: String) -> String {
    inverted.type(for: name)
  }
}

// MARK: - OutputRef

extension OutputRef {
  /// Returns an internal reference to the given output type ref.
  func scalarType(scalarMap: ScalarMap) throws -> String {
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

// MARK: - InvertedTypeRef

extension InvertedTypeRef {
  /// Returns a wrapped instance of a given type respecting the reference.
  func type(for name: String) -> String {
    switch self {
    case .named:
      return name
    case let .list(subref):
      return "[\(subref.type(for: name))]"
    case let .nullable(subref):
      return "\(subref.type(for: name))?"
    }
  }
}

extension InputTypeRef {
  /// Returns an internal type for a given input type ref.
  func scalarType(scalarMap: ScalarMap) throws -> String {
    try inverted.scalarType(scalarMap: scalarMap)
  }
}

extension InputTypeRef {
  /// Generates an argument definition that we use to make selection using the client.
  var argument: String {
    /*
     We use this variable recursively on list and null references.
     */
    switch self {
    case let .named(named):
      switch named {
      case let .enum(name), let .inputObject(name), let .scalar(name):
        return name
      }
    case let .list(subref):
      return "[\(subref.argument)]"
    case let .nonNull(subref):
      return "\(subref.argument)!"
    }
  }
}

// MARK: - InvertedInputTypeRef

extension InvertedInputTypeRef {
  /// Returns an internal type for a given input type ref.
  func scalarType(scalarMap: ScalarMap) throws -> String {
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
      return "[\(try subref.scalarType(scalarMap: scalarMap))]"
    case let .nullable(subref):
      return "\(try subref.scalarType(scalarMap: scalarMap))?"
    }
  }
}
