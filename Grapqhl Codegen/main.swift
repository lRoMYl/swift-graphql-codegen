//
//  main.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import ArgumentParser
import Foundation

struct GraphQLCodegenCLI: ParsableCommand {
  @Argument(help: "Location of the introspection file")
  var schemaPath: String

  static var configuration = CommandConfiguration(
    commandName: "dh-graphql-codegen-ios"
  )

  func run() throws {
    // To be rewritten to use relative path in final version
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

//

//GraphQLCodegenCLI.main(["/Users/r.cheah/Downloads/schema.json"])
//GraphQLCodegenCLI.main(["/Users/r.cheah/Repos/iOSTutorial/RocketReserver/schema.json"])
