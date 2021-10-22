//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST

public enum UnionTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  public var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown UnionType for \(context)"
    }
  }
}

public struct UnionTypeMap {
  private let unionTypeMap: [String: UnionType]

  public init(schema: Schema) {
    self.unionTypeMap = Dictionary(
      uniqueKeysWithValues: schema.unions.map {
        ($0.name, $0)
      }
    )
  }

  public func value(from outputRef: OutputRef) throws -> UnionType? {
    switch outputRef {
    case let .union(name):
      guard let unionType = unionTypeMap[name] else {
        throw UnionTypeMapError.notFound(context: "OutputRef \(outputRef.name)")
      }

      return unionType
    default:
      return nil
    }
  }
}
