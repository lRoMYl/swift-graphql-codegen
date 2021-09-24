//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import GraphQLAST
import SwiftFormat

public struct DHGraphQLApiClientCodegen {
  private let generators: [Generating]

  public init() throws {
    self.generators = [
      BaseGenerator(),
      RepositoryGenerator(namespace: "")
    ]
  }

  public func generate(schema: Schema) throws -> String {
    let code = try generators.map { try $0.code(schema: schema) }.lines

    let source = try code.format()
    return source
  }
}
