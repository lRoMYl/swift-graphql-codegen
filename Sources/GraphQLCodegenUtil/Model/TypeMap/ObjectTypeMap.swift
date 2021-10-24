//
//  File.swift
//
//
//  Created by Romy Cheah on 3/10/21.
//

import Foundation
import GraphQLAST

public enum ObjectTypeMapError: Error, LocalizedError {
  case notFound(context: String)

  public var errorDescription: String? {
    switch self {
    case let .notFound(context):
      return "Unknown ObjectType for \(context)"
    }
  }
}

public struct ObjectTypeMap {
  private let objectTypeMap: [String: ObjectType]

  public init(schema: Schema) {
    self.objectTypeMap = Dictionary(
      uniqueKeysWithValues: schema.objects.map {
        ($0.name, $0)
      }
    )
  }

  public func value(from objectTypeRef: ObjectTypeRef) throws -> ObjectType {
    guard let objectType = objectTypeMap[objectTypeRef.name] else {
      throw ObjectTypeMapError.notFound(context: "ObjectTypeRef \(objectTypeRef.name)")
    }

    return objectType
  }

  public func value(from outputRef: OutputRef) throws -> ObjectType? {
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
