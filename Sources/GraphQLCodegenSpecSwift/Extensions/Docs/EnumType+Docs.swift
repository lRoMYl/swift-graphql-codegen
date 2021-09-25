//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

import GraphQLAST

extension EnumType {
  var docs: String {
    let text = description ?? name

    return text.isEmpty ? "" : "/// \(text)"
  }
}
