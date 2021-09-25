//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLSwiftCodegen
@testable import GraphQLDownloader
import XCTest

final class RequestParameterSelectionsSpecificationGeneratorTests: XCTestCase {
  func testCampaignsDeclaration() throws {
    let generator = RequestParameterSelectionsGenerator(
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      entityNameMap: EntityNameMap.default
    )

    let campaignRequestField = Field(
      name: "campaigns",
      description: nil,
      args: [],
      type: .named(.object("Campaigns")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let declaration = try generator.declaration(
      field: campaignRequestField,
      objects: schema.objects,
      interfaces: schema.interfaces
    ).format()

    let expected = try #"""
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let campaignAttributeSelections: Set<CampaignAttributeSelection>

      enum CampaignAttributeSelection: String, GraphQLSelection {
        case autoApplied
        case benefits
        case campaignType
        case description
        case discount = """
        discount {
          ...DiscountFragment
        }
        """
        case id
        case name
        case redemptionLimit
        case source
      }

      let campaignsSelections: Set<CampaignsSelection>

      enum CampaignsSelection: String, GraphQLSelection {
        case campaignAttributes = """
        campaignAttributes {
          ...CampaignAttributeFragment
        }
        """
        case productDeals = """
        productDeals {
          ...ProductDealFragment
        }
        """
      }

      let dealSelections: Set<DealSelection>

      enum DealSelection: String, GraphQLSelection {
        case campaignID
        case discountTag
        case triggerQuantity
      }

      let discountSelections: Set<DiscountSelection>

      enum DiscountSelection: String, GraphQLSelection {
        case type
        case value
      }

      let productDealSelections: Set<ProductDealSelection>

      enum ProductDealSelection: String, GraphQLSelection {
        case deals = """
        deals {
          ...DealFragment
        }
        """
        case productID
      }

      func declaration() -> String {
        let campaignAttributeSelectionsDeclaration = """
        fragment CampaignAttributeFragment on CampaignAttribute {\(campaignAttributeSelections.declaration)
        }
        """

        let campaignsSelectionsDeclaration = """
        fragment CampaignsFragment on Campaigns {\(campaignsSelections.declaration)
        }
        """

        let dealSelectionsDeclaration = """
        fragment DealFragment on Deal {\(dealSelections.declaration)
        }
        """

        let discountSelectionsDeclaration = """
        fragment DiscountFragment on Discount {\(discountSelections.declaration)
        }
        """

        let productDealSelectionsDeclaration = """
        fragment ProductDealFragment on ProductDeal {\(productDealSelections.declaration)
        }
        """

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
    """#.format()

    XCTAssertEqual(declaration, expected)
  }

  func testObjectFieldDeclaration() throws {
    let generator = RequestParameterSelectionsGenerator(
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      entityNameMap: EntityNameMap.default
    )

    let campaignRequestField = Field(
      name: "discount",
      description: nil,
      args: [],
      type: .named(.object("Discount")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let schema = try SchemaHelper.schema(with: "CampaignSelectionsTestSchema")

    let declaration = try generator.objectDeclaration(
      field: campaignRequestField,
      objects: schema.objects,
      interfaces: schema.interfaces
    )

    let expected = try #"""
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      let discountSelections: Set<DiscountSelection>

      enum DiscountSelection: String, GraphQLSelection {
        case type
        case value
      }

      func declaration() -> String {
        let discountSelectionsDeclaration = """
        fragment DiscountFragment on Discount {\(discountSelections.declaration)
        }
        """

        let selectionDeclarationMap = [
          "DiscountFragment": discountSelectionsDeclaration
        ]

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "DiscountFragment")
      }
    }
    """#.format()

    XCTAssertEqual(declaration, expected)
  }
}
