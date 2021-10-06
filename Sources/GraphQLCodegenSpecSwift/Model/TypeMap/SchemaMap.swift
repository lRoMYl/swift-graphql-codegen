//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct SchemaMap {
  let objectTypeMap: ObjectTypeMap
  let interfaceTypeMap: InterfaceTypeMap
  let unionTypeMap: UnionTypeMap

  let schema: Schema

  init(schema: Schema) throws {
    self.objectTypeMap = ObjectTypeMap(schema: schema)
    self.interfaceTypeMap = InterfaceTypeMap(schema: schema)
    self.unionTypeMap = UnionTypeMap(schema: schema)
    self.schema = schema
  }
}
