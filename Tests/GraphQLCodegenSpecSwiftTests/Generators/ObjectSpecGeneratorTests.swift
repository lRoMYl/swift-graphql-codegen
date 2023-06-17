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

final class ObjectSpecGeneratorTests: XCTestCase {
  private let entityNameProvider = EntityNameProvider(
    scalarMap: ScalarMap.default.merging(["Date": "String"], uniquingKeysWith: { _, new in new }),
    entityNameMap: .default
  )

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
        NamedType.object(discountObjectType),
        queryObject(outputType: .named(.object("Discount")))
      ],
      query: "Query"
    )

    let generator = ObjectCodeGenerator(
      isThrowableGetterEnabled: false,
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )
    let declaration = try generator.code(schema: schema).format()

    let expected = try """
    // MARK: - GraphQLObject

    struct DiscountGraphQLObject: Decodable {
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

      private enum CodingKeys: String, CodingKey {
        case internalType = "type"
        case internalValue = "value"
      }
    }

    struct QueryGraphQLObject: Decodable {
      let test: Optional<DiscountGraphQLObject>

      private enum CodingKeys: String, CodingKey {
        case test
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }

  func testDroidStarWarsObject() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let whitelist = ["Droid", "Query"]
    let characterInterfaceObjects = starWarsSchema.types.filter {
      whitelist.contains($0.name)
    }
    let schema = Schema(types: characterInterfaceObjects, query: "Query")

    let generator = ObjectCodeGenerator(
      isThrowableGetterEnabled: false,
      scalarMap: ScalarMap.default.merging(["Date": "String"], uniquingKeysWith: { _, new in new }),
      selectionMap: ["Query": ["droid"]],
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )

    let code = try generator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - GraphQLObject

    struct DroidGraphQLObject: Decodable {
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

      private enum CodingKeys: String, CodingKey {
        case internalAppearsIn = "appearsIn"
        case internalId = "id"
        case internalName = "name"
        case internalPrimaryFunction = "primaryFunction"
      }
    }

    struct QueryGraphQLObject: Decodable {
      let droid: Optional<DroidGraphQLObject?>

      private enum CodingKeys: String, CodingKey {
        case droid
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }

  func testHumanStarWarsObject() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let whitelist = ["Human", "Query"]
    let characterInterfaceObjects = starWarsSchema.types.filter {
      whitelist.contains($0.name)
    }
    let schema = Schema(types: characterInterfaceObjects, query: "Query")

    let generator = ObjectCodeGenerator(
      isThrowableGetterEnabled: false,
      scalarMap: ScalarMap.default.merging(["Date": "String"], uniquingKeysWith: { _, new in new }),
      selectionMap: ["Query": ["human"]],
      entityNameMap: .default,
      entityNameProvider: entityNameProvider
    )

    let code = try generator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - GraphQLObject

    struct HumanGraphQLObject: Decodable {
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

      private enum CodingKeys: String, CodingKey {
        case internalAppearsIn = "appearsIn"
        case internalHomePlanet = "homePlanet"
        case internalId = "id"
        case internalInfoUrl = "infoURL"
        case internalName = "name"
      }
    }

    struct QueryGraphQLObject: Decodable {
      let human: Optional<HumanGraphQLObject?>

      private enum CodingKeys: String, CodingKey {
        case human
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}

private extension ObjectSpecGeneratorTests {
  func queryObject(outputName: String = "test", outputType: OutputTypeRef) -> NamedType {
    NamedType.object(
      ObjectType(
        name: "Query",
        description: nil,
        fields: [
          .init(
            name: "test",
            description: nil,
            args: [],
            type: .nonNull(outputType),
            isDeprecated: false,
            deprecationReason: nil
          )
        ],
        interfaces: []
      )
    )
  }
}
