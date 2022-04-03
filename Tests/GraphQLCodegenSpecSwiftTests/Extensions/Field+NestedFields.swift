//
//  File.swift
//
//
//  Created by Romy Cheah on 23/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenSpecSwift
@testable import GraphQLCodegenUtil
import XCTest

final class FieldNestedFieldsTests: XCTestCase {
  func testCampaignAttributeNestedFields() throws {
    let campaignRequestField = Field(
      name: "campaignAttribute",
      description: nil,
      args: [],
      type: .named(.object("CampaignAttribute")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let schema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let allNestedFields = try campaignRequestField.nestedTypeFields(
      schema: schema,
      excluded: [],
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      objectTypeMap: schema.objectTypeMap
    )

    XCTAssertEqual(allNestedFields.count, 2)
  }

  func testProductDetailNestedFields() throws {
    let campaignRequestField = Field(
      name: "productDeal",
      description: nil,
      args: [],
      type: .named(.object("ProductDeal")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let schema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let allNestedFields = try campaignRequestField.nestedTypeFields(
      schema: schema,
      excluded: [],
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      objectTypeMap: schema.objectTypeMap
    )

    XCTAssertEqual(allNestedFields.count, 2)
  }
}
