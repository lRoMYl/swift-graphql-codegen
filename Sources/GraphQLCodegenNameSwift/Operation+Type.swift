//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension GraphQLAST.Operation {
  func type(entityNameMap: EntityNameMap) -> String {
    switch self {
    case .query:
      return entityNameMap.queries
    case .mutation:
      return entityNameMap.mutations
    case .subscription:
      return entityNameMap.subscriptions
    }
  }
}
