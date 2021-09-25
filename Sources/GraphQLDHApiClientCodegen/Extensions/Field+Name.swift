//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST

extension Field {
  func enumName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumNamePrefix.camelCase

    return enumPrefix.isEmpty ? name.camelCase : "\(enumPrefix)\(name.pascalCase)"
  }

  func funcName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumNamePrefix.camelCase

    return enumPrefix.isEmpty ? name.camelCase : "\(enumPrefix)\(name.pascalCase)"
  }

  func requestParameterName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumNamePrefix.pascalCase
    let typeName = self.type.namedType.name.pascalCase

    return enumPrefix + typeName + "RequestParameter"
  }
}
