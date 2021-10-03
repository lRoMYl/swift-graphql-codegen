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
    schemaMap: SchemaMap
  ) throws -> Structure? {
    let structure: Structure

    switch type.namedType {
    case let .object(objectName):
      guard
        let result = try schemaMap.objectTypeMap.value(from: type.namedType)
      else {
        throw FieldStructureError.missingReturnType(context: "Object \(objectName) not found")
      }

      structure = result
    case let .interface(interfaceName):
      guard
        let result = try schemaMap.interfaceTypeMap.value(from: type.namedType)
      else {
        throw FieldStructureError.missingReturnType(context: "Interface \(interfaceName) not found")
      }

      structure = result
    case .scalar, .enum:
      return nil
    case let .union(unionName):
      guard
        let result = try schemaMap.unionTypeMap.value(from: type.namedType)
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
    schemaMap: SchemaMap
  ) throws -> [ObjectType]? {
    switch type.namedType {
    case .interface:
      guard let interfaceType = try schemaMap.interfaceTypeMap.value(from: type.namedType) else { return nil }

      return try interfaceType.possibleObjectTypes(
        objectTypeMap: schemaMap.objectTypeMap
      )
    case .union:
      guard let unionType = try schemaMap.unionTypeMap.value(from: type.namedType) else { return nil }

      return try unionType.possibleObjectTypes(
        objectTypeMap: schemaMap.objectTypeMap
      )
    default:
      return nil
    }
  }

  func returnObjectType(schemaMap: SchemaMap) throws -> ObjectType? {
    switch type.namedType {
    case .object:
      guard let objectType = try schemaMap.objectTypeMap.value(from: type.namedType) else { return nil }

      return objectType
    default:
      return nil
    }
  }
}

extension Field {
  func returnTypeSelectableFields(
    schemaMap: SchemaMap,
    selectionMap: SelectionMap?
  ) throws -> [Field] {
    guard
      let returnType = try structure(
        schemaMap: schemaMap
      )
    else { return [] }

    return returnType.selectableFields(selectionMap: selectionMap)
  }
}
