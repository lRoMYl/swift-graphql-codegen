//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum SelectionEntityNameProviderError: Error, LocalizedError {
  case missingStructure

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

extension EntityNameProviding {
  func fragmentName(for structure: Structure) throws -> String {
    switch structure {
    case let objectType as ObjectType:
      return try fragmentName(for: objectType)
    case let interfaceType as InterfaceType:
      return try fragmentName(for: interfaceType)
    case let unionType as UnionType:
      return try fragmentName(for: unionType)
    default:
      throw SelectionEntityNameProviderError.missingStructure
    }
  }

  func selectionName(structure: Structure) throws -> String? {
    switch structure {
    case let objectType as ObjectType:
      return try selectionName(for: objectType)
    case _ as InterfaceType:
      return nil
    case _ as UnionType:
      return nil
    default:
      throw SelectionEntityNameProviderError.missingStructure
    }
  }
}
