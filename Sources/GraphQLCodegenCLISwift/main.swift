//
//  File.swift
//  
//
//  Created by Romy Cheah on 6/10/21.
//

import ArgumentParser
import GraphQLCodegenCLICore

//GraphQLCodegenCLISwift.main()

try mockBasicExample()

struct GraphQLCodegenCLISwift {
  static var configuration = CommandConfiguration(
    abstract: "A utility for performing maths.",
    version: "0.0.1",
    subcommands: [Introspection.self, CodegenSwift.self],
    defaultSubcommand: CodegenSwift.self
  )
}

extension GraphQLCodegenCLISwift {
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
    var schemaPath: String

    @Option
    var outputPath: String

    @Option
    var output: String = "schema.json"

    func run() throws {
      generateCode()
    }

    func generateCode() {
      var arguments = [
        schemaPath,
        "--schema-source", SchemaSource.remote.rawValue
      ]

      arguments.append(
        contentsOf: [
          "--target", CodegenTarget.introspection.rawValue,
          "--output", "\(outputPath)\(output)"
        ]
      )

      GraphQLCodegenCLICore.main(arguments)
    }
  }

  struct CodegenSwift: ParsableCommand {
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

    @Option
    var schemaSource: SchemaSource = .local

    @Option(
      help: """
    Location of the output files
    e.g. outputPath = "root/"
    - entity will be generated in `Core` directory "root/Core/GraphhQLEntities.swift"
    - ApiClient will be generated in `ApiPrefix` directory "root/ApiPrefix/ApiPrefixApiClient.swift"
    - NetworkModesl will be generated in `ApiPrefix` directory "root/ApiPrefix/ApiPrefixGraphQLNetworkModels.swift"
    """
    )
    var outputPath: String

    @Option
    var introspectionOutput: String = "schema.json"

    @Option
    var entityOutput: String = "Core/GraphQLEntities.swift"

    @Option
    var specificationOutput: String = "GraphQLNetworkModels.swift"

    @Option
    var apiClientOutput: String = "ApiClient.swift"

    @Option
    var targets: [CodegenTarget] = [.entity, .specification, .dhApiClient]

    @Option(help: "Path and name of the config file")
    var configPath: String?

    @Option
    var apiClientPrefix: String

    func run() throws {
      targets.forEach {
        generateCode(with: $0)
      }
    }

    func generateCode(with target: CodegenTarget) {
      var arguments = [schemaPath]

      // If target type is introspection, ignore the schema source and use remote only
      if target == .introspection {
        arguments.append(contentsOf: ["--schema-source", SchemaSource.remote.rawValue])
      } else {
        arguments.append(contentsOf: ["--schema-source", schemaSource.rawValue])
      }

      if let configPath = configPath {
        arguments.append(
          contentsOf: [
            "--config-path", configPath,
          ]
        )
      }

      switch target {
      case .entity:
        arguments.append(
          contentsOf: [
            "--target", CodegenTarget.entity.rawValue,
            "--output", "\(outputPath)\(entityOutput)"
          ]
        )

        GraphQLCodegenCLICore.main(arguments)
      case .introspection:
        // TODO: Refactor targets to exclude introspection
        break
      case .specification:
        let basePath = "\(outputPath)\(apiClientPrefix)/\(apiClientPrefix)"

        let dhApiClientArguments = arguments + [
          "--target", CodegenTarget.dhApiClient.rawValue,
          "--output", "\(basePath)\(apiClientOutput)"
        ]

        GraphQLCodegenCLICore.main(dhApiClientArguments)
      case .dhApiClient:
        let basePath = "\(outputPath)\(apiClientPrefix)/\(apiClientPrefix)"

        let specificiationArguments = arguments + [
          "--target", CodegenTarget.specification.rawValue,
          "--output", "\(basePath)\(specificationOutput)"
        ]

        GraphQLCodegenCLICore.main(specificiationArguments)
      }
    }
  }
}
