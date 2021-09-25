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
  private let namespace: String
  private let entityNameMap: EntityNameMap

  /// Generators
  private let generators: [Generating]

  public init(namespace: String?, entityNameMap: EntityNameMap?) throws {
    self.namespace = namespace ?? ""
    self.entityNameMap = entityNameMap ?? .default

    self.generators = [
      HeaderGenerator(),
      RepositoryGenerator(namespace: self.namespace, entityNameMap: self.entityNameMap),
      ResourceParametersGenerator(namespace: self.namespace, entityNameMap: self.entityNameMap),
      GraphQLResponseWrappedValueGenerator(namespace: self.namespace)
    ]
  }

  public func generate(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let source = try code.format()
    return source
  }
}
