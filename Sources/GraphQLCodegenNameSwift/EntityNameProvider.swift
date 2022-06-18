//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil

public final class EntityNameProvider: EntityNameProviding {
  private enum Constants {
    static let selectionPostFix = "Selection"
    static let selectionsPostFix = "Selections"
    static let responsePostFix = "Response"
  }

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

  public func genericName(for typeRef: OutputTypeRef, identifier: String) throws -> String {
    try typeRef.genericType(scalarMap: scalarMap, entityNameMap: entityNameMap, identifier: identifier)
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

  public func fragmentName(for outputRef: OutputRef) throws -> String? {
    switch outputRef {
    case let .object(name), let .interface(name), let .union(name):
      return "\(name)Fragment"
    default:
      return nil
    }
  }

  public func fragmentName(for objectType: ObjectType) throws -> String {
    "\(objectType.name)Fragment"
  }

  public func fragmentName(for interfaceType: InterfaceType) throws -> String {
    "\(interfaceType.name)Fragment"
  }

  public func fragmentName(for unionType: UnionType) throws -> String {
    "\(unionType.name)Fragment"
  }

  public func requestParameterName(for field: Field, with operation: GraphQLAST.Operation) throws -> String {
    field.name.pascalCase + operation.type(entityNameMap: entityNameMap)
  }

  public func requestParameterName(with operation: GraphQLAST.Operation) throws -> String {
    operation.type(entityNameMap: entityNameMap)
  }

  public func responseDataName(for field: Field, with operation: GraphQLAST.Operation) throws -> String {
    "\(field.name.pascalCase)\(operation.type.name.pascalCase)\(Constants.responsePostFix)"
  }

  public func responseDataName(with operation: GraphQLAST.Operation) throws -> String {
    try name(for: operation.type)
  }

  public func selectionName(for objectType: ObjectType) throws -> String {
    "\(objectType.name.pascalCase)\(Constants.selectionPostFix)"
  }

  public func selectionName(for outputRef: OutputRef) throws -> String? {
    switch outputRef {
    case let .object(name):
      return "\(name.pascalCase)\(Constants.selectionPostFix)"
    case .enum, .interface, .scalar, .union:
      return nil
    }
  }

  public func selectionName(for objectTypeRef: ObjectTypeRef) throws -> String {
    "\(objectTypeRef.name.pascalCase)\(Constants.selectionPostFix)"
  }

  public func selectionName(for field: Field) throws -> String? {
    switch field.type.namedType {
    case
      let .object(name):
      return "\(name.pascalCase)\(Constants.selectionPostFix)"
    case .enum, .interface, .scalar, .union:
      return nil
    }
  }

  public func selectionsName(for field: Field, operation: GraphQLAST.Operation) throws -> String {
    let operationTypeName = operation.type(entityNameMap: entityNameMap)

    return "\(field.name.pascalCase)\(operationTypeName)\(Constants.selectionsPostFix)"
  }

  public func selectionsName(with operation: GraphQLAST.Operation) throws -> String {
    let operationTypeName = operation.type(entityNameMap: entityNameMap)

    return "\(operationTypeName)\(Constants.selectionsPostFix)"
  }

  public func mapperName(for field: Field, operation: GraphQLAST.Operation) throws -> String {
    field.name.pascalCase + operation.type.name.pascalCase + "Mapper"
  }
}
