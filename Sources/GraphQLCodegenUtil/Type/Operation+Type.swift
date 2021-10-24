//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import GraphQLAST

public extension GraphQLAST.Operation {
  func returnObject() throws -> ObjectType {
    switch self {
    case let .query(object), let .mutation(object):
      return object
    case let .subscription(object):
      print("Warning, subscription is not implemented yet")
      return object
    }
  }
}
