//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST

public protocol EntityNamingStrategy {
  func name(for typeRef: OutputTypeRef) throws -> String
  func name(for typeRef: InputTypeRef) throws -> String
}
