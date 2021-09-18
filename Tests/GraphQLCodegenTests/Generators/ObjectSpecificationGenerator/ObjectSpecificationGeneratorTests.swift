//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegen
import XCTest

final class ObjectSpecificationGeneratorTests: XCTestCase {
  func testGeneratedCode() throws {
    let discountObjectType = ObjectType(
      name: "Discount",
      description: nil,
      fields: [
        .init(
          name: "type",
          description: nil,
          args: [],
          type: .nonNull(.named(.object("DiscountType"))),
          isDeprecated: false,
          deprecationReason: nil
        ),
        .init(
          name: "value",
          description: nil,
          args: [],
          type: .nonNull(.named(.scalar("Float"))),
          isDeprecated: false,
          deprecationReason: nil
        )
      ],
      interfaces: []
    )

    let schema = Schema(
      types: [
        NamedType.object(discountObjectType)
      ],
      query: ""
    )

    let generator = ObjectSpecificationGenerator(scalarMap: ScalarMap.default)
    let declaration = try generator.declaration(schema: schema).format()

    let expected = try """
    // MARK: - Objects

    struct Discount: Codable {
      let type: DiscountType

      let value: Double

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case type
        case value
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }
}

