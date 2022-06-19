//
//  File.swift
//
//
//  Created by Romy Cheah on 7/10/21.
//

import ArgumentParser
import Foundation
import GraphQLCodegenApiClientSwift

extension GraphQLCodegenCLI {
  struct Bootstrap: ParsableCommand {
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
      - entity will be generated in the given directory "root/GraphhQLEntities.swift"
      - ApiClient will be generated in the given directory "root/ApiPrefixApiClient.generated.swift"
      - NetworkModesl will be generated in the given directory "root/ApiPrefixNetworkModels.generated.swift"
      """
    )
    var outputPath: String

    @Option
    var introspectionOutput: String = "schema.json"

    @Option
    var entityOutput: String = "GraphQLEntities.generated.swift"

    @Option
    var specificationOutput: String = "NetworkModels.generated.swift"

    @Option
    var apiClientOutput: String = "ApiClient.generated.swift"

    @Option
    var mapperOutput: String = "Mappers.generated.swift"

    @Option
    var targets: [CodegenTarget] = [.entity, .specification, .apiClient]

    @Option(help: "Path and name of the config file")
    var configPath: String?

    @Option
    var apiClientPrefix: String

    @Option
    var apiClientStrategy: ApiClientStrategy = .default

    @Flag(help: "Specify if the generated code could use throwable getter introduced in Swift 5.5")
    var isThrowableGetterEnabled: Bool = false

    func run() throws {
      targets.forEach {
        generateCode(with: $0)
      }
    }

    func generateCode(with target: CodegenTarget) {
      var arguments = [schema]

      if isThrowableGetterEnabled {
        arguments.append(contentsOf: ["--is-throwable-getter-enabled"])
      }

      arguments.append(contentsOf: ["--api-client-strategy", apiClientStrategy.rawValue])
      arguments.append(contentsOf: ["--api-client-prefix", apiClientPrefix])

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
        print("Warning, introspection target is not valid for `swift` subcommand")
        break
      case .specification:
        let apiClientArguments = arguments + [
          "--target", CodegenTarget.apiClient.rawValue,
          "--output", "\(outputPath)\(apiClientPrefix)\(apiClientOutput)"
        ]

        GraphQLCodegenCLI.Codegen.main(apiClientArguments)
      case .apiClient:
        let specificiationArguments = arguments + [
          "--target", CodegenTarget.specification.rawValue,
          "--output", "\(outputPath)\(apiClientPrefix)\(specificationOutput)"
        ]

        GraphQLCodegenCLI.Codegen.main(specificiationArguments)
      case .mapper:
        let mapperArguments = arguments + [
          "--target", CodegenTarget.mapper.rawValue,
          "--output", "\(outputPath)\(apiClientPrefix)\(mapperOutput)"
        ]

        GraphQLCodegenCLI.Codegen.main(mapperArguments)
      }
    }
  }
}
