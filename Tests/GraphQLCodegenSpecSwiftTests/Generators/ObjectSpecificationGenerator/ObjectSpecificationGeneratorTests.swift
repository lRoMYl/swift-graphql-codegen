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
    // MARK: - GraphQLObject

    struct DiscountGraphQLObject: Codable {
      private let internalType: Optional<DiscountTypeGraphQLObject>
      private let internalValue: Optional<Double>

      func type() throws -> DiscountTypeGraphQLObject {
        try value(for: \\Self.internalType, codingKey: CodingKeys.internalType)
      }

      func value() throws -> Double {
        try value(for: \\Self.internalValue, codingKey: CodingKeys.internalValue)
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        internalType = try container.decodeOptionalIfPresent(DiscountTypeGraphQLObject.self, forKey: .internalType)
        internalValue = try container.decodeOptionalIfPresent(Double.self, forKey: .internalValue)
      }

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case internalType = "type"
        case internalValue = "value"
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
    // MARK: - GraphQLObject

    struct DroidGraphQLObject: Codable {
      private let internalAppearsIn: Optional<[EpisodeGraphQLEnumObject]>
      private let internalId: Optional<String>
      private let internalName: Optional<String>
      private let internalPrimaryFunction: Optional<String>

      func appearsIn() throws -> [EpisodeGraphQLEnumObject] {
        try value(for: \\Self.internalAppearsIn, codingKey: CodingKeys.internalAppearsIn)
      }

      func id() throws -> String {
        try value(for: \\Self.internalId, codingKey: CodingKeys.internalId)
      }

      func name() throws -> String {
        try value(for: \\Self.internalName, codingKey: CodingKeys.internalName)
      }

      func primaryFunction() throws -> String {
        try value(for: \\Self.internalPrimaryFunction, codingKey: CodingKeys.internalPrimaryFunction)
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        internalAppearsIn = try container.decodeOptionalIfPresent([EpisodeGraphQLEnumObject].self, forKey: .internalAppearsIn)
        internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
        internalName = try container.decodeOptionalIfPresent(String.self, forKey: .internalName)
        internalPrimaryFunction = try container.decodeOptionalIfPresent(String.self, forKey: .internalPrimaryFunction)
      }

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case internalAppearsIn = "appearsIn"
        case internalId = "id"
        case internalName = "name"
        case internalPrimaryFunction = "primaryFunction"
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
    // MARK: - GraphQLObject

    struct HumanGraphQLObject: Codable {
      private let internalAppearsIn: Optional<[EpisodeGraphQLEnumObject]>
      private let internalHomePlanet: Optional<String?>
      private let internalId: Optional<String>
      private let internalInfoUrl: Optional<String?>
      private let internalName: Optional<String>

      func appearsIn() throws -> [EpisodeGraphQLEnumObject] {
        try value(for: \\Self.internalAppearsIn, codingKey: CodingKeys.internalAppearsIn)
      }

      /// The home planet of the human, or null if unknown.
      func homePlanet() throws -> String? {
        try value(for: \\Self.internalHomePlanet, codingKey: CodingKeys.internalHomePlanet)
      }

      func id() throws -> String {
        try value(for: \\Self.internalId, codingKey: CodingKeys.internalId)
      }

      func infoUrl() throws -> String? {
        try value(for: \\Self.internalInfoUrl, codingKey: CodingKeys.internalInfoUrl)
      }

      func name() throws -> String {
        try value(for: \\Self.internalName, codingKey: CodingKeys.internalName)
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        internalAppearsIn = try container.decodeOptionalIfPresent([EpisodeGraphQLEnumObject].self, forKey: .internalAppearsIn)
        internalHomePlanet = try container.decodeOptionalIfPresent(String?.self, forKey: .internalHomePlanet)
        internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
        internalInfoUrl = try container.decodeOptionalIfPresent(String?.self, forKey: .internalInfoUrl)
        internalName = try container.decodeOptionalIfPresent(String.self, forKey: .internalName)
      }

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case internalAppearsIn = "appearsIn"
        case internalHomePlanet = "homePlanet"
        case internalId = "id"
        case internalInfoUrl = "infoURL"
        case internalName = "name"
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
