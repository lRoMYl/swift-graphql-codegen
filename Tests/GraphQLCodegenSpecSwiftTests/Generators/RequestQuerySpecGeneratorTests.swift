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

final class RequestQuerySpecGeneratorTests: XCTestCase {
  func testRequestQuery() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let droidQuery = starWarsSchema.query.type.fields.first(where: { $0.name == "droid" }) else {
      XCTFail("droid query not found")
      return
    }

    let declaration = try generator.declaration(
      operation: starWarsSchema.query,
      field: droidQuery,
      schema: starWarsSchema
    )
    let expectedDeclaration = try """
    let requestQuery: String = {
      \"\"\"
      droid(
        id: $droidId
      ) {
         ...DroidDroidFragment
      }
      \"\"\"
    }()
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testRequestQueryWithoutArg() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let charactersQuery = starWarsSchema.query.type.fields.first(where: { $0.name == "characters" }) else {
      XCTFail("droid query not found")
      return
    }

    let declaration = try generator.declaration(
      operation: starWarsSchema.query,
      field: charactersQuery,
      schema: starWarsSchema
    )
    let expectedDeclaration = try """
    let requestQuery: String = {
      \"\"\"
      characters {
         ...CharactersCharacterFragment
      }
      \"\"\"
    }()
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testRequestQueryWithoutArgumentAndFragment() throws {
    let generator = self.generator

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let timeQuery = starWarsSchema.query.type.fields.first(where: { $0.name == "time" }) else {
      XCTFail("time query not found")
      return
    }

    let declaration = try generator.declaration(
      operation: starWarsSchema.query,
      field: timeQuery,
      schema: starWarsSchema
    )
    let expectedDeclaration = try """
    let requestQuery: String = {
      \"\"\"
      time
      \"\"\"
    }()
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}

private extension RequestQuerySpecGeneratorTests {
  var generator: RequestQueryCodeGenerator {
    let scalarMap = ScalarMap.default
    let entityNameMap = EntityNameMap.default
    let entityNameProvider = DHEntityNameProvider(scalarMap: scalarMap, entityNameMap: entityNameMap)

    return RequestQueryCodeGenerator(
      variablesGenerator: RequestVariablesGenerator(
        scalarMap: scalarMap,
        entityNameMap: entityNameMap,
        selectionMap: nil,
        entityNameProvider: entityNameProvider
      ),
      entityNameProvider: DHEntityNameProvider(scalarMap: scalarMap, entityNameMap: entityNameMap)
    )
  }
}
