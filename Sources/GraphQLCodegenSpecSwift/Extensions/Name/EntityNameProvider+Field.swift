//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/10/21.
//

import GraphQLAST
import GraphQLCodegenNameSwift

extension EntityNameProviding {
  func responseInternalVariableName(with field: Field) throws -> String {
    "internal\(field.name.pascalCase)"
  }
}
