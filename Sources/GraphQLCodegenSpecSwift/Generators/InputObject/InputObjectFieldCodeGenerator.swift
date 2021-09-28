//
//  File.swift
//  
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

struct InputObjectFieldCodeGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameStrategy: EntityNamingStrategy) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
  }

  func variableDeclaration(input: InputValue) throws -> String {
    let type = try entityNameStrategy.name(for: input.type)

    return """
    \(input.docs)
    let \(input.name.camelCase): \(type)
    """
  }

  func codingKeyDeclaration(input: InputValue) -> String {
    "case \(input.name.camelCase) = \"\(input.name)\""
  }
}
