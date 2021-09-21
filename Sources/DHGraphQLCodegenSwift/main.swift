//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation
import GraphQLAST
import GraphQLCodegen
import GraphQLDownloader

GraphQLCodegenCLI.main()

//GraphQLCodegenCLI.main(["https://apollo-fullstack-tutorial.herokuapp.com/", "--schema-source-type", "remote"])
//GraphQLCodegenCLI.main(["https://buybutton.store/graphql", "--schema-source-type", "remote"])
//GraphQLCodegenCLI.main(["https://sg-st.fd-api.com/groceries-product-service/query", "--schema-source-type", "remote"])
//
//GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema/schema.json"])
//GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema/bigcommerce-schema.json"])
//GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema/apollo-fullstack-tutorial-schema.json"])

enum SchemaSourceType: String, ExpressibleByArgument {
  case local
  case remote
}

enum GraphQLCodegenCLIError: Error {
  case invalidSchemaPath
  case fetchSchemaTimeout
}

struct GraphQLCodegenCLI: ParsableCommand {
  @Argument(help: "Location of the introspection file")
  var schemaPath: String

  @Option(help: "Source of the schema path, local & remote")
  var schemaSourceType: SchemaSourceType = .local

//  @Option(help: "Location of the output file")
//  var outputPath: String

  static var configuration = CommandConfiguration(
    commandName: "dh-graphql-codegen-ios"
  )

  func run() throws {
    let schema = try fetchSchema()
    let generatedCode = try generateCode(with: schema)

    print(generatedCode)
  }
}

private extension GraphQLCodegenCLI {
  func fetchSchema() throws -> Schema {
    switch schemaSourceType {
    case .local:
      return try fetchLocalSchema()
    case .remote:
      return try fetchRemoteSchema()
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

  func fetchRemoteSchema() throws -> Schema {
    let semaphore = DispatchSemaphore(value: 0)

    guard let url = URL(string: schemaPath) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    var result: Result<Schema, Error>?

    APIClient().fetchIntrospection(
      request: IntroSpectionRequest(),
      url: url,
      headers: [:]
    ) { responseResult in
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

  func generateCode(with schema: Schema) throws -> String {
    let generator = GraphQLCodegen(
      scalarMap: [
        "BigDecimal": "Double",
        "DateTime": "Double",
        "Long": "Double",
        "Upload": "String"
      ]
    )
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }
}
