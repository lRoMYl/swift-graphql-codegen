//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation

public struct EntityNameMap: Decodable {
  let request: String
}

extension EntityNameMap {
  static var `default`: EntityNameMap {
    EntityNameMap(
      request: "GraphQLRequest"
    )
  }
}
