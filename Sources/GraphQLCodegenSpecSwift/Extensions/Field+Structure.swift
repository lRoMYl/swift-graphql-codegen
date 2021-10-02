//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

enum FieldStructureError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

extension Field {
  func structure(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws -> Structure? {
    let key = try entityNameStrategy.name(for: self.type.namedType)

    let structure: Structure

    switch type.namedType {
    case let .object(objectName):
      guard
        let result = objectTypeMap[key]
      else {
        throw FieldStructureError.missingReturnType(context: "Object \(objectName) not found")
      }

      structure = result
    case let .interface(interfaceName):
      guard
        let result = interfaceTypeMap[key]
      else {
        throw FieldStructureError.missingReturnType(context: "Interface \(interfaceName) not found")
      }

      structure = result
    case .scalar, .enum:
      return nil
    case let .union(unionName):
      guard
        let result = unionTypeMap[key]
      else {
        throw FieldStructureError.missingReturnType(context: "Union \(unionName) not found")
      }

      structure = result
    }

    return structure
  }
}

extension Field {
  func possibleObjectTypes(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws -> [ObjectType]? {
    switch type.namedType {
    case .interface:
      let key = try entityNameStrategy.name(for: type.namedType)
      guard let interfaceType = interfaceTypeMap[key] else { return nil }

      return try interfaceType.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        entityNameStrategy: entityNameStrategy
      )
    case .union:
      let key = try entityNameStrategy.name(for: type.namedType)
      guard let unionType = unionTypeMap[key] else { return nil }

      return try unionType.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        entityNameStrategy: entityNameStrategy
      )
    default:
      return nil
    }
  }
}
