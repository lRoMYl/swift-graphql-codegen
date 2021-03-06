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
import GraphQLCodegenApiClientSwift

struct CodegenSwift {
  private let isThrowableGetterEnabled: Bool
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let selectionMap: SelectionMap?
  private let apiClientPrefix: String
  private let apiClientStrategy: ApiClientStrategy

  private let entityNameProvider: EntityNameProviding

  init(
    isThrowableGetterEnabled: Bool,
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?,
    apiClientPrefix: String,
    apiClientStrategy: ApiClientStrategy
  ) {
    self.isThrowableGetterEnabled = isThrowableGetterEnabled
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap
    self.apiClientPrefix = apiClientPrefix
    self.apiClientStrategy = apiClientStrategy

    self.entityNameProvider = EntityNameProvider(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap
    )
  }

  func modelCode(
    schema: Schema
  ) throws -> String {
    let generator = try GraphQLCodegenModelSwift(
      isThrowableGetterEnabled: isThrowableGetterEnabled,
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
    let generator = try GraphQLCodegenApiClientSwift(
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      scalarMap: scalarMap,
      entityNameProvider: entityNameProvider,
      apiClientPrefix: apiClientPrefix,
      apiClientStrategy: apiClientStrategy
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
