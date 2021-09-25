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
}

public extension EntityNameMap {
  static var `default`: EntityNameMap {
    EntityNameMap(
      request: "GraphQLRequest"
    )
  }
}
