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
      return entityNameMap.query
    case .mutation:
      return entityNameMap.mutation
    case .subscription:
      return entityNameMap.subscription
    }
  }
}
