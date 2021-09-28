//
//  FIeld.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

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

private extension InvertedInputTypeRef {
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
