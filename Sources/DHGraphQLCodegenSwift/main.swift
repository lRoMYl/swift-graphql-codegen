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

GraphQLCodegenCLI.main(["https://apollo-fullstack-tutorial.herokuapp.com/", "--schema-path-source", "remote"])
//
//GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema.json"])
//GraphQLCodegenCLI.main(["/Users/r.cheah/Repos/iOSTutorial/RocketReserver/schema.json"])

enum SchemaPathSource: String, ExpressibleByArgument {
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
  var schemaPathSource: SchemaPathSource = .local

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
    switch schemaPathSource {
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
    let generator = GraphQLCodegen(scalarMap: [:])
    let generatedCode = try generator.generate(schema: schema)

    return generatedCode
  }
}
