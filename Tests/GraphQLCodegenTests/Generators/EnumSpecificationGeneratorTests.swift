//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegen
import XCTest

final class EnumSpecificationGeneratorTests: XCTestCase {
  func testGenerateEnumSpecification() throws {
    let discountEnumType = EnumType(
      name: "DiscountType",
      description: "Djini discount type",
      enumValues: [
        .init(
          name: "FREE",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        ),
        .init(
          name: "ABSOLUTE",
          description: "Absolute price discount",
          isDeprecated: true,
          deprecationReason: "Deprecated"
        )
      ]
    )

    let campainSourceEnumType = EnumType(
      name: "CampaignSource",
      description: nil,
      enumValues: [
        .init(
          name: "DJINI",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        )
      ]
    )

    let schema = Schema(
      types: [
        NamedType.enum(discountEnumType),
        NamedType.enum(campainSourceEnumType)
      ],
      query: ""
    )

    let generator = EnumSpecificationGenerator(scalarMap: [:])
    let declaration = try generator.declaration(schema: schema).format()

    let expected = try """
    // MARK: - Enums

    /// Djini discount type
    enum DiscountType: String, CaseIterable, Codable {
      case free = "FREE"
      /// Absolute price discount
      @available(*, deprecated, message: "Deprecated")
      case absolute = "ABSOLUTE"
    }

    /// CampaignSource
    enum CampaignSource: String, CaseIterable, Codable {
      case djini = "DJINI"
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }
}
