//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import SwiftFormat

public struct GraphQLDHApiClientCodegen {
  private let generators: [Generating]
  private let entityNameMap: EntityNameMap

  public init(namespace: String, entityNameMap: EntityNameMap?) throws {
    self.entityNameMap = entityNameMap ?? .default

    self.generators = [
      HeaderGenerator(),
      RepositoryGenerator(namespace: namespace, entityNameMap: self.entityNameMap),
      ResourceParametersGenerator(namespace: namespace, entityNameMap: self.entityNameMap),
      GraphQLResponseWrappedValueGenerator(namespace: namespace)
    ]
  }

  public func generate(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let source = try code.format()
    return source
  }
}
