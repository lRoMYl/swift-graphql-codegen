//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class FieldSpecificationGeneratorTests: XCTestCase {
  private let defaultGenerator = FieldCodeGenerator(
    scalarMap: ScalarMap.default,
    selectionMap: nil,
    entityNameMap: .default,
    entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
  )

  func testScalar() throws {
    let field = Field(
      name: "id",
      description: nil,
      args: [],
      type: .nonNull(.named(.scalar("String"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let declaration = try self.declaration(field: field)
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

    let declaration = try self.declaration(field: field)
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

    let declaration = try self.declaration(field: field)
    let expecation = try """
    let discount: DiscountGraphQLObjects
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

    let declaration = try self.declaration(field: field)
    let expecation = try """
    let discount: DiscountGraphQLObjects?
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

    let declaration = try self.declaration(field: field)
    let expecation = try """
    let campaignSource: CampaignSourceEnum
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

    let declaration = try self.declaration(field: field)
    let expecation = try """
    let campaignSource: CampaignSourceEnum?
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

    let declaration = try self.declaration(field: field)
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

    let declaration = try self.declaration(field: field)
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

    let declaration = try self.declaration(field: field)
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

    let declaration = try self.declaration(field: field)
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

    let declaration = try codingKeyDeclaration(field: field)
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

    let declaration = try codingKeyDeclaration(field: field)
    let expecation = try """
    case benefits = "Benefits"
    """.format()

    XCTAssertEqual(declaration, expecation)
  }
}

private extension FieldSpecificationGeneratorTests {
  func declaration(objectName: String = "object name", field: Field) throws -> String? {
    let object = ObjectType(
      kind: .object,
      name: objectName,
      description: nil,
      fields: [field],
      interfaces: []
    )

    return try defaultGenerator.variableDeclaration(
      object: object,
      field: field
    )?.format()
  }

  func codingKeyDeclaration(
    objectName: String = "object name",
    field: Field
  ) throws -> String? {
    let object = ObjectType(
      kind: .object,
      name: objectName,
      description: nil,
      fields: [field],
      interfaces: []
    )

    return try defaultGenerator.codingKeyDeclaration(
      object: object,
      field: field
    )?.format()
  }
}
