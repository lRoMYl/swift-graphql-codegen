//
//  File.swift
//  
//
//  Created by Romy Cheah on 25/9/21.
//

import GraphQLAST

struct FooterCodeGenerator: GraphQLCodeGenerating {
  private let namespace: String

  init(namespace: String) {
    self.namespace = namespace
  }

  func code(schema: Schema) throws -> String {
    namespace.isEmpty ? "" : "}"
  }
}

