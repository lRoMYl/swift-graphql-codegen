//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenSpecSwift
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

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let allNestedFields = try campaignRequestField.nestedFields(
      objects: schema.objects, scalarMap: ScalarMap.default, excluded: []
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

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let allNestedFields = try campaignRequestField.nestedFields(
      objects: schema.objects, scalarMap: ScalarMap.default, excluded: []
    )

    XCTAssertEqual(allNestedFields.count, 2)
  }
}
