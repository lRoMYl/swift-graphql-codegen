//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

public final class DHEntityNameStrategy: EntityNamingStrategy {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  public init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  public func name(for typeRef: OutputTypeRef) throws -> String {
    try typeRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }

  public func name(for typeRef: InputTypeRef) throws -> String {
    try typeRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }

  public func name(for namedType: NamedType) throws -> String {
    switch namedType {
    case let .scalar(refType):
      return refType.name
    case let .object(refType):
      return refType.name + entityNameMap.objects
    case let .interface(refType):
      return refType.name + entityNameMap.interfaces
    case let .union(refType):
      return refType.name + entityNameMap.unions
    case let .`enum`(refType):
      return refType.name + entityNameMap.enums
    case let .inputObject(refType):
      return refType.name + entityNameMap.inputObjects
    }
  }

  public func name(for namedTypeProtocol: NamedTypeProtocol) throws -> String {
    switch namedTypeProtocol.kind {
    case .scalar:
      return namedTypeProtocol.name
    case .object:
      return namedTypeProtocol.name + entityNameMap.objects
    case .interface:
      return namedTypeProtocol.name + entityNameMap.interfaces
    case .union:
      return namedTypeProtocol.name + entityNameMap.unions
    case .enumeration:
      return namedTypeProtocol.name + entityNameMap.enums
    case .inputObject:
      return namedTypeProtocol.name + entityNameMap.inputObjects
    }
  }

  public func requestParameterName(for field: Field, with operation: GraphQLAST.Operation) throws -> String {
    field.name.pascalCase + operation.type(entityNameMap: entityNameMap)
  }
}
