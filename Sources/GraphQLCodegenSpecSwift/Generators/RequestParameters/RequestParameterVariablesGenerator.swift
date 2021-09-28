//
//  File.swift
//  
//
//  Created by Romy Cheah on 19/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

struct RequestParameterVariablesGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  /**
   - Operation variables is functionalities in GraphQL which allow injection of a list of variables on the root operation.
   - Variables are marked with `$` prefix
   - Required/mandatory field have a `!` prefix, optional field have no prefix
   - GraphQL example syntax for variables is `($productId: String!, $isAvailable: Bool, $vendorId: String)`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) { // Here
     product(id: $productId, isAvailable: $isAvailable) {
      name
     }
     vendor(id: $vendorId) {
      name
     }
   }
   ~~~
   */
  func operationVariablesDeclaration(with field: Field) -> String {
    field.args.compactMap {
      switch $0.type {
      case let .named(objectRef):
        let typeName: String
        switch objectRef {
        case let .enum(name), let .inputObject(name), let .scalar(name):
          typeName = name
        }

        return "  $\($0.name): \(typeName)"
      case let .nonNull(objectRef), let .list(objectRef):
        return "  $\($0.name): \(objectRef.argument)!"
      }
    }.lines
  }

  /**
   - Operation argument is the operation variables passed from the root the selection
   - Operation argument have `$` prefix
   - Example of operation agument is `id: $productId, isAvailable: $isAvailable` and `id: $vendorId`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) {
    product(id: $productId, isAvailable: $isAvailable) { // Here
      name
    }
    vendor(id: $vendorId) { // Here
      name
    }
   }
   ~~~
   */
  func operationArgumentsDeclaration(with field: Field) -> String {
    field.args.compactMap {
      return "    \($0.name): $\($0.name)"
    }.lines
  }

  /**
   - Swift argument variables
   */
  func argumentVariablesDeclaration(field: Field) throws -> String {
    let argumentVariables = try field.args.compactMap {
      let typeName = try $0.type.type(scalarMap: scalarMap, entityNameMap: entityNameMap)

      return """
      \($0.docs)
      let \($0.name.camelCase): \(typeName)
      """
    }.lines

    return """
    // MARK: - Arguments
    \(argumentVariables)
    """
  }
}
