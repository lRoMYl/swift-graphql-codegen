//
//  IntrospectionQueryResponse.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

private struct IntrospectionQueryResponse: Decodable, Equatable {
  public let schema: Schema

  enum CodingKeys: String, CodingKey {
    case schema = "__schema"
  }
}
