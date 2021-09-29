//
//  File.swift
//  
//
//  Created by Romy Cheah on 29/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

typealias ObjectTypeMap = [String: ObjectType]
typealias UnionTypeMap = [String: UnionType]

extension Schema {
  func objectTypeMap(entityNameStrategy: EntityNamingStrategy) throws -> ObjectTypeMap {
    try Dictionary(
      uniqueKeysWithValues: objects.map {
        (try entityNameStrategy.name(for: $0), $0)
      }
    )
  }

  func unionTypeMap(entityNameStrategy: EntityNamingStrategy) throws -> UnionTypeMap {
    try Dictionary(
      uniqueKeysWithValues: unions.map {
        (try entityNameStrategy.name(for: $0), $0)
      }
    )
  }
}
