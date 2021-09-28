//
//  File.swift
//  
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

struct InputObjectFieldCodeGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  func variableDeclaration(input: InputValue) throws -> String {
    let type = try input.type.type(scalarMap: scalarMap, entityNameMap: entityNameMap)

    return """
    \(input.docs)
    let \(input.name.camelCase): \(type)
    """
  }

  func codingKeyDeclaration(input: InputValue) -> String {
    "case \(input.name.camelCase) = \"\(input.name)\""
  }
}
