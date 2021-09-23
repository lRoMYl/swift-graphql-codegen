//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

import Foundation
import GraphQLAST
import GraphQLDownloader

final class SchemaHelper {
  static func schema(schemaName: String) throws -> Schema {
    let url = NSURL.fileURL(
      withPath: Bundle.module.path(
        forResource: schemaName,
        ofType: "json"
      )!
    )
    let data = try Data(contentsOf: url)
    let schema = try JSONDecoder().decode(SchemaResponse.self, from: data).schema

    return schema
  }
}
