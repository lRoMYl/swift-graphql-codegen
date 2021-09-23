//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

import GraphQLAST

extension EnumValue {
  var docs: String {
    description.map { "/// \($0)" } ?? ""
  }
}
