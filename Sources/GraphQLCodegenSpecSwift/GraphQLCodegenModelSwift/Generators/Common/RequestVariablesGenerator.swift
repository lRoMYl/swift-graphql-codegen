//
//  File.swift
//
//
//  Created by Romy Cheah on 19/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct RequestVariablesGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
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
        let argumentName = (field.name + $0.name.pascalCase).camelCase

        return "$\(argumentName): \(typeName)"
      case let .nonNull(objectRef), let .list(objectRef):
        let argumentName = (field.name + $0.name.pascalCase).camelCase
        return "$\(argumentName): \(objectRef.argument)!"
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
  func operationArgumentsDeclaration(with field: Field) -> [String] {
    field.args.compactMap {
      let argumentName = (field.name + $0.name.pascalCase).camelCase
      return "\($0.name): $\(argumentName)"
    }
  }

  /**
   - Swift argument variables
   */
  func argumentVariablesDeclaration(field: Field) throws -> String {
    let argumentVariables = try field.args.compactMap {
      let typeName = try entityNameProvider.name(for: $0.type)

      return """
      \($0.docs)
      let \($0.name.camelCase): \(typeName)
      """
    }.lines

    guard !argumentVariables.isEmpty else { return "" }

    return """
    // MARK: - Arguments
    \(argumentVariables)
    """
  }
}
