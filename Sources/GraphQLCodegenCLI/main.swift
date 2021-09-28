//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenDHApiClientSwift
import GraphQLCodegenEntitySwift
import GraphQLCodegenSpecSwift
import GraphQLDownloader

//GraphQLCodegenCLI.main()

//GraphQLCodegenCLI.main(
//  [
//    "https://sg-st.fd-api.com/groceries-product-service/query",
//    "--action", "introspection",
//    "--schema-source", "remote",
//    "--output", "/Users/r.cheah/Desktop/schema.json"
//  ]
//)
//GraphQLCodegenCLI.main(
//  [
//    "/Users/r.cheah/Desktop/schema.json",
//    "--action", "entity",
//    "--output", "/Users/r.cheah/Desktop/GraphQLEntity.swift",
//    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
//  ]
//)

let examplePath = "/Users/r.cheah/Repos/lRoMYl/dh-graphql-codegen-ios/Example/GraphQLCodegenExample"
let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
let groceriesOutputPath = "\(examplePath)/GraphQLCodegenExample/Groceries/Groceries"

GraphQLCodegenCLI.main(
  [
    groceriesSchema,
    "--action", "specification",
    "--output", "\(groceriesOutputPath)GraphQLSpec.swift",
    "--config-path", groceriesConfig
  ]
)
GraphQLCodegenCLI.main(
  [
    groceriesSchema,
    "--action", "dh-repository",
    "--output", "\(groceriesOutputPath)GraphQLApiClient.swift",
    "--config-path", groceriesConfig
  ]
)

let starwarsSchema = "\(examplePath)/GraphQL/starwars-schema.json"
let starwarsConfig = "\(examplePath)/GraphQL/starwars-config.json"
let starwarsOutputPath = "\(examplePath)/GraphQLCodegenExample/StarWars/StarWars"
GraphQLCodegenCLI.main(
  [
    starwarsSchema,
    "--action", "specification",
    "--output", "\(starwarsOutputPath)GraphQLSpec.swift",
    "--config-path", starwarsConfig
  ]
)
GraphQLCodegenCLI.main(
  [
    starwarsSchema,
    "--action", "dh-repository",
    "--output", "\(starwarsOutputPath)GraphQLApiClient.swift",
    "--config-path", starwarsConfig
  ]
)

enum SchemaSource: String, ExpressibleByArgument {
  case local
  case remote
}

enum CodegenAction: String, ExpressibleByArgument {
  case dhrepository = "dh-repository"
  case specification
  /**
   Abstract Syntax Tree (AST, Introspection), this is the nested object json created from Schema Definition Language
   - `--schema-source` is ignored when `introspection` action option is provided
   - Only remote url is supported when `introspection` action option is provided
   */
  case introspection
  case entity
}

enum GraphQLCodegenCLIError: Error {
  case invalidSchemaPath
  case invalidSchema
  case invalidConfigPath
  case fetchSchemaTimeout
}

struct GraphQLCodegenCLI: ParsableCommand {
  @Argument(
    help: """
    Location of the introspection file, it can be local or remote path.
    e.g.
    - local path: "/User/Download/schema.json"
    - remote path: "https://www.somedomain.com"

    - Introspection/AST/JSON format generated from vendor console differ from one another.
    - Atm, only the AST generated from Apollo and this code generator is supported.
    """
  )
  var schemaPath: String

  @Option(
    help: """
    Define the codegeneration action
    - dhapiclient: Generate ApiClient specific to DH specification
    - graphqlspec: Generate GraphQL specification
    - introspection: Generate Abstract Syntax Tree from the graphql schema url, local schema source is not supported
    """
  )
  var action: CodegenAction

  @Option(help: "Source of the schema path, \"local\" or \"remote\"")
  var schemaSource: SchemaSource = .local

  @Option(
    help: """
    Path and name of the output file
    - If not path is given, it will generate the output in the current directory
    - If a path is given, it will generate the output with the given directory
    e.g.
    - relative path: "GraphQLSpec.swift", will generate the file in the current directory
    - given path: "/Users/Download/GraphQLSpec.swift", will generate the file in the given "/User/Download" directory
    """
  )
  var output: String

  @Option(help: "Path and name of the config file")
  var configPath: String?

  @Flag(help: "Show extra logging for debugging purposes")
  private var verbose: Bool = false

  static var configuration = CommandConfiguration(
    commandName: "dh-graphql-codegen-ios"
  )

  func run() throws {
    let config = try fetchConfig()
    let generatedCodeData: Data?

    switch action {
    case .introspection:
      generatedCodeData = try fetchRemoteSchema(apiHeaders: config?.apiHeaders).1
    case .dhrepository:
      let schema = try fetchSchema(with: config)
      let generatedCode = try repositorySwiftCode(schema: schema, config: config)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .specification:
      let schema = try fetchSchema(with: config)
      let generatedCode = try specSwiftCode(schema: schema, config: config)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .entity:
      let schema = try fetchSchema(with: config)
      let generatedCode = try graphQLEntitySwiftCode(schema: schema, config: config)
      generatedCodeData = generatedCode.data(using: .utf8)
    }

    FileManager().createFile(atPath: output, contents: generatedCodeData, attributes: [:])
  }
}

// MARK: - Fetch

private extension GraphQLCodegenCLI {
  func fetchSchema(with config: Config?) throws -> Schema {
    switch schemaSource {
    case .local:
      return try fetchLocalSchema()
    case .remote:
      return try fetchRemoteSchema(apiHeaders: config?.apiHeaders).0
    }
  }

  func fetchLocalSchema() throws -> Schema {
    guard let jsonData = try String(contentsOfFile: schemaPath).data(using: .utf8) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    let schema: Schema

    if let introspectionResponse = try? JSONDecoder().decode(IntrospectionResponse.self, from: jsonData) {
      schema = introspectionResponse.schema.schema
    } else if let response = try? JSONDecoder().decode(SchemaResponse.self, from: jsonData)  {
      schema = response.schema
    } else {
      throw GraphQLCodegenCLIError.invalidSchema
    }

    return schema
  }

  func fetchRemoteSchema(apiHeaders: [String: String]?) throws -> (Schema, Data) {
    let semaphore = DispatchSemaphore(value: 0)

    guard let url = URL(string: schemaPath) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    var result: Result<Schema, Error>?
    var data: Data?

    APIClient().fetchIntrospection(
      request: IntroSpectionRequest(),
      url: url,
      headers: apiHeaders ?? [:]
    ) { responseResult, responseData in
      result = responseResult
      data = responseData

      semaphore.signal()
    }

    _ = semaphore.wait(wallTimeout: .distantFuture)

    switch (result, data) {
    case let (.success(schema), .some(data)):
      return (schema, data)
    case let (.failure(error), _):
      throw error
    default:
      throw GraphQLCodegenCLIError.fetchSchemaTimeout
    }
  }

  func fetchConfig() throws -> Config? {
    guard let configPath = configPath else { return nil }

    guard let jsonData = try String(contentsOfFile: configPath).data(using: .utf8) else {
      throw GraphQLCodegenCLIError.invalidConfigPath
    }

    var config: Config?

    do {
      config = try JSONDecoder().decode(Config.self, from: jsonData)
    } catch {
      if verbose {
        print("[Warning] Discarding config, --config-path was given but serialization failed: \(error)")
      } else {
        print("[Warning] Discarding config, --config-path was given but serialization failed")
      }
    }

    return config
  }


}

// MARK: - Generators

private extension GraphQLCodegenCLI {
  func specSwiftCode(schema: Schema, config: Config?) throws -> String {
    let generator = try GraphQLCodegenSpecSwift(
      scalarMap: config?.scalarMap,
      selectionMap: config?.selectionMap,
      entityNameMap: config?.entityNameMap
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func repositorySwiftCode(schema: Schema, config: Config?) throws -> String {
    let generator = try GraphQLCodegenDHApiClientSwift(
      entityNameMap: config?.entityNameMap,
      scalarMap: config?.scalarMap
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func graphQLEntitySwiftCode(schema: Schema, config: Config?) throws -> String {
    let generator = GraphQLCodegenEntitySwift(entityNameMap: config?.entityNameMap)

    let generatoedCode = try generator.code(schema: schema)

    return generatoedCode
  }
}
