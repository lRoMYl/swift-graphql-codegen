//
//  File.swift
//
//
//  Created by Romy Cheah on 26/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift
import SwiftFormat

public enum GraphQLCodegenEntitySwiftError: Error, LocalizedError {
  case formatError(context: String)

  public var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self): \(context)"
    }
  }
}

public struct GraphQLCodegenEntitySwift {
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let generators: [GraphQLCodeGenerating]

  public init(entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider

    self.generators = [
      EntityGenerator(entityNameMap: entityNameMap, entityNameProvider: entityNameProvider)
    ]
  }

  public func code(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenEntitySwiftError
        .formatError(
          context: """
          \(error)
          Raw text:
          \(code)
          """
        )
    }

    return formattedCode
  }
}
