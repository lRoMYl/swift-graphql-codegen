//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegen
import XCTest

final class ObjectFieldSpecificationGeneratorTests: XCTestCase {
  private let defaultGenerator = ObjectFieldSpecificationGenerator(scalarMap: ScalarMap.default)

  func testScalar() throws {
    let field = Field(
      name: "id",
      description: nil,
      args: [],
      type: .nonNull(.named(.scalar("String"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    // Declaration
    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expectation = try """
    let id: String
    """.format()

    XCTAssertEqual(declaration, expectation)
  }

  func testNullableScalar() throws {
    let field = Field(
      name: "id",
      description: nil,
      args: [],
      type: .named(.scalar("String")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expectation = try """
    let id: String?
    """.format()

    XCTAssertEqual(declaration, expectation)
  }

  func testObject() throws {
    let field = Field(
      name: "Discount",
      description: nil,
      args: [],
      type: .nonNull(.named(.object("Discount"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let discount: Discount
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testNullableObject() throws {
    let field = Field(
      name: "Discount",
      description: nil,
      args: [],
      type: .named(.object("Discount")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let discount: Discount?
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testEnum() throws {
    let field = Field(
      name: "CampaignSource",
      description: nil,
      args: [],
      type: .nonNull(.named(.enum("CampaignSource"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let campaignSource: CampaignSource
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testNullableEnum() throws {
    let field = Field(
      name: "CampaignSource",
      description: nil,
      args: [],
      type: .named(.enum("CampaignSource")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let campaignSource: CampaignSource?
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testListScalar() throws {
    let field = Field(
      name: "benefits",
      description: nil,
      args: [],
      type: .nonNull(.list(.nonNull(.named(.scalar("String"))))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let benefits: [String]
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testNullableListScalar() throws {
    let field = Field(
      name: "benefits",
      description: nil,
      args: [],
      type: .list(.nonNull(.named(.scalar("String")))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let benefits: [String]?
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testListNullableScalar() throws {
    let field = Field(
      name: "benefits",
      description: nil,
      args: [],
      type: .nonNull(.list(.named(.scalar("String")))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let benefits: [String?]
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testNullableListNullableScalar() throws {
    let field = Field(
      name: "benefits",
      description: nil,
      args: [],
      type: .list(.named(.scalar("String"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.variableDeclaration(field: field).format()
    let expecation = try """
    let benefits: [String?]?
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testCodingKey() throws {
    let field = Field(
      name: "benefits",
      description: nil,
      args: [],
      type: .named(.scalar("String")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.codingKeyDeclaration(field: field).format()
    let expecation = try """
    case benefits = "benefits"
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testCapitalizedCodingKey() throws {
    let field = Field(
      name: "Benefits",
      description: nil,
      args: [],
      type: .named(.scalar("String")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try defaultGenerator.codingKeyDeclaration(field: field).format()
    let expecation = try """
    case benefits = "Benefits"
    """.format()

    XCTAssertEqual(declaration, expecation)
  }
}
