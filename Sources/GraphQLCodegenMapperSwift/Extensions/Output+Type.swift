//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/10/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension InvertedOutputTypeRef {
  func isPrimitive(scalarMap: ScalarMap) throws -> Bool {
    switch self {
    case let .named(scalar):
      return try scalar.isPrimitive(scalarMap: scalarMap)
    case let .nullable(subRef):
      return try subRef.isPrimitive(scalarMap: scalarMap)
    case let .list(subRef):
      return try subRef.isPrimitive(scalarMap: scalarMap)
    }
  }

  var isComposite: Bool {
    switch self {
    case let .named(scalar):
      return scalar.isComposite
    case let .nullable(subRef):
      return subRef.isComposite
    case let .list(subRef):
      return subRef.isComposite
    }
  }
}

extension OutputRef {
  func isPrimitive(scalarMap: ScalarMap) throws -> Bool {
    switch self {
    case .scalar:
      let scalarValue = try scalarType(scalarMap: scalarMap)
      return ScalarMap.default.values.contains(scalarValue)
    case .object, .interface, .union, .enum:
      return false
    }
  }

  var isComposite: Bool {
    switch self {
    case .interface, .union:
      return true
    case .enum, .scalar, .object:
      return false
    }
  }
}
