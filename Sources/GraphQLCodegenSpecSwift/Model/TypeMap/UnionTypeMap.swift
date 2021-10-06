//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST

enum UnionTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown UnionType for \(context)"
    }
  }
}

struct UnionTypeMap {
  private let unionTypeMap: [String: UnionType]

  init(schema: Schema) {
    self.unionTypeMap = Dictionary(
      uniqueKeysWithValues: schema.unions.map {
        ($0.name, $0)
      }
    )
  }

  func value(from outputRef: OutputRef) throws -> UnionType? {
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
