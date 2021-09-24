//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST

protocol Generating {
  func code(schema: Schema) throws -> String
}
