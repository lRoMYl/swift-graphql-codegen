//
//  File.swift
//  
//
//  Created by Romy Cheah on 16/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
@testable import GraphQLCodegenUtil
@testable import GraphQLDownloader
import XCTest

final class UnionSpecGeneratorTests: XCTestCase {
  func testUnion() throws {
    let generator = UnionCodeGenerator(
      scalarMap: .default,
      selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let schema = try Schema.schema(from: "StarWarsTestSchema")

    let declaration = try generator.code(schema: schema).format()
    let expectedDeclaration = try """
    // MARK: - GraphQLUnionObject

    enum CharacterUnionGraphQLUnionObject: Codable {
      case human(HumanGraphQLObject)
      case droid(DroidGraphQLObject)

      enum Typename: String, Decodable {
        case human = "Human"
        case droid = "Droid"
      }

      private enum CodingKeys: String, CodingKey {
        case __typename
        case appearsIn
        case homePlanet
        case id
        case infoUrl
        case name
        case primaryFunction
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleValueContainer = try decoder.singleValueContainer()
        let type = try container.decode(Typename.self, forKey: .__typename)

        switch type {
        case .human:
          let value = try singleValueContainer.decode(HumanGraphQLObject.self)
          self = .human(value)
        case .droid:
          let value = try singleValueContainer.decode(DroidGraphQLObject.self)
          self = .droid(value)
        }
      }

      func encode(to _: Encoder) throws {
        fatalError("Not implemented yet")
      }
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
