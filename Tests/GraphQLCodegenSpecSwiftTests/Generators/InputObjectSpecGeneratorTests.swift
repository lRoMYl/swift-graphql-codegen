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
import XCTest

final class InputObjectSpecGeneratorTests: XCTestCase {
  func testInputObjects() throws {
    let generator = InputObjectCodeGenerator(
      scalarMap: .default,
      entityNameMap: .default,
      entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let declaration = try generator.code(schema: starWarsSchema).format()
    let expectedDeclaration = try """
    // MARK: - Input Objects

    struct GreetingGraphQLInputObject: Codable {

      let language: LanguageGraphQLEnumObject?

      let name: String

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case language = "language"
        case name = "name"
      }
    }

    struct GreetingOptionsGraphQLInputObject: Codable {
      let prefix: String?

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        case prefix = "prefix"
      }
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
