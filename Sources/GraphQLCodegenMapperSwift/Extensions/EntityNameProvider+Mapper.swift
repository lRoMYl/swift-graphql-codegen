//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

extension EntityNameProviding {
  func selectionDecoderName(type: ObjectType) throws -> String {
    "\(type.name.pascalCase)SelectionDecoder"
  }

  func selectionDecoderName(type: InterfaceType) throws -> String {
    "\(type.name.pascalCase)SelectionDecoder"
  }

  func selectionDecoderName(type: UnionType) throws -> String {
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

    return "\(field.name.pascalCase)\(operation.type.name.pascalCase)SelectionDecoder"
  }

  func mapperErrorName(apiClientPrefix: String) -> String {
    "\(apiClientPrefix.pascalCase)MapperError"
  }
}
