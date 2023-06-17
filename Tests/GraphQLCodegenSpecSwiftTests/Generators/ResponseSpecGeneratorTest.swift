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

final class ResponseSpecGeneratorTests: XCTestCase {
  func testLukeResponse() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    guard let queryOperation = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("query operation not found")
      return
    }
    guard let lukeQueryResponse = queryOperation.type.fields.first(where: { $0.name == "luke" }) else {
      XCTFail("luke query response not found")
      return
    }

    let declaration = try generator.code(field: lukeQueryResponse, operation: queryOperation).format()
    let expectedDeclaration = try """
    struct LukeQueryResponse: Decodable {
      let luke: HumanGraphQLObject?
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testMutationResponse() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let mutationOperation = starWarsSchema.operations.first(where: { $0.requestTypeName == "mutation" }) else {
      XCTFail("mutation operation not found")
      return
    }

    let declaration = try generator.code(operation: mutationOperation).format()
    let expectedDeclaration = try """
    struct MutateMutationResponse: Decodable {
      let mutate: Bool
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testResponse() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    let declaration = try generator.code(schema: starWarsSchema).format()
    let expectedDeclaration = try """
    struct CharacterQueryResponse: Decodable {
      let character: CharacterUnionGraphQLUnionObject?
    }

    struct CharactersQueryResponse: Decodable {
      let characters: [CharacterGraphQLInterfaceObject]
    }

    struct DroidQueryResponse: Decodable {
      let droid: DroidGraphQLObject?
    }

    struct DroidsQueryResponse: Decodable {
      let droids: [DroidGraphQLObject]
    }

    struct GreetingQueryResponse: Decodable {
      let greeting: String
    }

    struct HumanQueryResponse: Decodable {
      let human: HumanGraphQLObject?
    }

    struct HumansQueryResponse: Decodable {
      let humans: [HumanGraphQLObject]
    }

    struct LukeQueryResponse: Decodable {
      let luke: HumanGraphQLObject?
    }

    struct TimeQueryResponse: Decodable {
      let time: Date
    }

    struct WhoamiQueryResponse: Decodable {
      let whoami: String
    }

    struct MutateMutationResponse: Decodable {
      let mutate: Bool
    }

    struct NumberSubscriptionResponse: Decodable {
      let number: Int
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}

private extension ResponseSpecGeneratorTests {
  var generator: ResponseCodeGenerator {
    let scalarMap = ScalarMap
      .default
      .merging(["Date": "Date"], uniquingKeysWith: { new, _ in new })

    return ResponseCodeGenerator(
      entityNameMap: .default,
      selectionMap: nil,
      entityNameProvider: EntityNameProvider(scalarMap: scalarMap, entityNameMap: .default)
    )
  }
}
