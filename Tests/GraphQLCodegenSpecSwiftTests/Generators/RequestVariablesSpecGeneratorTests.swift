//
//  File.swift
//  
//
//  Created by Romy Cheah on 16/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class RequestVariablesSpecGeneratorTests: XCTestCase {
  private let generator = RequestVariablesGenerator(
    scalarMap: .default,
    entityNameMap: .default,
    selectionMap: nil,
    entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
  )

  func testCampaignsArgumentVariables() throws {
    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    guard let query = groceriesSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let campaignsQuery = query.type.fields.first(where: { $0.name == "campaigns" }) else {
      XCTFail("Unable to find campaigns query")
      return
    }

    let declaration = try generator
      .argumentVariablesDeclaration(field: campaignsQuery, schema: groceriesSchema)
      .format()
    let expectedDeclaration = try """
    // MARK: - Arguments

    let vendorId: String

    let globalEntityId: String

    let locale: String

    let languageId: String

    let languageCode: String

    let apiKey: String

    let discoClientId: String
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testCampaignsRequestArguments() throws {
    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    guard let query = groceriesSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let campaignsQuery = query.type.fields.first(where: { $0.name == "campaigns" }) else {
      XCTFail("Unable to find campaigns query")
      return
    }

    let declaration = try generator.operationArgumentsDeclaration(with: campaignsQuery)
      .joined(separator: "\n")
      .format()

    let expectedDeclaration = try """
    VendorID: $campaignsVendorId
    GlobalEntityID: $campaignsGlobalEntityId
    Locale: $campaignsLocale
    LanguageID: $campaignsLanguageId
    LanguageCode: $campaignsLanguageCode
    APIKey: $campaignsApiKey
    DiscoClientID: $campaignsDiscoClientId
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testCampaignsRequestVariables() throws {
    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    guard let query = groceriesSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let campaignsQuery = query.type.fields.first(where: { $0.name == "campaigns" }) else {
      XCTFail("Unable to find campaigns query")
      return
    }

    guard let declaration = try generator.operationVariablesDeclaration(
      with: campaignsQuery, schema: groceriesSchema
    )?.format() else {
      XCTFail("Unable to generate code for greeting query")
      return
    }

    let expectedDeclaration = try """
    $campaignsApiKey: String!,
    $campaignsDiscoClientId: String!,
    $campaignsGlobalEntityId: String!,
    $campaignsLanguageCode: String!,
    $campaignsLanguageId: String!,
    $campaignsLocale: String!,
    $campaignsVendorId: String!
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testGreetingArgumentVariables() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let query = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let greetingQuery = query.type.fields.first(where: { $0.name == "greeting" }) else {
      XCTFail("Unable to find greeting query")
      return
    }

    let declaration = try generator
      .argumentVariablesDeclaration(field: greetingQuery, schema: starWarsSchema)
      .format()
    let expectedDeclaration = try """
    // MARK: - Arguments

    let input: GreetingGraphQLInputObject?
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testGreetingRequestArguments() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let query = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let greetingQuery = query.type.fields.first(where: { $0.name == "greeting" }) else {
      XCTFail("Unable to find greeting query")
      return
    }

    let declaration = try generator.operationArgumentsDeclaration(with: greetingQuery)
      .joined(separator: "\n")
      .format()
    let expectedDeclaration = try """
    input: $greetingInput
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testGreetingRequestVariables() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let query = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query")
      return
    }

    guard let greetingQuery = query.type.fields.first(where: { $0.name == "greeting" }) else {
      XCTFail("Unable to find greeting query")
      return
    }

    guard let declaration = try generator.operationVariablesDeclaration(
      with: greetingQuery, schema: starWarsSchema
    )?.format() else {
      XCTFail("Unable to generate code for greeting query")
      return
    }

    let expectedDeclaration = try """
    $greetingInput: Greeting
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
