//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenMapperSwift
import GraphQLCodegenNameSwift
import GraphQLCodegenSpecSwift
import GraphQLCodegenDHApiClientSwift

struct DHCodegenSwift {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let selectionMap: SelectionMap?

  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?
  ) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap

    self.entityNameProvider = DHEntityNameProvider(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap
    )
  }

  func modelCode(
    schema: Schema
  ) throws -> String {
    let generator = try GraphQLCodegenModelSwift(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func repositoryCode(
    schema: Schema
  ) throws -> String {
    let generator = try GraphQLCodegenDHApiClientSwift(
      entityNameMap: entityNameMap,
      scalarMap: scalarMap,
      entityNameProvider: entityNameProvider
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func mapperCode(
    schema: Schema
  ) throws -> String {
    let generator = try GraphQLCodegenMapperSwift(
      entityNameMap: entityNameMap,
      scalarMap: scalarMap,
      entityNameProvider: entityNameProvider
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func entityCode(schema: Schema) throws -> String {
    let generator = GraphQLCodegenEntitySwift(entityNameMap: entityNameMap)

    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  static var defaultConfigResponse: ConfigResponse? {
    let defaultConfigResponse: ConfigResponse?

    if let defaultConfigPath = GraphQLCodegenSpecSwiftConfig.defaultConfigPath {
      do {
        guard let defaultJsonData = try String(contentsOfFile: defaultConfigPath).data(using: .utf8) else {
          throw GraphQLCodegenCLIError.invalidConfigPath
        }

        let config = try JSONDecoder().decode(ConfigResponse.self, from: defaultJsonData)
        defaultConfigResponse = config
      } catch {
        print("[Warning] Discarding package config, package defaultConfigPath was given but serialization failed")

        defaultConfigResponse = nil
      }
    } else {
      defaultConfigResponse = nil
    }

    return defaultConfigResponse
  }
}
