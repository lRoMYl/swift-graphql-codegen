//
//  Codable.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

public protocol Structure: NamedTypeProtocol {
  var kind: NamedTypeKind { get }
  var name: String { get }
  var fields: [Field] { get }
  var possibleTypes: [ObjectTypeRef]? { get }
  var isCompositeType: Bool { get }
}
