//
//  File.swift
//
//
//  Created by Romy Cheah on 23/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
@testable import GraphQLCodegenUtil
@testable import GraphQLDownloader
import XCTest

final class SelectionsSpecGeneratorTests: XCTestCase {
  private lazy var entityNameStrategy: EntityNameProviding = {
    EntityNameProvider(
      scalarMap: .default,
      entityNameMap: .default
    )
  }()

  private lazy var generator: SelectionsGenerator = {
    SelectionsGenerator(
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      entityNameMap: EntityNameMap.default,
      entityNameProvider: entityNameStrategy
    )
  }()

  func testCampaignsDeclaration() throws {
    let campaignRequestField = Field(
      name: "campaigns",
      description: nil,
      args: [],
      type: .named(.object("Campaigns")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let operation = GraphQLAST.Operation.query(
      ObjectType(name: "Campaigns", description: nil, fields: [], interfaces: [])
    )

    let schema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(
      operation: operation,
      field: campaignRequestField,
      schema: schema
    ).format()

    let expected = try """
    struct CampaignsGraphQLQuerySelections: GraphQLSelections {
      let benefitSelections: Set<BenefitSelection>
      let campaignAttributeSelections: Set<CampaignAttributeSelection>
      let campaignsSelections: Set<CampaignsSelection>
      let dealSelections: Set<DealSelection>
      let productDealSelections: Set<ProductDealSelection>

      init(
        benefitSelections: Set<BenefitSelection> = .allFields,
        campaignAttributeSelections: Set<CampaignAttributeSelection> = .allFields,
        campaignsSelections: Set<CampaignsSelection> = .allFields,
        dealSelections: Set<DealSelection> = .allFields,
        productDealSelections: Set<ProductDealSelection> = .allFields
      ) {
        self.benefitSelections = benefitSelections
        self.campaignAttributeSelections = campaignAttributeSelections
        self.campaignsSelections = campaignsSelections
        self.dealSelections = dealSelections
        self.productDealSelections = productDealSelections
      }

      func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
        let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let selectionDeclarationMap = Dictionary(
          uniqueKeysWithValues: [
            benefitSelections.requestFragment(requestName: requestName),
            campaignAttributeSelections.requestFragment(requestName: requestName),
            campaignsSelections.requestFragment(requestName: requestName),
            dealSelections.requestFragment(requestName: requestName),
            productDealSelections.requestFragment(requestName: requestName)
          ].map { ($0.key, $0.value) }
        )

        let fragments = nestedRequestFragments(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKeys: rootSelectionKeys
        )

        return fragments.joined(separator: "\\n\\n")
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }

  func testObjectFieldDeclaration() throws {
    let campaignRequestField = Field(
      name: "campaignAttribute",
      description: nil,
      args: [],
      type: .named(.object("CampaignAttribute")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let operation = GraphQLAST.Operation.query(
      ObjectType(name: "Campaigns", description: nil, fields: [], interfaces: [])
    )

    let schema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.objectDeclaration(
      operation: operation,
      field: campaignRequestField,
      schemaMap: SchemaMap(schema: schema)
    )

    let expected = try """
    struct CampaignAttributeGraphQLQuerySelections: GraphQLSelections {
      let benefitSelections: Set<BenefitSelection>
      let campaignAttributeSelections: Set<CampaignAttributeSelection>

      init(
        benefitSelections: Set<BenefitSelection> = .allFields,
        campaignAttributeSelections: Set<CampaignAttributeSelection> = .allFields
      ) {
        self.benefitSelections = benefitSelections
        self.campaignAttributeSelections = campaignAttributeSelections
      }

      func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
        let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let selectionDeclarationMap = Dictionary(
          uniqueKeysWithValues: [
            benefitSelections.requestFragment(requestName: requestName),
            campaignAttributeSelections.requestFragment(requestName: requestName)
          ].map { ($0.key, $0.value) }
        )

        let fragments = nestedRequestFragments(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKeys: rootSelectionKeys
        )

        return fragments.joined(separator: "\\n\\n")
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }

  func testStarWarCharactersSelection() throws {
    let schema = try Schema.schema(from: "StarWarsTestSchema")

    let queryOperation = schema.operations.first(where: { $0.type.name == "Query" })!
    let charactersField = queryOperation.type.fields.first(where: { $0.name == "characters" })!

    let operation = GraphQLAST.Operation.query(
      ObjectType(name: "Campaigns", description: nil, fields: [], interfaces: [])
    )

    let code = try generator.code(
      operation: operation,
      field: charactersField,
      schema: schema
    )
    let formattedCode = try code.format()

    let expected = try """
    struct CharactersGraphQLQuerySelections: GraphQLSelections {
      let droidSelections: Set<DroidSelection>
      let humanSelections: Set<HumanSelection>

      init(
        droidSelections: Set<DroidSelection> = .allFields,
        humanSelections: Set<HumanSelection> = .allFields
      ) {
        self.droidSelections = droidSelections
        self.humanSelections = humanSelections
      }

      func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
        let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let selectionDeclarationMap = Dictionary(
          uniqueKeysWithValues: [
            requestFragment(
              requestName: requestName,
              typeName: "Character",
              possibleTypeNames: CharacterGraphQLInterfaceObject.TypeName.allCases.map {
                $0.rawValue
              }
            ),
            droidSelections.requestFragment(requestName: requestName),
            humanSelections.requestFragment(requestName: requestName)
          ].map { ($0.key, $0.value) }
        )

        let fragments = nestedRequestFragments(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKeys: rootSelectionKeys
        )

        return fragments.joined(separator: "\\n\\n")
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
