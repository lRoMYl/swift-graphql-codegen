//
//  File.swift
//
//
//  Created by Romy Cheah on 23/9/21.
//

import GraphQLAST

extension EnumValue {
  var docs: String {
    description.map { $0.isEmpty ? "" : "/// \($0)" } ?? ""
  }

  var availability: String {
    if isDeprecated {
      let message = deprecationReason ?? ""
      return "@available(*, deprecated, message: \"\(message)\")"
    }
    return ""
  }
}
