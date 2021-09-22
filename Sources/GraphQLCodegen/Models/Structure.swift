//
//  Codable.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

protocol Structure {
  var name: String { get }
  var fields: [Field] { get }
  var possibleTypes: [ObjectTypeRef] { get }
}
