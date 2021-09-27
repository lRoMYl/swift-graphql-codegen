//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

extension Field {
  func enumName(with operation: GraphQLAST.Operation) -> String {
    let enumPrefix = operation.enumNamePrefix.camelCase

    return enumPrefix.isEmpty ? name.camelCase : "\(enumPrefix)\(name.pascalCase)"
  }

  func funcName(with operation: GraphQLAST.Operation) -> String {
    return name.camelCase
  }

  /// Includes Operation.requestEntityObjectName extension in the name
  func requestEntityObjectParameterName(operation: GraphQLAST.Operation, entityNameMap: EntityNameMap) -> String {
    let prefix = operation.requestEntityObjectName(entityNameMap: entityNameMap).pascalCase
    let typeName = name.pascalCase

    return prefix + "." + typeName
  }

  func scalarName(namespace: String, scalarMap: ScalarMap) throws -> String {
    let scalarName = try type.namedType.scalarType(scalarMap: scalarMap)
    let namespaceExtension = namespace.isEmpty ? "" : "\(namespace)."

    guard !ScalarMap.swiftReservedScalarName.contains(scalarName) else {
      return scalarName
    }

    return "\(namespaceExtension)\(scalarName)"
  }
}
