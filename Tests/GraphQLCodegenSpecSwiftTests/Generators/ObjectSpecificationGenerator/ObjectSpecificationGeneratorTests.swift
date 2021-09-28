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

final class ObjectSpecificationGeneratorTests: XCTestCase {
  func testGeneratedCode() throws {
    let entityNameStrategy = DHEntityNameStrategy(scalarMap: .default, entityNameMap: .default)

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

    let generator = ObjectCodeGenerator(
      scalarMap: ScalarMap.default, selectionMap: nil,
      entityNameMap: .default,
      entityNameStrategy: entityNameStrategy
    )
    let declaration = try generator.code(schema: schema).format()

    let expected = try """
    // MARK: - GraphQLObjects

    enum GraphQLObjects {}

    extension GraphQLObjects {

      struct Discount: Codable {
        let type: GraphQLObjects.DiscountType

        let value: Double

        // MARK: - CodingKeys

        private enum CodingKeys: String, CodingKey {
          case type
          case value
        }
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }
}

