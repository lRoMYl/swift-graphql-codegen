//
//  BaseSpecificationGenerator.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct HeaderCodeGenerator: GraphQLCodeGenerating {
  private let entityNameMap: EntityNameMap

  init(entityNameMap: EntityNameMap) {
    self.entityNameMap = entityNameMap
  }

  func code(schema _: Schema) throws -> String {
    return """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    import Foundation

    """
  }
}
