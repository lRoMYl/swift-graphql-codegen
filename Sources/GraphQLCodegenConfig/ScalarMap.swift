//
//  ScalarMap.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

public enum ScalarMapError: Error, LocalizedError {
  case unknownScalar(name: String)

  public var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

public typealias ScalarMap = [String: String]

public extension ScalarMap {
  func scalar(_ name: String) throws -> String {
    guard let scalarType = self[name] else {
      throw ScalarMapError.unknownScalar(name: name)
    }

    return scalarType
  }
}

public extension ScalarMap {
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
