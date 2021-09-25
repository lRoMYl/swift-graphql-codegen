//
//  BaseSpecificationGenerator.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct HeaderCodeGenerator: GraphQLCodeGenerating {
  private let namespace: String
  private let entityNameMap: EntityNameMap

  init(namespace: String, entityNameMap: EntityNameMap) {
    self.namespace = namespace
    self.entityNameMap = entityNameMap
  }

  func code(schema: Schema) throws -> String {
    let namespaceCode: String

    if namespace.isEmpty {
      namespaceCode = ""
    } else {
      namespaceCode = """
      enum \(namespace) {}

      extension \(namespace) {
      """
    }

    return """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import Foundation

    \(namespaceCode)
    """
  }
}
