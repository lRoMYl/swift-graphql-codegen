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
@testable import GraphQLDownloader
import XCTest

final class RequestParameterSelectionsSpecificationGeneratorTests: XCTestCase {
  private lazy var entityNameStrategy: EntityNameProviding = {
    DHEntityNameProvider(
      scalarMap: .default,
      entityNameMap: .default
    )
  }()
  private lazy var generator: RequestParameterSelectionsGenerator = {
    RequestParameterSelectionsGenerator(
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

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(
      field: campaignRequestField,
      schema: schema
    ).format()

    let expected = try """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let campaignAttributeSelections: Set<CampaignAttributeSelection>

      enum CampaignAttributeSelection: String, GraphQLSelection {
        case benefits
        case discount = \"\"\"
        discount {
          ...DiscountFragment
        }
        \"\"\"
      }

      let campaignsSelections: Set<CampaignsSelection>

      enum CampaignsSelection: String, GraphQLSelection {
        case campaignAttributes = \"\"\"
        campaignAttributes {
          ...CampaignAttributeFragment
        }
        \"\"\"
        case productDeals = \"\"\"
        productDeals {
          ...ProductDealFragment
        }
        \"\"\"
      }

      let productDealSelections: Set<ProductDealSelection>

      enum ProductDealSelection: String, GraphQLSelection {
        case deals = \"\"\"
        deals {
          ...DealFragment
        }
        \"\"\"
      }

      init(
        campaignAttributeSelections: Set<CampaignAttributeSelection> = [],
        campaignsSelections: Set<CampaignsSelection> = [],
        productDealSelections: Set<ProductDealSelection> = []
      ) {
        self.campaignAttributeSelections = campaignAttributeSelections
        self.campaignsSelections = campaignsSelections
        self.productDealSelections = productDealSelections
      }

      func declaration() -> String {
        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment CampaignAttributeFragment on CampaignAttribute {
        \tautoApplied
        \tcampaignType
        \tdescription
        \tid
        \tname
        \tredemptionLimit
        \tsource
        \t\\(campaignAttributeSelections.declaration)
        }
        \"\"\"

        let campaignsSelectionsDeclaration = \"\"\"
        fragment CampaignsFragment on Campaigns {
        \t\\(campaignsSelections.declaration)
        }
        \"\"\"

        let dealSelectionsDeclaration = \"\"\"
        fragment DealFragment on Deal {
        \tcampaignID
        \tdiscountTag
        \ttriggerQuantity
        }
        \"\"\"

        let discountSelectionsDeclaration = \"\"\"
        fragment DiscountFragment on Discount {
        \ttype
        \tvalue
        }
        \"\"\"

        let productDealSelectionsDeclaration = \"\"\"
        fragment ProductDealFragment on ProductDeal {
        \tproductID
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

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CampaignsFragment")
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

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let declaration = try generator.objectDeclaration(
      field: campaignRequestField,
      schemaMap: SchemaMap(schema: schema)
    )

    let expected = try """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let campaignAttributeSelections: Set<CampaignAttributeSelection>

      enum CampaignAttributeSelection: String, GraphQLSelection {
        case benefits
        case discount = \"\"\"
        discount {
          ...DiscountFragment
        }
        \"\"\"
      }

      init(
        campaignAttributeSelections: Set<CampaignAttributeSelection> = []
      ) {
        self.campaignAttributeSelections = campaignAttributeSelections
      }

      func declaration() -> String {
        let campaignAttributeSelectionsDeclaration = \"\"\"
        fragment CampaignAttributeFragment on CampaignAttribute {
        \tautoApplied
        \tcampaignType
        \tdescription
        \tid
        \tname
        \tredemptionLimit
        \tsource
        \t\\(campaignAttributeSelections.declaration)
        }
        \"\"\"

        let discountSelectionsDeclaration = \"\"\"
        fragment DiscountFragment on Discount {
        \ttype
        \tvalue
        }
        \"\"\"

        let selectionDeclarationMap = [
          "CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
          "DiscountFragment": discountSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CampaignAttributeFragment")
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }

  func testStarWarCharactersSelection() throws {
    let schema = try SchemaHelper.schema(with: "StarWarsTestSchema")

    let queryOperation = schema.operations.first(where: { $0.type.name == "Query" })!
    let charactersField = queryOperation.type.fields.first(where: { $0.name == "characters" })!

    let code = try generator.code(
      field: charactersField,
      schema: schema
    )
    let formattedCode = try code.format()

    let expected = try """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let humanSelections: Set<HumanSelection>

      enum HumanSelection: String, GraphQLSelection {
        case homePlanet
        case infoURL
      }

      init(
        humanSelections: Set<HumanSelection> = []
      ) {
        self.humanSelections = humanSelections
      }

      func declaration() -> String {
        let characterSelectionsDeclaration = \"\"\"
        fragment CharacterFragment on Character {
        \tid
        \tname
        \t__typename
        \t...DroidFragment
        \t...HumanFragment
        }
        \"\"\"

        let droidSelectionsDeclaration = \"\"\"
        fragment DroidFragment on Droid {
        \tappearsIn
        \tid
        \tname
        \tprimaryFunction
        }
        \"\"\"

        let humanSelectionsDeclaration = \"\"\"
        fragment HumanFragment on Human {
        \tappearsIn
        \tid
        \tname
        \t\\(humanSelections.declaration)
        }
        \"\"\"

        let selectionDeclarationMap = [
          "CharacterFragment": characterSelectionsDeclaration,
          "DroidFragment": droidSelectionsDeclaration,
          "HumanFragment": humanSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CharacterFragment")
      }
    }

    """.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
