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

final class RequestInitializerSpecGeneratorTests: XCTestCase {
  func testGreetingQueryRequestInitializer() throws {
    let generator = RequestInitializerGenerator(
      scalarMap: .default,
      entityNameMap: .default,
      selectionMap: nil,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let queryOperation = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query operation")
      return
    }
    guard let greetingQuery = queryOperation.type.fields.first(where: { $0.name == "greeting" }) else {
      XCTFail("Unable to find greeting query")
      return
    }

    let declaration = try generator.declaration(with: greetingQuery, schema: starWarsSchema).format()
    let expectedDeclaration = try """
    init(
      input: GreetingGraphQLInputObject?
    ) {
      self.input = input
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testMutationRequestInitializer() throws {
    let generator = RequestInitializerGenerator(
      scalarMap: .default,
      entityNameMap: .default,
      selectionMap: nil,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let queryOperation = starWarsSchema.operations.first(where: { $0.requestTypeName == "mutation" }) else {
      XCTFail("Unable to find mutation operation")
      return
    }

    let declaration = try generator.declaration(with: queryOperation).format()
    let expectedDeclaration = try """
    init(
      mutate: MutateGraphQLMutation? = nil
    ) {
      self.mutate = mutate
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testQueryRequestInitializer() throws {
    let generator = RequestInitializerGenerator(
      scalarMap: .default,
      entityNameMap: .default,
      selectionMap: nil,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let queryOperation = starWarsSchema.operations.first(where: { $0.requestTypeName == "query" }) else {
      XCTFail("Unable to find query operation")
      return
    }

    let declaration = try generator.declaration(with: queryOperation).format()
    let expectedDeclaration = try """
    init(
      character: CharacterGraphQLQuery? = nil,
      characters: CharactersGraphQLQuery? = nil,
      droid: DroidGraphQLQuery? = nil,
      droids: DroidsGraphQLQuery? = nil,
      greeting: GreetingGraphQLQuery? = nil,
      human: HumanGraphQLQuery? = nil,
      humans: HumansGraphQLQuery? = nil,
      luke: LukeGraphQLQuery? = nil,
      time: TimeGraphQLQuery? = nil,
      whoami: WhoamiGraphQLQuery? = nil
    ) {
      self.character = character
      self.characters = characters
      self.droid = droid
      self.droids = droids
      self.greeting = greeting
      self.human = human
      self.humans = humans
      self.luke = luke
      self.time = time
      self.whoami = whoami
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
