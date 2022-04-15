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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalId: Optional<String>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func id() throws -> String {
      try value(for: \\Self.internalId, codingKey: CodingKeys.internalId)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalId: Optional<String?>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func id() throws -> String? {
      try value(for: \\Self.internalId, codingKey: CodingKeys.internalId)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalDiscount: Optional<DiscountGraphQLObject>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func discount() throws -> DiscountGraphQLObject {
      try value(for: \\Self.internalDiscount, codingKey: CodingKeys.internalDiscount)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalDiscount: Optional<DiscountGraphQLObject?>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func discount() throws -> DiscountGraphQLObject? {
      try value(for: \\Self.internalDiscount, codingKey: CodingKeys.internalDiscount)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalCampaignSource: Optional<CampaignSourceGraphQLEnumObject>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func campaignSource() throws -> CampaignSourceGraphQLEnumObject {
      try value(for: \\Self.internalCampaignSource, codingKey: CodingKeys.internalCampaignSource)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalCampaignSource: Optional<CampaignSourceGraphQLEnumObject?>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func campaignSource() throws -> CampaignSourceGraphQLEnumObject? {
      try value(for: \\Self.internalCampaignSource, codingKey: CodingKeys.internalCampaignSource)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalBenefits: Optional<[String]>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func benefits() throws -> [String] {
      try value(for: \\Self.internalBenefits, codingKey: CodingKeys.internalBenefits)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalBenefits: Optional<[String]?>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func benefits() throws -> [String]? {
      try value(for: \\Self.internalBenefits, codingKey: CodingKeys.internalBenefits)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalBenefits: Optional<[String?]>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func benefits() throws -> [String?] {
      try value(for: \\Self.internalBenefits, codingKey: CodingKeys.internalBenefits)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalBenefits: Optional<[String?]?>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field)
    let publicVariableExpectation = try """
    func benefits() throws -> [String?]? {
      try value(for: \\Self.internalBenefits, codingKey: CodingKeys.internalBenefits)
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
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
    case internalBenefits = "benefits"
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
    case internalBenefits = "Benefits"
    """.format()

    XCTAssertEqual(declaration, expecation)
  }

  func testThrowableGetter() throws {
    let field = Field(
      name: "id",
      description: nil,
      args: [],
      type: .nonNull(.named(.scalar("String"))),
      isDeprecated: false,
      deprecationReason: nil
    )

    let internalVariableDeclaration = try self.internalVariableDeclaration(field: field)
    let internalVariableExpectation = try """
    private let internalId: Optional<String>
    """.format()

    let publicVariableDeclaration = try self.publicVariableDeclaration(field: field, isThrowableGetterEnabled: true)
    let publicVariableExpectation = try """
    var id: String {
      get throws { try value(for: \\Self.internalId, codingKey: CodingKeys.internalId) }
    }
    """.format()

    XCTAssertEqual(internalVariableDeclaration, internalVariableExpectation)
    XCTAssertEqual(publicVariableDeclaration, publicVariableExpectation)
  }
}

private extension FieldSpecificationGeneratorTests {
  func internalVariableDeclaration(objectName: String = "object name", field: Field) throws -> String? {
    let object = ObjectType(
      kind: .object,
      name: objectName,
      description: nil,
      fields: [field],
      interfaces: []
    )

    return try defaultGenerator.internalVariableDeclaration(
      object: object,
      field: field
    )?.format()
  }

  func publicVariableDeclaration(
    objectName: String = "object name",
    field: Field,
    isThrowableGetterEnabled: Bool = false
  ) throws -> String? {
    let object = ObjectType(
      kind: .object,
      name: objectName,
      description: nil,
      fields: [field],
      interfaces: []
    )

    return try defaultGenerator.publicVariableDeclaration(
      object: object,
      field: field,
      isThrowableGetterEnabled: isThrowableGetterEnabled
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
