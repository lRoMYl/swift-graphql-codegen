//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

import Foundation
import GraphQLAST
import GraphQLDownloader
import XCTest

enum SchemaHelperError: Error {
  case serializationError
  case notFound(context: String)
}

final class SchemaHelper {
  static func schema(with name: String) throws -> Schema {
    let path = Bundle.module.path(
      forResource: name,
      ofType: "json"
    )

    guard let schemaPath = path else {
      throw SchemaHelperError.notFound(context: name)
    }

    let url = NSURL.fileURL(withPath: schemaPath)
    let data = try Data(contentsOf: url)

    if let introspectionResponse = try? JSONDecoder().decode(IntrospectionResponse.self, from: data) {
      return introspectionResponse.schema.schema
    } else if let response = try? JSONDecoder().decode(SchemaResponse.self, from: data)  {
      return response.schema
    } else {
      throw SchemaHelperError.serializationError
    }
  }
}
