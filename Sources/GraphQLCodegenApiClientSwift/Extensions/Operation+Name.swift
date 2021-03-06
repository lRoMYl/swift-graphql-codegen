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

  var funcName: String {
    enumNamePrefix
  }
}
