//
//  File.swift
//
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation
import GraphQLAST
import GraphQLDownloader

enum SchemaError: Error, LocalizedError {
  case serializationError
  case notFound(context: String?)

  var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "\(Self.self): \(String(describing: context))"
    case .serializationError:
      return "\(Self.self)"
    }
  }
}
