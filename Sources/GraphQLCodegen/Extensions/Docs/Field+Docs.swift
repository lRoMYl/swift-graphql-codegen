//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST

extension Field {
  var docs: String {
    if let description = self.description {
      return description.isEmpty ? "" : "/// \(description)"
    }
    return ""
  }

  var availability: String {
    if isDeprecated {
      let message = deprecationReason ?? ""
      return "@available(*, deprecated, message: \"\(message)\")"
    }
    return ""
  }
}
