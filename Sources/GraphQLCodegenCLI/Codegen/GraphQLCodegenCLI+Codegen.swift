//
//  File.swift
//  
//
//  Created by Romy Cheah on 8/10/21.
//

import ArgumentParser
import Foundation
import GraphQLAST
import GraphQLCodegenConfig

extension GraphQLCodegenCLI {
  struct Codegen: ParsableCommand {
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

    @Option(
      help: """
      Platform for the generated code
      Atm, the platform is only swift
      """
    )
    var platform: Platform = .swift

    @Option(
      help: """
      Define the codegeneration target
      - dh-apiclient: Generate ApiClient specific to DH specification
      - mapper: Generate optional mapper classes
      - specification: Generate GraphQL specification
      - introspection: Generate Abstract Syntax Tree from the graphql schema url, local schema source is not supported
      - entity: Generate GraphQL entities/base classes
      """
    )
    var target: CodegenTarget

    @Option(help: "Source of the schema path, \"local\" or \"remote\"")
    var schemaSource: SchemaSource = .local

    @Option(
      help: """
      Path and name of the output file
      - If not path is given, it will generate the output in the current directory
      - If a path is given, it will generate the output with the given directory
      e.g.
      - relative path: "GraphQLSpec.swift", will generate the file in the current directory
      - given path: "/Users/Download/GraphQLSpec.swift", will generate the file in the given "/User/Download" directory
      """
    )
    var output: String

    @Option(help: "Path and name of the config file")
    var configPath: String?

    @Flag(help: "Show extra logging for debugging purposes")
    var verbose: Bool = false

    public init() {
    }

    public func run() throws {
      let config = try fetchConfig()
      let generatedCodeData: Data?

      let scalarMap = self.scalarMap(config: config)
      let entityNameMap = self.entityNameMap(config: config)
      let selectionMap = self.selectionMap(config: config)

      try entityNameMap.validate()

      switch platform {
      case .swift:
        generatedCodeData = try swiftCodeData(
          config: config,
          scalarMap: scalarMap,
          entityNameMap: entityNameMap,
          selectionMap: selectionMap
        )
      }

      let success = FileManager().createFile(atPath: output, contents: generatedCodeData, attributes: [:])

      if !success {
        print("Failed to create file at \(output)")
      }
    }
  }
}

// MARK: Codegen + Swift

private extension GraphQLCodegenCLI.Codegen {
  func swiftCodeData(
    config: Config?,
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?
  ) throws -> Data? {
    let generatedCodeData: Data?

    let codegen = DHCodegenSwift(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      selectionMap: selectionMap
    )

    switch target {
    case .introspection:
      generatedCodeData = try fetchRemoteSchema(apiHeaders: config?.schemaApiHeaders).1
    case .dhApiClient:
      let schema = try fetchSchema(with: config)
      let generatedCode = try codegen.repositoryCode(schema: schema)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .mapper:
      let schema = try fetchSchema(with: config)
      let generatedCode = try codegen.mapperCode(schema: schema)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .specification:
      let schema = try fetchSchema(with: config)
      let generatedCode = try codegen.modelCode(schema: schema)
      generatedCodeData = generatedCode.data(using: .utf8)
    case .entity:
      let schema = try fetchSchema(with: config)
      let generatedCode = try codegen.entityCode(schema: schema)
      generatedCodeData = generatedCode.data(using: .utf8)
    }

    return generatedCodeData
  }
}


// MARK: - Map

private extension GraphQLCodegenCLI.Codegen {
  func scalarMap(config: Config?) -> ScalarMap {
    ScalarMap.default.merging(
      config?.scalarMap ?? [:],
      uniquingKeysWith: { _, new in new }
    )
  }

  func selectionMap(config: Config?) -> SelectionMap? {
    config?.selectionMap
  }

  func entityNameMap(config: Config?) -> EntityNameMap {
    config?.entityNameMap ?? .default
  }
}