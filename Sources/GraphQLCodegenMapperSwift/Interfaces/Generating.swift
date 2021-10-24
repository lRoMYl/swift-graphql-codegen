//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST

protocol Generating {
  func code(schema: Schema) throws -> String
}
