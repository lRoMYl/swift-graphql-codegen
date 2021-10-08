//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLDownloader

extension GraphQLCodegenCLI.Codegen {
  func fetchSchema(with config: Config?) throws -> Schema {
    switch schemaSource {
    case .local:
      return try fetchLocalSchema()
    case .remote:
      return try fetchRemoteSchema(apiHeaders: config?.apiHeaders).0
    }
  }

  func fetchLocalSchema() throws -> Schema {
    guard let jsonData = try String(contentsOfFile: schema).data(using: .utf8) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    let schema: Schema

    if let introspectionResponse = try? JSONDecoder().decode(IntrospectionResponse.self, from: jsonData) {
      schema = introspectionResponse.schema.schema
    } else if let response = try? JSONDecoder().decode(SchemaResponse.self, from: jsonData) {
      schema = response.schema
    } else {
      throw GraphQLCodegenCLIError.invalidSchema
    }

    return schema
  }

  func fetchRemoteSchema(apiHeaders: [String: String]?) throws -> (Schema, Data) {
    let semaphore = DispatchSemaphore(value: 0)

    guard let url = URL(string: schema) else {
      throw GraphQLCodegenCLIError.invalidSchemaPath
    }

    var result: Result<Schema, Error>?
    var data: Data?

    APIClient().fetchIntrospection(
      request: IntroSpectionRequest(),
      url: url,
      headers: apiHeaders ?? [:]
    ) { responseResult, responseData in
      result = responseResult
      data = responseData

      semaphore.signal()
    }

    _ = semaphore.wait(wallTimeout: .distantFuture)

    switch (result, data) {
    case let (.success(schema), .some(data)):
      return (schema, data)
    case let (.failure(error), _):
      throw error
    default:
      throw GraphQLCodegenCLIError.fetchSchemaTimeout
    }
  }

  func fetchConfig() throws -> Config? {
    // Default config response from the package
    let defaultConfigResponse: ConfigResponse?

    switch platform {
    case .swift:
      defaultConfigResponse = DHCodegenSwift.defaultConfigResponse
    }

    // Config response from parameter
    let configResponse: ConfigResponse?

    if let configPath = configPath {
      do {
        guard let jsonData = try String(contentsOfFile: configPath).data(using: .utf8) else {
          throw GraphQLCodegenCLIError.invalidConfigPath
        }

        configResponse = try JSONDecoder().decode(ConfigResponse.self, from: jsonData)
      } catch {
        if verbose {
          print("[Warning] Discarding config, --config-path was given but serialization failed: \(error)")
        } else {
          print("[Warning] Discarding config, --config-path was given but serialization failed")
        }

        configResponse = nil
      }
    } else {
      configResponse = nil
    }

    switch (defaultConfigResponse, configResponse) {
    case let (.some(defaultConfigResponse), .some(configResponse)):
      let combinedConfigResponse = defaultConfigResponse.merging(configResponse: configResponse)
      return Config(response: combinedConfigResponse)
    case let (.none, .some(configResponse)):
      return Config(response: configResponse)
    case let (.some(defaultConfigResponse), .none):
      return Config(response: defaultConfigResponse)
    case (.none, .none):
      return nil
    }
  }
}
