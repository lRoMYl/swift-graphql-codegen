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

final class RequestParameterSelectionsSpecificationGeneratorTests: XCTestCase {
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
      // MARK: - Operation Definition

      private let operationDefinitionFormat: String = \"\"\"
      campaigns {
      \tcampaigns {
      \t\t...CampaignsFragment
      \t}
      }

      %1$@
      \"\"\"

      var operationDefinition: String {
        String(
          format: operationDefinitionFormat,
          declaration()
        )
      }

      let campaignAttributeSelections: Set<CampaignAttributeSelection>
      let campaignsSelections: Set<CampaignsSelection>

      let productDealSelections: Set<ProductDealSelection>

      init(
        campaignAttributeSelections: Set<CampaignAttributeSelection> = .allFields,
        campaignsSelections: Set<CampaignsSelection> = .allFields,
        productDealSelections: Set<ProductDealSelection> = .allFields
      ) {
        self.campaignAttributeSelections = campaignAttributeSelections
        self.campaignsSelections = campaignsSelections
        self.productDealSelections = productDealSelections
      }

      func declaration() -> String {
        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment CampaignAttributeFragment on CampaignAttribute {
        \t\\(CampaignAttributeSelection.requiredDeclaration)
        \t\\(campaignAttributeSelections.declaration)
        }
        \"\"\"

        let campaignsSelectionsDeclaration = \"\"\"
        fragment CampaignsFragment on Campaigns {
        \t\\(CampaignsSelection.requiredDeclaration)
        \t\\(campaignsSelections.declaration)
        }
        \"\"\"

        let dealSelectionsDeclaration = \"\"\"
        fragment DealFragment on Deal {
        \t\\(DealSelection.requiredDeclaration)
        }
        \"\"\"

        let discountSelectionsDeclaration = \"\"\"
        fragment DiscountFragment on Discount {
        \t\\(DiscountSelection.requiredDeclaration)
        }
        \"\"\"

        let productDealSelectionsDeclaration = \"\"\"
        fragment ProductDealFragment on ProductDeal {
        \t\\(ProductDealSelection.requiredDeclaration)
        \t\\(productDealSelections.declaration)
        }
        \"\"\"

        let selectionDeclarationMap = [
          "CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
          "CampaignsFragment": campaignsSelectionsDeclaration,
          "DealFragment": dealSelectionsDeclaration,
          "DiscountFragment": discountSelectionsDeclaration,
          "ProductDealFragment": productDealSelectionsDeclaration
        ]

        return declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: "CampaignsFragment"
        )
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
      // MARK: - Operation Definition

      private let operationDefinitionFormat: String = \"\"\"
      campaigns {
      \tcampaignAttribute {
      \t\t...CampaignAttributeFragment
      \t}
      }

      %1$@
      \"\"\"

      var operationDefinition: String {
        String(
          format: operationDefinitionFormat,
          declaration()
        )
      }

      let campaignAttributeSelections: Set<CampaignAttributeSelection>

      init(
        campaignAttributeSelections: Set<CampaignAttributeSelection> = .allFields
      ) {
        self.campaignAttributeSelections = campaignAttributeSelections
      }

      func declaration() -> String {
        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment CampaignAttributeFragment on CampaignAttribute {
        \t\\(CampaignAttributeSelection.requiredDeclaration)
        \t\\(campaignAttributeSelections.declaration)
        }
        \"\"\"

        let discountSelectionsDeclaration = \"\"\"
        fragment DiscountFragment on Discount {
        \t\\(DiscountSelection.requiredDeclaration)
        }
        \"\"\"

        let selectionDeclarationMap = [
          "CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
          "DiscountFragment": discountSelectionsDeclaration
        ]

        return declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: "CampaignAttributeFragment"
        )
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
      // MARK: - Operation Definition

      private let operationDefinitionFormat: String = \"\"\"
      campaigns {
      \tcharacters {
      \t\t...CharacterFragment
      \t}
      }

      %1$@
      \"\"\"

      var operationDefinition: String {
        String(
          format: operationDefinitionFormat,
          declaration()
        )
      }

      let humanSelections: Set<HumanSelection>

      init(
        humanSelections: Set<HumanSelection> = .allFields
      ) {
        self.humanSelections = humanSelections
      }

      func declaration() -> String {
        let characterSelectionsDeclaration = \"\"\"
        fragment CharacterFragment on Character {
        \t__typename
        \t...DroidFragment
        \t...HumanFragment
        }
        \"\"\"

        let droidSelectionsDeclaration = \"\"\"
        fragment DroidFragment on Droid {
        \t\\(DroidSelection.requiredDeclaration)
        }
        \"\"\"

        let humanSelectionsDeclaration = \"\"\"
        fragment HumanFragment on Human {
        \t\\(HumanSelection.requiredDeclaration)
        \t\\(humanSelections.declaration)
        }
        \"\"\"

        let selectionDeclarationMap = [
          "CharacterFragment": characterSelectionsDeclaration,
          "DroidFragment": droidSelectionsDeclaration,
          "HumanFragment": humanSelectionsDeclaration
        ]

        return declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: "CharacterFragment"
        )
      }
    }
    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
