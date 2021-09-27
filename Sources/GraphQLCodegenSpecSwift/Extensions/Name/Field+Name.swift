//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension Field {
  func requestParameterName(operation: GraphQLAST.Operation) -> String {
    let typeName = name.pascalCase

    return typeName
  }

  /// Includes Operation.requestEntityObjectName extension in the name
  func requestEntityObjectParameterName(operation: GraphQLAST.Operation, entityNameMap: EntityNameMap) -> String {
    let prefix = operation.requestEntityObjectName(entityNameMap: entityNameMap).pascalCase
    let typeName = requestParameterName(operation: operation)

    return prefix + "." + typeName
  }
}
