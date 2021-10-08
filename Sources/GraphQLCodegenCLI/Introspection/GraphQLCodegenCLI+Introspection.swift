//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import ArgumentParser
import Foundation

extension GraphQLCodegenCLI {
  struct Introspection: ParsableCommand {
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
    var schema: String

    @Option
    var outputPath: String

    @Option
    var output: String = "schema.json"

    func run() throws {
      generateCode()
    }

    func generateCode() {
      var arguments = [
        schema,
        "--schema-source", SchemaSource.remote.rawValue
      ]

      arguments.append(
        contentsOf: [
          "--target", CodegenTarget.introspection.rawValue,
          "--output", "\(outputPath)\(output)"
        ]
      )

      GraphQLCodegenCLI.Codegen.main(arguments)
    }
  }
}
