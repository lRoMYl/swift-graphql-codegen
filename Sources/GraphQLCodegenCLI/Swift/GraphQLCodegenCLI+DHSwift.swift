//
//  File.swift
//
//
//  Created by Romy Cheah on 7/10/21.
//

import ArgumentParser
import Foundation

extension GraphQLCodegenCLI {
  struct DHSwift: ParsableCommand {
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
    var schemaSource: SchemaSource = .local

    @Option(
      help: """
      Location of the output files
      e.g. outputPath = "root/"
      - entity will be generated in `Core` directory "root/Core/GraphhQLEntities.swift"
      - ApiClient will be generated in `ApiPrefix` directory "root/ApiPrefix/ApiPrefixApiClient.generated.swift"
      - NetworkModesl will be generated in `ApiPrefix` directory "root/ApiPrefix/ApiPrefixNetworkModels.generated.swift"
      """
    )
    var outputPath: String

    @Option
    var introspectionOutput: String = "schema.json"

    @Option
    var entityOutput: String = "Core/GraphQLEntities.generated.swift"

    @Option
    var specificationOutput: String = "NetworkModels.generated.swift"

    @Option
    var apiClientOutput: String = "ApiClient.generated.swift"

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
      var arguments = [schema]

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

        GraphQLCodegenCLI.Codegen.main(arguments)
      case .introspection:
        print("Warning, introspection target is not valid for `dh-swift` subcommand")
        break
      case .specification:
        let basePath = "\(outputPath)\(apiClientPrefix)/\(apiClientPrefix)"

        let dhApiClientArguments = arguments + [
          "--target", CodegenTarget.dhApiClient.rawValue,
          "--output", "\(basePath)\(apiClientOutput)"
        ]

        GraphQLCodegenCLI.Codegen.main(dhApiClientArguments)
      case .dhApiClient:
        let basePath = "\(outputPath)\(apiClientPrefix)/\(apiClientPrefix)"

        let specificiationArguments = arguments + [
          "--target", CodegenTarget.specification.rawValue,
          "--output", "\(basePath)\(specificationOutput)"
        ]

        GraphQLCodegenCLI.Codegen.main(specificiationArguments)
      }
    }
  }
}
