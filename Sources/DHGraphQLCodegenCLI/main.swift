//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation
import DHGraphQLApiClientCodegen
import GraphQLAST
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
    "--schema-source", "remote",
    "--output", "/Users/r.cheah/Desktop/GraphQLSpec.swift"
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

enum GraphQLCodegenCLIError: Error {
  case invalidSchemaPath
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
    """
  )
  var schemaPath: String

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
    let schema = try fetchSchema(with: config)
    let generatedCode = try generateSwiftCode(schema: schema, config: config)

    let generatedCodeData = generatedCode.data(using: .utf8)
    print(try generateApiClientCode(schema: schema))
    FileManager().createFile(atPath: output, contents: generatedCodeData, attributes: [:])
  }
}

private extension GraphQLCodegenCLI {
  func fetchSchema(with config: Config?) throws -> Schema {
    switch schemaSource {
    case .local:
      return try fetchLocalSchema()
    case .remote:
      return try fetchRemoteSchema(apiHeaders: config?.apiHeaders)
    }
  }

  func fetchLocalSchema() throws -> Schema {
    guard let jsonData = try String(contentsOfFile: schemaPath).data(using: .utf8) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    let schemaResponse = try JSONDecoder().decode(SchemaResponse.self, from: jsonData)
    let schema = schemaResponse.schema

    return schema
  }

  func fetchRemoteSchema(apiHeaders: [String: String]?) throws -> Schema {
    let semaphore = DispatchSemaphore(value: 0)

    guard let url = URL(string: schemaPath) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    var result: Result<Schema, Error>?

    APIClient().fetchIntrospection(
      request: IntroSpectionRequest(),
      url: url,
      headers: apiHeaders ?? [:]
    ) { responseResult, data in
      result = responseResult

      semaphore.signal()
    }

    _ = semaphore.wait(wallTimeout: .distantFuture)

    switch result {
    case let .success(schema):
      return schema
    case let .failure(error):
      throw error
    case .none:
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
      scalarMap: config?.scalarMap,
      selectionMap: config?.selectionMap
    )
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }

  func generateApiClientCode(schema: Schema) throws -> String {
    let generator = try DHGraphQLApiClientCodegen()
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }
}
