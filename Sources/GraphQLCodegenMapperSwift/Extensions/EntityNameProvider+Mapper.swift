//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

extension EntityNameProviding {
  func selectionDecoderName(type: NamedTypeProtocol) throws -> String? {
    switch type.kind {
    case .object:
      return "\(type.name.pascalCase)SelectionDecoder"
    case .union:
      return "\(type.name.pascalCase)UnionSelectionDecoder"
    case .interface:
      return "\(type.name.pascalCase)InterfaceSelectionDecoder"
    case .enumeration, .inputObject, .scalar:
      return nil
    }
  }

  func selectionDecoderName(outputRef: OutputRef) throws -> String? {
    switch outputRef {
    case .object:
      return "\(outputRef.name.pascalCase)SelectionDecoder"
    case .union:
      return "\(outputRef.name.pascalCase)UnionSelectionDecoder"
    case .interface:
      return "\(outputRef.name.pascalCase)InterfaceSelectionDecoder"
    case .enum, .scalar:
      return nil
    }
  }

  func selectionDecoderName(field: Field, operation: GraphQLAST.Operation, schemaMap: SchemaMap) throws -> String? {
    guard try selectionDecoderName(outputRef: field.type.namedType) != nil else {
      return nil
    }

    return "\(field.name.pascalCase)\(operation.type.name.pascalCase)SelectionDecoder"
  }

  func mapperErrorName(apiClientPrefix: String) -> String {
    "\(apiClientPrefix.pascalCase)MapperError"
  }
}
