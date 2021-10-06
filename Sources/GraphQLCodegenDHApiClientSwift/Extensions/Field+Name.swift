//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

extension Field {
  func enumName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumNamePrefix.camelCase

    return enumPrefix.isEmpty ? name.camelCase : "\(enumPrefix)\(name.pascalCase)"
  }

  func funcName() -> String {
    return name.camelCase
  }
}
