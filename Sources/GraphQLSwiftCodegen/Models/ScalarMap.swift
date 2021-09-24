//
//  ScalarMap.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

public typealias ScalarMap = [String: String]

extension ScalarMap {
  func scalar(_ name: String) throws -> String {
    guard let scalarType = self[name] else {
      throw GraphQLSwiftCodegenError.unknownScalar(name: name)
    }

    return scalarType
  }
}

extension ScalarMap {
  static var `default`: ScalarMap {
    [
      "ID": "String",
      "String": "String",
      "Int": "Int",
      "Boolean": "Bool",
      "Float": "Double"
    ]
  }
}
