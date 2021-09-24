//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST

extension GraphQLAST.Operation {
  var enumPrefix: String {
    switch self {
    case .query: return ""
    case .mutation: return "update"
    case .subscription: return "subscribe"
    }
  }
}

extension Field {
  func enumName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumPrefix.camelCase

    return enumPrefix.isEmpty ? name.camelCase : "\(enumPrefix)\(name.pascalCase)"
  }
}

extension Field {
  func requestParametersName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumPrefix.pascalCase
    let typeName = self.type.namedType.name.pascalCase

    return enumPrefix + typeName + "RequestParameter"
  }
}
