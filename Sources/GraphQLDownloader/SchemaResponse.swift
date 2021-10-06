//
//  File.swift
//
//
//  Created by Romy Cheah on 20/9/21.
//

import GraphQLAST

public struct SchemaResponse: Decodable, Equatable {
  public let schema: Schema

  enum CodingKeys: String, CodingKey {
    case schema = "__schema"
  }
}
