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

//GraphQLCodegenCLI.main()
//
GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema.json"])
//GraphQLCodegenCLI.main(["/Users/r.cheah/Repos/iOSTutorial/RocketReserver/schema.json"])

struct GraphQLCodegenCLI: ParsableCommand {
  @Argument(help: "Location of the introspection file")
  var schemaPath: String

//  @Option(help: "Location of the output file")
//  var outputPath: String

  static var configuration = CommandConfiguration(
    commandName: "dh-graphql-codegen-ios"
  )

  func run() throws {
    guard let jsonData = try String(contentsOfFile: schemaPath).data(using: .utf8) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    let schemaResponse = try JSONDecoder().decode(IntrospectionQueryResponse.self, from: jsonData)
    let schema = schemaResponse.schema

    let generator = GraphQLCodegen(scalarMap: [:])
    let generatedCode = try generator.generate(schema: schema)

    print(generatedCode)
  }
}

enum GraphQLCodegenCLIError: Error {
  case invalidSchemaPath
}

private struct IntrospectionQueryResponse: Decodable, Equatable {
  public let schema: Schema

  enum CodingKeys: String, CodingKey {
    case schema = "__schema"
  }
}
