//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

public final class DHEntityNameProvider: EntityNameProviding {
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

  public func name(for typeRef: ObjectTypeRef) throws -> String {
    try typeRef.type(entityNameMap: entityNameMap)
  }

  public func name(for outputRef: OutputRef) throws -> String {
    try outputRef.type(scalarMap: scalarMap, entityNameMap: entityNameMap)
  }

  public func name(for namedType: NamedType) throws -> String {
    switch namedType {
    case let .scalar(refType):
      return refType.name
    case let .object(refType):
      return refType.name + entityNameMap.object
    case let .interface(refType):
      return refType.name + entityNameMap.interface
    case let .union(refType):
      return refType.name + entityNameMap.union
    case let .enum(refType):
      return refType.name + entityNameMap.enum
    case let .inputObject(refType):
      return refType.name + entityNameMap.inputObject
    }
  }

  public func name(for namedTypeProtocol: NamedTypeProtocol) throws -> String {
    switch namedTypeProtocol.kind {
    case .scalar:
      return namedTypeProtocol.name
    case .object:
      return namedTypeProtocol.name + entityNameMap.object
    case .interface:
      return namedTypeProtocol.name + entityNameMap.interface
    case .union:
      return namedTypeProtocol.name + entityNameMap.union
    case .enumeration:
      return namedTypeProtocol.name + entityNameMap.enum
    case .inputObject:
      return namedTypeProtocol.name + entityNameMap.inputObject
    }
  }

  public func requestParameterName(for field: Field, with operation: GraphQLAST.Operation) throws -> String {
    field.name.pascalCase + operation.type(entityNameMap: entityNameMap)
  }

  public func responseDataName(for field: Field, with operation: GraphQLAST.Operation) throws -> String {
    "\(field.name.pascalCase)\(operation.type.name.pascalCase)Response"
  }

  public func selectionsName(for field: Field, operation: GraphQLAST.Operation) throws -> String {
    let entityName = entityNameMap.selections
    let operationTypeName = operation.type(entityNameMap: entityNameMap)

    return "\(field.name.pascalCase)\(operationTypeName)\(entityName)"
  }
}
