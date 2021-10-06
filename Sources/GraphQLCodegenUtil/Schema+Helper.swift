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

public extension Schema {
  static func schema(from path: String?) throws -> Schema {
    guard let schemaPath = path else {
      throw SchemaError.notFound(context: path)
    }

    let url = NSURL.fileURL(withPath: schemaPath)
    let data = try Data(contentsOf: url)

    if let introspectionResponse = try? JSONDecoder().decode(IntrospectionResponse.self, from: data) {
      return introspectionResponse.schema.schema
    } else if let response = try? JSONDecoder().decode(SchemaResponse.self, from: data) {
      return response.schema
    } else {
      throw SchemaError.serializationError
    }
  }
}
