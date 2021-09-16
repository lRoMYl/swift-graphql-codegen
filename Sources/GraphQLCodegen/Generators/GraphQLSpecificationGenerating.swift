//
//  File.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST

protocol GraphQLSpecificationGenerating {
  func declaration(schema: Schema) throws -> String
}
