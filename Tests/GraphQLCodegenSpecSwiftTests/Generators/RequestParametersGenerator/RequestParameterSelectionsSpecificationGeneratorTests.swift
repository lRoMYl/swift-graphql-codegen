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
  private lazy var entityNameStrategy: EntityNamingStrategy = {
    DHEntityNameStrategy(
      scalarMap: .default,
      entityNameMap: .default
    )
  }()
  private lazy var generator: RequestParameterSelectionsGenerator = {
    RequestParameterSelectionsGenerator(
      scalarMap: ScalarMap.default,
      selectionMap: nil,
      entityNameMap: EntityNameMap.default,
      entityNameStrategy: entityNameStrategy
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

      init(
        campaignAttributeSelections: Set<CampaignAttributeSelection> = [],
        campaignsSelections: Set<CampaignsSelection> = [],
        dealSelections: Set<DealSelection> = [],
        discountSelections: Set<DiscountSelection> = [],
        productDealSelections: Set<ProductDealSelection> = []
      ) {
        self.campaignAttributeSelections = campaignAttributeSelections
        self.campaignsSelections = campaignsSelections
        self.dealSelections = dealSelections
        self.discountSelections = discountSelections
        self.productDealSelections = productDealSelections
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
      schema: schema,
      objectTypeMap: schema.objectTypeMap(entityNameStrategy: entityNameStrategy),
      interfaceTypeMap: schema.interfaceTypeMap(entityNameStrategy: entityNameStrategy)
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

      init(
        discountSelections: Set<DiscountSelection> = []
      ) {
        self.discountSelections = discountSelections
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

  func testStarWarCharactersSelection() throws {
    let schema = try SchemaHelper.schema(with: "StarWarsTestSchema")

    let queryOperation = schema.operations.first(where: { $0.type.name == "Query" })!
    let charactersField = queryOperation.type.fields.first(where: { $0.name == "characters" })!

    let code = try generator.code(
      field: charactersField,
      schema: schema
    )
    let formattedCode = try code.format()

    let expected = try #"""
		// MARK: - Selections

		let selections: Selections

		struct Selections: GraphQLSelections {
			let characterSelections: Set<CharacterSelection>

			enum CharacterSelection: String, GraphQLSelection {
				case id
				case name
			}

			init(
				characterSelections: Set<CharacterSelection> = []
			) {
				self.characterSelections = characterSelections
			}

			func declaration() -> String {
				let characterSelectionsDeclaration = """
				fragment CharacterFragment on Character {\(characterSelections.declaration)
					__typename
					... on Droid {
						id
						name
						primaryFunction
						appearsIn
					}
					... on Human {
						id
						name
						homePlanet
						appearsIn
						infoURL
					}
				}
				"""

				let selectionDeclarationMap = [
					"CharacterFragment": characterSelectionsDeclaration
				]

				return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CharacterFragment")
			}
		}
		"""#.format()

    XCTAssertEqual(formattedCode, expected)
  }
}
