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

final class SelectionSpecGeneratorTests: XCTestCase {
  private let generator = SelectionGenerator(
    scalarMap: .default,
    selectionMap: nil,
    entityNameMap: .default,
    entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
  )

  func testObjectSelection() throws {
    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    let schemaMap = try SchemaMap(schema: groceriesSchema)

    guard let droidObject = groceriesSchema.object(name: "CampaignAttribute") else {
      XCTFail("Unable to find CampaignAttribute object")
      return
    }

    let declaration = try generator.selectionDeclaration(objectType: droidObject, schemaMap: schemaMap).format()
    let expectedDeclaration = try #"""
    enum CampaignAttributeSelection: String, GraphQLSelection {
      case autoApplied
      case benefits = """
      benefits {
        ...%@BenefitFragment
      }
      """
      case campaignEndTime
      case campaignType
      case description
      case discountType
      case discountValue
      case id
      case name
      case redemptionLimit
      case source
    }
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testSelectionEnumCase() throws {
    let declaration = try generator.enumCaseDeclaration(
      name: "queryName",
      arguments: [
        InputValue(name: "inputA", description: nil, type: .named(.scalar("String"))),
        InputValue(name: "inputB", description: nil, type: .named(.scalar("String")))
      ],
      outputRef: .named(.object("ObjectA")),
      scalarMap: .default
    ).format()

    let expectedDeclaration = try #"""
    case queryName = """
    queryName(
      inputA: $%@QueryNameInputA
    inputB: $%@QueryNameInputB
    ) {
      ...%@ObjectAFragment
    }
    """
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }

  func testSelection() throws {
    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let declaration = try generator.code(schema: starWarsSchema).format()
    let expectedDeclaration = try """
    // MARK: - GraphQLSelection

    enum DroidSelection: String, GraphQLSelection {
      case appearsIn
      case id
      case name
      case primaryFunction
    }

    enum HumanSelection: String, GraphQLSelection {
      case appearsIn
      case homePlanet
      case id
      case infoUrl = "infoURL"
      case name
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
