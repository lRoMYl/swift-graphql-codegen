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
  private let apiClientPrefix: String

  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?,
    apiClientPrefix: String
  ) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap
    self.apiClientPrefix = apiClientPrefix

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
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      scalarMap: scalarMap,
      entityNameProvider: entityNameProvider,
      apiClientPrefix: apiClientPrefix
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
      selectionMap: selectionMap,
      entityNameProvider: entityNameProvider
    )
    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  func entityCode(schema: Schema) throws -> String {
    let generator = GraphQLCodegenEntitySwift(
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )

    let generatedCode = try generator.code(schema: schema)

    return generatedCode
  }

  static var defaultConfigResponse: ConfigResponse? {
    return GraphQLCodegenSpecSwiftConfig.defaultConfigResponse
  }
}
