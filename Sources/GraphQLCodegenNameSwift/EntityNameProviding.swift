//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST

public protocol EntityNameProviding {
  func name(for typeRef: OutputTypeRef) throws -> String
  func name(for typeRef: InputTypeRef) throws -> String
  func name(for typeRef: ObjectTypeRef) throws -> String

  func name(for outputRef: OutputRef) throws -> String

  func name(for namedType: NamedType) throws -> String
  func name(for namedTypeProtocol: NamedTypeProtocol) throws -> String

  func genericName(for typeRef: OutputTypeRef, identifier: String) throws -> String

  func fragmentName(for outputRef: OutputRef) throws -> String?
  func fragmentName(for objectType: ObjectType) throws -> String
  func fragmentName(for interfaceType: InterfaceType) throws -> String
  func fragmentName(for unionType: UnionType) throws -> String

  func requestParameterName(for field: Field, with operation: GraphQLAST.Operation) throws -> String
  func requestParameterName(with operation: GraphQLAST.Operation) throws -> String

  func responseDataName(for field: Field, with operation: GraphQLAST.Operation) throws -> String
  func responseDataName(with operation: GraphQLAST.Operation) throws -> String

  func selectionName(for objectType: ObjectType) throws -> String
  func selectionName(for outputRef: OutputRef) throws -> String?
  func selectionName(for field: Field) throws -> String?
  func selectionName(for objectTypeRef: ObjectTypeRef) throws -> String

  func selectionsName(for field: Field, operation: GraphQLAST.Operation) throws -> String
  func selectionsName(with operation: GraphQLAST.Operation) throws -> String

  func mapperName(for field: Field, operation: GraphQLAST.Operation) throws -> String
}

public extension EntityNameProviding {
  func selectionsVariableName(for objectType: ObjectType) throws -> String {
    let selectionName = try self.selectionName(for: objectType).camelCase
    return "\(selectionName)s"
  }

  func selectionsVariableName(for outputRef: OutputRef, entityNameProvider: EntityNameProviding) throws -> String? {
    guard let selectionName = try entityNameProvider.selectionName(for: outputRef)?.camelCase else { return nil }
    return "\(selectionName)s"
  }

  func selectionsVariableName(for objectTypeRef: ObjectTypeRef) throws -> String {
    let selectionName = try self.selectionName(for: objectTypeRef).camelCase
    return "\(selectionName)s"
  }

  var requestQueryName: String { "requestQuery" }
  var requestArgumentsName: String { "requestArguments" }
  var requestFragmentsName: String { "requestFragments" }
  var requestFragmentName: String { "requestFragment" }
  var requestFragmentFields: String { "requestFragmentFields" }
  var nestedRequestFragmentsName: String { "nestedRequestFragments" }

  var requestType: String { "Codable" }
  var responseType: String { "Decodable" }

  var graphQLResponseError: String { "GraphQLResponseError" }
  var graphQLError: String { "GraphQLError" }
}
