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
  private let entityNameProvider = DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)

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

    let generator = ObjectCodeGenerator(
      scalarMap: ScalarMap.default, selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )
    let declaration = try generator.code(schema: schema).format()

    let expected = try """
    // MARK: - GraphQLObjects

    struct DiscountGraphQLObjects: Codable {
      let type: DiscountTypeGraphQLObjects

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

  func testDroidStarWarsObject() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let whitelist = ["Droid"]
    let characterInterfaceObjects = starWarsSchema.types.filter {
      whitelist.contains($0.name)
    }
    let schema = Schema(types: characterInterfaceObjects, query: "")

    let generator = ObjectCodeGenerator(
      scalarMap: ScalarMap.default, selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )

    let code = try generator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - GraphQLObjects

    struct DroidGraphQLObjects: Codable {
      let appearsIn: [EpisodeEnum]

      let id: String

      let name: String

      let primaryFunction: String

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case appearsIn
        case id
        case name
        case primaryFunction
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }

  func testHumanStarWarsObject() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let whitelist = ["Human"]
    let characterInterfaceObjects = starWarsSchema.types.filter {
      whitelist.contains($0.name)
    }
    let schema = Schema(types: characterInterfaceObjects, query: "")

    let generator = ObjectCodeGenerator(
      scalarMap: ScalarMap.default, selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )

    let code = try generator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - GraphQLObjects

    struct HumanGraphQLObjects: Codable {
      let appearsIn: [EpisodeEnum]

      /// The home planet of the human, or null if unknown.
      let homePlanet: String?

      let id: String

      let infoUrl: String?

      let name: String

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case appearsIn
        case homePlanet
        case id
        case infoUrl = "infoURL"
        case name
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
