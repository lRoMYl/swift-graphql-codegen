//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST

//extension Schema {
//  func allNestedFields(field: Field) -> [Field] {
//    let returnNamedType = field.type.namedType
//
//    switch returnNamedType {
//    case .enum, .scalar:
//    case let .interface(interface):
//      let allFields = self.allFields(objects: objects)
//      let fieldMaps = try allFields.map { try $0.allNestedFields(objects: objects, scalarMap: scalarMap) }
//      let result = fieldMaps.reduce(into: FieldMap()) { result, fieldMap in
//        result.merge(fieldMap) { (_, new) in new }
//      }
//
//      return result
//    }
//
//    return []
//  }
//}
