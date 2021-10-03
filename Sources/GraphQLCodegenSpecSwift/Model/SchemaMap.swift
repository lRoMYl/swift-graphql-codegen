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

//typealias ObjectTypeMap = [String: ObjectType]
//typealias InterfaceTypeMap = [String: InterfaceType]
//typealias UnionTypeMap = [String: UnionType]
typealias FieldMap = [String: Field]

enum ObjectTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown ObjectType for \(context)"
    }
  }
}

struct ObjectTypeMap {
  private let objectTypeMap: [String: ObjectType]

  init(schema: Schema) {
    objectTypeMap = Dictionary(
      uniqueKeysWithValues: schema.objects.map {
        ($0.name, $0)
      }
    )
  }

  func value(from objectTypeRef: ObjectTypeRef) throws -> ObjectType {
    guard let objectType = objectTypeMap[objectTypeRef.name] else {
      throw ObjectTypeMapError.notFound(context: "ObjectTypeRef \(objectTypeRef.name)")
    }

    return objectType
  }

  func value(from outputRef: OutputRef) throws -> ObjectType? {
    switch outputRef {
    case let .object(name):
      guard let objectType = objectTypeMap[name] else {
        throw ObjectTypeMapError.notFound(context: "OutputRef \(outputRef.name)")
      }

      return objectType
    default:
      return nil
    }
  }
}

struct InterfaceTypeMap {
  private let interfaceTypeMap: [String: InterfaceType]

  init(schema: Schema) {
    interfaceTypeMap = Dictionary(
      uniqueKeysWithValues: schema.interfaces.map {
        ($0.name, $0)
      }
    )
  }

  func value(from outputRef: OutputRef) throws -> InterfaceType? {
    switch outputRef {
    case let .interface(name):
      guard let interfaceType = interfaceTypeMap[name] else {
        throw ObjectTypeMapError.notFound(context: "OutputRef \(outputRef.name)")
      }

      return interfaceType
    default:
      return nil
    }
  }
}

struct UnionTypeMap {
  private let unionTypeMap: [String: UnionType]

  init(schema: Schema) {
    unionTypeMap = Dictionary(
      uniqueKeysWithValues: schema.unions.map {
        ($0.name, $0)
      }
    )
  }

  func value(from outputRef: OutputRef) throws -> UnionType? {
    switch outputRef {
    case let .union(name):
      guard let unionType = unionTypeMap[name] else {
        throw ObjectTypeMapError.notFound(context: "OutputRef \(outputRef.name)")
      }

      return unionType
    default:
      return nil
    }
  }
}

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
