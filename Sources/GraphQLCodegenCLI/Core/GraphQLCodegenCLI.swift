//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation
import GraphQLCodegenApiClientSwift

public enum Platform: String, ExpressibleByArgument {
  case swift
}

public enum SchemaSource: String, ExpressibleByArgument {
  case local
  case remote
}

extension ApiClientStrategy: ExpressibleByArgument {
}

public enum CodegenTarget: String, ExpressibleByArgument {
  /**
   implementation of default API Client
   */
  case apiClient = "api-client"
  /**
   Convenient mapper classes to ensure build-time safe mapping from network models to application models by
   automatically infering the GraphQL query selections based on the fields that are accesed in mapper
   */
  case mapper
  /**
   Network models such as request and response inferred from the schema
   */
  case specification
  /**
   Abstract Syntax Tree (AST, Introspection), this is the nested object json created from Schema Definition Language
   - `--schema-source` is ignored when `introspection` action option is provided
   - Only remote url is supported when `introspection` action option is provided
   */
  case introspection
  /**
   Base/Default entity class required for the network models
   */
  case entity
}

enum GraphQLCodegenCLIError: Error {
  case invalidSchemaPath
  case invalidSchema
  case invalidConfigPath
  case fetchSchemaTimeout
}

struct GraphQLCodegenCLI: ParsableCommand {
  public static var configuration = CommandConfiguration(
    commandName: "swift-graphql-codegen",
    abstract: "Swift GraphQL Codegeneration Tool",
    version: "0.8.0",
    subcommands: [Codegen.self, Introspection.self, Bootstrap.self]
  )
}
