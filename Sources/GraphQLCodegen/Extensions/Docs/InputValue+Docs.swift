//
//  File.swift
//  
//
//  Created by Romy Cheah on 19/9/21.
//

import GraphQLAST

extension InputValue {
  var docs: String {
    if let description = self.description {
      return "/// \(description)"
    }
    return ""
  }
}
