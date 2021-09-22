//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import GraphQLAST

extension Field {
  func structure(objects: [ObjectType], interfaces: [InterfaceType], scalarMap: ScalarMap) throws -> Structure? {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    let structure: Structure

    switch type.namedType {
    case let .object(objectName):
      guard
        let result = objects.first(where: { $0.name == returnName })
      else {
        throw RequestParameterSelectionsError.missingReturnType(context: "Object \(objectName) not found")
      }

      structure = result
    case let .interface(interfaceName):
      guard
        let result = interfaces.first(where: { $0.name == returnName })
      else {
        throw RequestParameterSelectionsError.missingReturnType(context: "Interface \(interfaceName) not found")
      }

      structure = result
    case .scalar, .enum:
      return nil
    case .union:
      throw RequestParameterSelectionsError.notImplemented(context: "Union is not implemented")
    }

    return structure
  }
}
