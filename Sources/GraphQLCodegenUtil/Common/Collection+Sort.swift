//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import GraphQLAST

public enum FieldSortType {
  case name
  case namedType
}

public extension Collection where Element == Field {
  func sorted(by sortType: FieldSortType) -> [Element] {
    switch sortType {
    case .name:
      return sorted(by: { $0.name < $1.name })
    case .namedType:
      return sorted(by: { $0.type.namedType.name < $1.type.namedType.name })
    }
  }
}

public extension Collection where Element == ObjectType {
  func sorted() -> [Element] {
    sorted(by: { $0.name < $1.name })
  }
}
