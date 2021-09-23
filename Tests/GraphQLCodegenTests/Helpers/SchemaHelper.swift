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

final class SchemaHelper {
  static func schema(with name: String) throws -> Schema {
    let schemaPath = Bundle.module.path(
      forResource: name,
      ofType: "json"
    )

    XCTAssertNotNil(schemaPath)

    let url = NSURL.fileURL(withPath: schemaPath!)
    let data = try Data(contentsOf: url)
    let schema = try JSONDecoder().decode(SchemaResponse.self, from: data).schema

    return schema
  }
}
