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
    DHEntityNameProvider(
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
    // MARK: - Selections

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
        let capitalizedRequestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let benefitSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)BenefitFragment on Benefit {
        \t\\(benefitSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)CampaignAttributeFragment on CampaignAttribute {
        \t\\(campaignAttributeSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let campaignsSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)CampaignsFragment on Campaigns {
        \t\\(campaignsSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let dealSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)DealFragment on Deal {
        \t\\(dealSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let productDealSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)ProductDealFragment on ProductDeal {
        \t\\(productDealSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let selectionDeclarationMap = [
          "\\(capitalizedRequestName)BenefitFragment": benefitSelectionsDeclaration,
          "\\(capitalizedRequestName)CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
          "\\(capitalizedRequestName)CampaignsFragment": campaignsSelectionsDeclaration,
          "\\(capitalizedRequestName)DealFragment": dealSelectionsDeclaration,
          "\\(capitalizedRequestName)ProductDealFragment": productDealSelectionsDeclaration
        ]

        let fragmentMaps = rootSelectionKeys
          .map {
            requestFragments(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }

        return fragmentMaps.values.joined(separator: "\\n")
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
    // MARK: - Selections

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
        let capitalizedRequestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let benefitSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)BenefitFragment on Benefit {
        \t\\(benefitSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)CampaignAttributeFragment on CampaignAttribute {
        \t\\(campaignAttributeSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let selectionDeclarationMap = [
          "\\(capitalizedRequestName)BenefitFragment": benefitSelectionsDeclaration,
          "\\(capitalizedRequestName)CampaignAttributeFragment": campaignAttributeSelectionsDeclaration
        ]

        let fragmentMaps = rootSelectionKeys
          .map {
            requestFragments(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }

        return fragmentMaps.values.joined(separator: "\\n")
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
    // MARK: - Selections

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
        let capitalizedRequestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

        let characterSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)CharacterFragment on Character {
        \t__typename
        \t...\\(capitalizedRequestName)DroidFragment
        \t...\\(capitalizedRequestName)HumanFragment
        }
        \"\"\"

        let droidSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)DroidFragment on Droid {
        \t\\(droidSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let humanSelectionsDeclaration = \"\"\"
        fragment \\(capitalizedRequestName)HumanFragment on Human {
        \t\\(humanSelections.requestFragments(requestName: capitalizedRequestName))
        }
        \"\"\"

        let selectionDeclarationMap = [
          "\\(capitalizedRequestName)CharacterFragment": characterSelectionsDeclaration,
          "\\(capitalizedRequestName)DroidFragment": droidSelectionsDeclaration,
          "\\(capitalizedRequestName)HumanFragment": humanSelectionsDeclaration
        ]

        let fragmentMaps = rootSelectionKeys
          .map {
            requestFragments(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }

        return fragmentMaps.values.joined(separator: "\\n")
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
