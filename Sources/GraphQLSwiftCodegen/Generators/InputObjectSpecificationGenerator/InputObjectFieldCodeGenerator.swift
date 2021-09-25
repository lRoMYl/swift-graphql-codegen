//
//  File.swift
//  
//
//  Created by Romy Cheah on 21/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct InputObjectFieldCodeGenerator {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func variableDeclaration(input: InputValue) throws -> String {
    let type = try input.type.scalarType(scalarMap: scalarMap)

    return """
    \(input.docs)
    let \(input.name.camelCase): \(type)
    """
  }

  func codingKeyDeclaration(input: InputValue) -> String {
    "case \(input.name.camelCase) = \"\(input.name)\""
  }
}
