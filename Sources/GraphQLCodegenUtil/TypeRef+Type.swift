//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

// MARK: - OutputRef

public extension OutputRef {
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
