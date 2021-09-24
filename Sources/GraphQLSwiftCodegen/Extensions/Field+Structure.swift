//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLAST

enum FieldStructureError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

extension Field {
  func structure(objects: [ObjectType], interfaces: [InterfaceType], scalarMap: ScalarMap) throws -> Structure? {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    let structure: Structure

    switch type.namedType {
    case let .object(objectName):
      guard
        let result = objects.first(where: { $0.name == returnName })
      else {
        throw FieldStructureError.missingReturnType(context: "Object \(objectName) not found")
      }

      structure = result
    case let .interface(interfaceName):
      guard
        let result = interfaces.first(where: { $0.name == returnName })
      else {
        throw FieldStructureError.missingReturnType(context: "Interface \(interfaceName) not found")
      }

      structure = result
    case .scalar, .enum:
      return nil
    case .union:
      throw FieldStructureError.notImplemented(context: "Union is not implemented")
    }

    return structure
  }
}
