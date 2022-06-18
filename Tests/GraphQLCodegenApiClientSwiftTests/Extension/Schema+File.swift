//
//  File.swift
//  
//
//  Created by Romy Cheah on 14/10/21.
//

import Foundation
import GraphQLAST
import GraphQLDownloader

enum SchemaError: Error {
  case notFound(context: String)
  case serializationError
}

extension Schema {
  static func schema(from fileName: String) throws -> Schema {
    guard let schemaPath = Bundle.module.path(forResource: fileName, ofType: "json") else {
      throw SchemaError.notFound(context: "Failed to find path for \(fileName).json")
    }

    guard let data = try String(contentsOfFile: schemaPath).data(using: .utf8) else {
      throw SchemaError.notFound(context: "Failed to read content of \(fileName).json")
    }

    if let introspectionResponse = try? JSONDecoder().decode(IntrospectionResponse.self, from: data) {
      return introspectionResponse.schema.schema
    } else if let response = try? JSONDecoder().decode(SchemaResponse.self, from: data) {
      return response.schema
    } else {
      throw SchemaError.serializationError
    }
  }
}
