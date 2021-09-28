//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension GraphQLAST.Operation {
  var enumNamePrefix: String {
    switch self {
    case .query: return "query"
    case .mutation: return "update"
    case .subscription: return "subscribe"
    }
  }

  func requestEntityObjectName(entityNameMap: EntityNameMap) -> String {
    switch self {
    case .query: return entityNameMap.queries
    case .mutation: return entityNameMap.mutations
    case .subscription: return entityNameMap.subscriptions
    }
  }
}
