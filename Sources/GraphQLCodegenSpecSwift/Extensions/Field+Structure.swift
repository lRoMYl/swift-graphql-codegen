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
    unionTypeMap: UnionTypeMap
  ) throws -> Structure? {
    let structure: Structure

    switch type.namedType {
    case let .object(objectName):
      guard
        let result = try objectTypeMap.value(from: type.namedType)
      else {
        throw FieldStructureError.missingReturnType(context: "Object \(objectName) not found")
      }

      structure = result
    case let .interface(interfaceName):
      guard
        let result = try interfaceTypeMap.value(from: type.namedType)
      else {
        throw FieldStructureError.missingReturnType(context: "Interface \(interfaceName) not found")
      }

      structure = result
    case .scalar, .enum:
      return nil
    case let .union(unionName):
      guard
        let result = try unionTypeMap.value(from: type.namedType)
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
    entityNameProvider: EntityNameProviding
  ) throws -> [ObjectType]? {
    switch type.namedType {
    case .interface:
      guard let interfaceType = try interfaceTypeMap.value(from: type.namedType) else { return nil }

      return try interfaceType.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        entityNameProvider: entityNameProvider
      )
    case .union:
      guard let unionType = try unionTypeMap.value(from: type.namedType) else { return nil }

      return try unionType.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        entityNameProvider: entityNameProvider
      )
    default:
      return nil
    }
  }
}
