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

final class InterfaceCodeGeneratorTests: XCTestCase {
  func testGeneratedCode() throws {
    let scalarMap = ScalarMap.default
    let selectionMap: SelectionMap? = nil
    let entityNameMap = EntityNameMap.default
    let entityNameStrategy = DHEntityNameStrategy(scalarMap: scalarMap, entityNameMap: entityNameMap)

    let interfaceCodeGenerator = InterfaceCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameStrategy: entityNameStrategy
    )

    let schema = try SchemaHelper.schema(with: "StarWarsTestSchema")

    let code = try interfaceCodeGenerator.code(schema: schema)
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - Interfaces

    struct CharacterInterfaces: Codable {
      enum Object {
        case droid(DroidGraphQLObjects)
        case human(HumanGraphQLObjects)
      }

      enum ObjectType: String, Decodable {
        case droid = "Droid"
        case human = "Human"
      }

      let __typename: ObjectType
      let data: Object

      enum CodingKeys: String, CodingKey {
        case __typename
        case data
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        __typename = try container.decode(ObjectType.self, forKey: .__typename)

        switch __typename {
        case .droid:
          data = .droid(try container.decode(DroidGraphQLObjects.self, forKey: .data))
        case .human:
          data = .human(try container.decode(HumanGraphQLObjects.self, forKey: .data))
        }
      }

      func encode(to encoder: Encoder) throws {
        fatalError("Not implemented")
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
