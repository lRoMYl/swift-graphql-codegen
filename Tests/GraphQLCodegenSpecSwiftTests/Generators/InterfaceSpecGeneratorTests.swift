//
//  File.swift
//
//
//  Created by Romy Cheah on 29/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class InterfaceSpecGeneratorTests: XCTestCase {
  func testGeneratedCode() throws {
    let scalarMap = ScalarMap.default
    let selectionMap: SelectionMap? = nil
    let entityNameMap = EntityNameMap.default
    let entityNameProvider = DHEntityNameProvider(scalarMap: scalarMap, entityNameMap: entityNameMap)

    let interfaceCodeGenerator = InterfaceCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )

    let schema = try Schema.schema(from: "StarWarsTestSchema")

    let code = try interfaceCodeGenerator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - GraphQLInterfaceObject

    enum CharacterGraphQLInterfaceObject: Codable {
      case droid(DroidGraphQLObject)
      case human(HumanGraphQLObject)

      enum Typename: String, Decodable {
        case droid = "Droid"
        case human = "Human"
      }

      private enum CodingKeys: String, CodingKey {
        case __typename
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleValueContainer = try decoder.singleValueContainer()
        let type = try container.decode(Typename.self, forKey: .__typename)

        switch type {
        case .droid:
          let value = try singleValueContainer.decode(DroidGraphQLObject.self)
          self = .droid(value)
        case .human:
          let value = try singleValueContainer.decode(HumanGraphQLObject.self)
          self = .human(value)
        }
      }

      func encode(to _: Encoder) throws {
        fatalError("Not implemented yet")
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
