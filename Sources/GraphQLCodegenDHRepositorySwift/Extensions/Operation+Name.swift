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
    case .query: return entityNameMap.queryParameter
    case .mutation: return entityNameMap.mutationParameter
    case .subscription: return entityNameMap.subscriptionParameter
    }
  }
}
