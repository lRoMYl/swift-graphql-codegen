//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import GraphQLAST

public extension Collection where Element == Field {
  func sorted() -> [Element] {
    sorted(by: { $0.type.namedType.name < $1.type.namedType.name })
  }
}

public extension Collection where Element == ObjectType {
  func sorted() -> [Element] {
    sorted(by: { $0.name < $1.name })
  }
}
