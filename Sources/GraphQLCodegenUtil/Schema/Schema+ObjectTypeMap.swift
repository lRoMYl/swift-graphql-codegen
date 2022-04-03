//
//  File.swift
//  
//
//  Created by Romy Cheah on 3/4/22.
//

import Foundation
import GraphQLAST

public extension Schema {
  var objectTypeMap: ObjectTypeMap {
    ObjectTypeMap(schema: self)
  }
}
