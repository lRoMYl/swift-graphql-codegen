//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST

public enum InterfaceTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  public var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown InterfaceType for \(context)"
    }
  }
}

public struct InterfaceTypeMap {
  private let interfaceTypeMap: [String: InterfaceType]

  public init(schema: Schema) {
    self.interfaceTypeMap = Dictionary(
      uniqueKeysWithValues: schema.interfaces.map {
        ($0.name, $0)
      }
    )
  }

  public func value(from outputRef: OutputRef) throws -> InterfaceType? {
    switch outputRef {
    case let .interface(name):
      guard let interfaceType = interfaceTypeMap[name] else {
        throw InterfaceTypeMapError.notFound(context: "OutputRef \(outputRef.name)")
      }

      return interfaceType
    default:
      return nil
    }
  }
}
