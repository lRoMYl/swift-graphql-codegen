//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation
import GraphQLDHApiClientCodegen
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLSwiftCodegen
import GraphQLDownloader

//GraphQLCodegenCLI.main()

//GraphQLCodegenCLI.main(
//  [
//    "https://apollo-fullstack-tutorial.herokuapp.com/",
//    "--schema-source", "remote",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift"
//  ]
//)
//GraphQLCodegenCLI.main(
//  [
//    "https://buybutton.store/graphql",
//    "--schema-source", "remote",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift"
//  ]
//)

GraphQLCodegenCLI.main(
  [
    "https://sg-st.fd-api.com/groceries-product-service/query",
    "--action", "ast",
    "--schema-source", "remote",
    "--output", "/Users/r.cheah/Desktop/schema.json"
  ]
)
GraphQLCodegenCLI.main(
  [
    "/Users/r.cheah/Desktop/schema.json",
    "--action", "graphqlspec",
    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift",
    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
  ]
)
GraphQLCodegenCLI.main(
  [
    "/Users/r.cheah/Desktop/schema.json",
    "--action", "dhapiclient",
    "--output", "/Users/r.cheah/Desktop/ApiClient.swift",
    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
  ]
)
//
//GraphQLCodegenCLI.main(
//  [
//    "/Users/r.cheah/Downloads/schema/schema.json",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift",
//    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
//  ]
//)
//GraphQLCodegenCLI.main(
//  [
//    "/Users/r.cheah/Downloads/schema/schema-interface-obj-input.json",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift",
//    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
//  ]
//)
//GraphQLCodegenCLI.main(
//  [
//    "/Users/r.cheah/Downloads/schema/bigcommerce-schema.json",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift",
//    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
//  ]
//)
//GraphQLCodegenCLI.main(
//  [
//    "/Users/r.cheah/Downloads/schema/apollo-fullstack-tutorial-schema.json",
//    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift",
//    "--config-path", "/Users/r.cheah/Downloads/schema/config.json"
//  ]
//)

enum SchemaSource: String, ExpressibleByArgument {
  case local
  case remote
}

enum CodegenAction: String, ExpressibleByArgument {
  case dhApiClient = "dhapiclient"
  case graphQLSpec = "graphqlspec"
  /**
   Abstract Syntax Tree (AST, Introspection), this is the nested object json created from Schema Definition Language
   - `--schema-source` is ignored when `ast` action option is provided
   - Only remote url is supported when `ast` action option is provided
   */
  case ast = "ast"
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
    - ast: Generate Abstract Syntax Tree from the graphql schema url, local schema source is not supported
    """)
  var action: CodegenAction

  @Option(help: "Source of the schema path, \"local\" or \"remote\"")
  var schemaSource: SchemaSource = .local

  @Option(
    help: """
    Location and name of the output file
    - If not path is given, it will generate the output in the current directory
    - If a path is given, it will generate the output with the given directory
    e.g.
    - relative path: "GraphQLSpec.swift", will generate the file in the current directory
    - given path: "/Users/Download/GraphQLSpec.swift", will generate the file in the given "/User/Download" directory
    """)
  var output: String = "GraphQLSpec.swift"

  @Option(help: "Location of the config json file")
  var configPath: String?

  static var configuration = CommandConfiguration(
    commandName: "dh-graphql-codegen-ios"
  )

  func run() throws {
    let config = try fetchConfig()
    let generatedCode: String
    let generatedCodeData: Data?

    switch action {
    case .dhApiClient:
      let schema = try fetchSchema(with: config)
      generatedCode = try generateApiClientCode(schema: schema, config: config)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .graphQLSpec:
      let schema = try fetchSchema(with: config)
      generatedCode = try generateSwiftCode(schema: schema, config: config)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .ast:
      generatedCodeData = try fetchRemoteSchema(apiHeaders: config?.apiHeaders).1
    }

    FileManager().createFile(atPath: output, contents: generatedCodeData, attributes: [:])
  }
}

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

    let config = try JSONDecoder().decode(Config.self, from: jsonData)

    return config
  }

  func generateSwiftCode(schema: Schema, config: Config?) throws -> String {
    let generator = try GraphQLSwiftCodegen(
      namespace: config?.namespace,
      scalarMap: config?.scalarMap,
      selectionMap: config?.selectionMap,
      entityNameMap: config?.entityNameMap
    )
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }

  func generateApiClientCode(schema: Schema, config: Config?) throws -> String {
    let generator = try GraphQLDHApiClientCodegen(
      namespace: config?.namespace,
      entityNameMap: config?.entityNameMap
    )
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }
}
