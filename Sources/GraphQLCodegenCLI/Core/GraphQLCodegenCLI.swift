//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation

public enum Platform: String, ExpressibleByArgument {
  case swift
}

public enum SchemaSource: String, ExpressibleByArgument {
  case local
  case remote
}

public enum CodegenTarget: String, ExpressibleByArgument {
  case dhApiClient = "dh-apiclient"
  /*
   Network models such as request and response inferred from the schema
   */
  case specification
  /**
   Abstract Syntax Tree (AST, Introspection), this is the nested object json created from Schema Definition Language
   - `--schema-source` is ignored when `introspection` action option is provided
   - Only remote url is supported when `introspection` action option is provided
   */
  case introspection
  /*
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
    commandName: "dh-graphql-codegen",
    abstract: "DH GraphQL Codegeneration Tool",
    version: "0.0.1",
    subcommands: [Codegen.self, Introspection.self, DHSwift.self]
  )
}
