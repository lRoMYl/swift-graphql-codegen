//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation

public struct EntityNameMap: Decodable {
  /**
   Entity name for GraphQL request wrapper
   - default value:  GraphQLRequest
   */
  public let request: String
  public let requestType: String
  public let requestParameter: String
  public let response: String
  public let selection: String
  public let selections: String
}

public extension EntityNameMap {
  static var `default`: EntityNameMap {
    EntityNameMap(
      request: "GraphQLRequest",
      requestType: "GraphQLRequestType",
      requestParameter: "GraphQLRequestParameter",
      response: "GraphQLResponse",
      selection: "GraphQLSelection",
      selections: "GraphQLSelections"
    )
  }
}
