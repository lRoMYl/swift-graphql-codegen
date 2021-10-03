//
//  File.swift
//  
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST

enum InterfaceTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown InterfaceType for \(context)"
    }
  }
}

struct InterfaceTypeMap {
  private let interfaceTypeMap: [String: InterfaceType]

  init(schema: Schema) {
    interfaceTypeMap = Dictionary(
      uniqueKeysWithValues: schema.interfaces.map {
        ($0.name, $0)
      }
    )
  }

  func value(from outputRef: OutputRef) throws -> InterfaceType? {
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
