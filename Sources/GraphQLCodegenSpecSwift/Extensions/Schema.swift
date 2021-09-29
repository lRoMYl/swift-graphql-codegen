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
typealias InterfaceTypeMap = [String: InterfaceType]
typealias UnionTypeMap = [String: UnionType]
typealias FieldMap = [String: Field]

extension Schema {
  func objectTypeMap(entityNameStrategy: EntityNamingStrategy) throws -> ObjectTypeMap {
    try Dictionary(
      uniqueKeysWithValues: objects.map {
        (try entityNameStrategy.name(for: $0), $0)
      }
    )
  }

  func interfaceTypeMap(entityNameStrategy: EntityNamingStrategy) throws -> InterfaceTypeMap {
    try Dictionary(
      uniqueKeysWithValues: interfaces.map {
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
