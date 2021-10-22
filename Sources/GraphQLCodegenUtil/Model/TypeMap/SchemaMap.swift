//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

public struct SchemaMap {
  public let objectTypeMap: ObjectTypeMap
  public let interfaceTypeMap: InterfaceTypeMap
  public let unionTypeMap: UnionTypeMap

  public let schema: Schema

  public init(schema: Schema) throws {
    self.objectTypeMap = ObjectTypeMap(schema: schema)
    self.interfaceTypeMap = InterfaceTypeMap(schema: schema)
    self.unionTypeMap = UnionTypeMap(schema: schema)
    self.schema = schema
  }
}
