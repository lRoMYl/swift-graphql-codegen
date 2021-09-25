//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST

extension GraphQLAST.Operation {
  var enumNamePrefix: String {
    switch self {
    case .query: return ""
    case .mutation: return "update"
    case .subscription: return "subscribe"
    }
  }
}
