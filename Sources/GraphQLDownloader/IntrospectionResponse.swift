//
//  IntrospectionQueryResponse.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

public struct IntrospectionResponse: Decodable, Equatable {
  public let schema: SchemaResponse

  enum CodingKeys: String, CodingKey {
    case schema = "data"
  }
}
