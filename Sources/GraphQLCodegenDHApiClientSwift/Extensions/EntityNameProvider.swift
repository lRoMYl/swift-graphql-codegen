//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/10/21.
//

import GraphQLAST
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

extension EntityNameProviding {
  func selectionDecoderName(type: ObjectType) throws -> String {
    "\(type.name.pascalCase)SelectionDecoder"
  }

  func selectionDecoderName(outputRef: OutputRef) throws -> String? {
    switch outputRef {
    case let .object(name):
      return "\(name.pascalCase)SelectionDecoder"
    case .enum, .interface, .scalar, .union:
      return nil
    }
  }

  func selectionDecoderName(field: Field, operation: GraphQLAST.Operation, schemaMap: SchemaMap) throws -> String? {
    guard try field.returnObjectType(schemaMap: schemaMap) != nil else { return nil }

    return "\(try responseDataName(for: field, with: operation))SelectionDecoder"
  }

  func selectionsVariableName(for objectType: ObjectType) throws -> String {
    let selectionName = try self.selectionName(for: objectType).camelCase
    return "\(selectionName)s"
  }

  func selectionsVariableName(for outputRef: OutputRef, entityNameProvider: EntityNameProviding) throws -> String? {
    guard let selectionName = try entityNameProvider.selectionName(for: outputRef)?.camelCase else { return nil }
    return "\(selectionName)s"
  }
}
