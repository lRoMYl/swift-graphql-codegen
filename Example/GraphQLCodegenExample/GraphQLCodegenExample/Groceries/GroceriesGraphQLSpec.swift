// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - Enum

enum CampaignSourceEnum: RawRepresentable, Codable {
  typealias RawValue = String

  case djini

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "DJINI": self = .djini
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .djini: return "DJINI"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: CampaignSourceEnum, rhs: CampaignSourceEnum) -> Bool {
    switch (lhs, rhs) {
    case (.djini, .djini): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

enum CampaignTypeEnum: RawRepresentable, Codable {
  typealias RawValue = String

  case strikeThrough

  case sameItemBundle

  case mixAndMatchSame

  case mixAndMatchDifferent

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "StrikeThrough": self = .strikeThrough
    case "SameItemBundle": self = .sameItemBundle
    case "MixAndMatchSame": self = .mixAndMatchSame
    case "MixAndMatchDifferent": self = .mixAndMatchDifferent
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .strikeThrough: return "StrikeThrough"
    case .sameItemBundle: return "SameItemBundle"
    case .mixAndMatchSame: return "MixAndMatchSame"
    case .mixAndMatchDifferent: return "MixAndMatchDifferent"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: CampaignTypeEnum, rhs: CampaignTypeEnum) -> Bool {
    switch (lhs, rhs) {
    case (.strikeThrough, .strikeThrough): return true
    case (.sameItemBundle, .sameItemBundle): return true
    case (.mixAndMatchSame, .mixAndMatchSame): return true
    case (.mixAndMatchDifferent, .mixAndMatchDifferent): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

enum DiscountTypeEnum: RawRepresentable, Codable {
  typealias RawValue = String

  case free

  case absolute

  case percentage

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "FREE": self = .free
    case "ABSOLUTE": self = .absolute
    case "PERCENTAGE": self = .percentage
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .free: return "FREE"
    case .absolute: return "ABSOLUTE"
    case .percentage: return "PERCENTAGE"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: DiscountTypeEnum, rhs: DiscountTypeEnum) -> Bool {
    switch (lhs, rhs) {
    case (.free, .free): return true
    case (.absolute, .absolute): return true
    case (.percentage, .percentage): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

// MARK: - ResponseModel

struct BenefitResponseModel: Codable {
  let productId: String

  let quantity: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case productId = "productID"
    case quantity
  }
}

struct CampaignAttributeResponseModel: Codable {
  let autoApplied: Bool

  let benefits: [BenefitResponseModel]?

  let campaignType: CampaignTypeEnum

  let description: String

  let id: String

  let name: String

  let redemptionLimit: Double

  let source: CampaignSourceEnum

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case autoApplied
    case benefits
    case campaignType
    case description
    case id
    case name
    case redemptionLimit
    case source
  }
}

struct CampaignsResponseModel: Codable {
  let campaignAttributes: [CampaignAttributeResponseModel?]?

  let productDeals: [ProductDealResponseModel?]?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaignAttributes
    case productDeals
  }
}

struct DealResponseModel: Codable {
  let campaignId: String

  /// things that would change across products for a campaign
  let discountTag: String

  /// buy 3 get 1 free
  let triggerQuantity: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaignId = "campaignID"
    case discountTag
    case triggerQuantity
  }
}

struct ProductDealResponseModel: Codable {
  let deals: [DealResponseModel?]?

  let productId: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case deals
    case productId = "productID"
  }
}

struct QueryResponseModel: Codable {
  let campaigns: CampaignsResponseModel?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaigns
  }
}

// MARK: - Input Objects

// MARK: - Interface

// MARK: - Union

// MARK: - GraphQLRequesting

// MARK: - QueryRequest

// MARK: - CampaignsQueryRequest

struct CampaignsQueryRequest: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

  private let operationDefinitionFormat: String = """
  query(
    $VendorID: String!
    $GlobalEntityID: String!
    $Locale: String!
    $LanguageID: String!
    $LanguageCode: String!
    $APIKey: String!
    $DiscoClientID: String!
  ) {
    campaigns(
      VendorID: $VendorID
      GlobalEntityID: $GlobalEntityID
      Locale: $Locale
      LanguageID: $LanguageID
      LanguageCode: $LanguageCode
      APIKey: $APIKey
      DiscoClientID: $DiscoClientID
  	) {
  		...CampaignsFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      selections.declaration()
    )
  }

  // MARK: - Arguments

  let vendorId: String

  let globalEntityId: String

  let locale: String

  let languageId: String

  let languageCode: String

  let apikY: String

  let discoClientId: String

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let benefitSelections: Set<BenefitSelection>

    enum BenefitSelection: String, GraphQLSelection {
      case all = ""
    }

    let campaignAttributeSelections: Set<CampaignAttributeSelection>

    enum CampaignAttributeSelection: String, GraphQLSelection {
      case benefits = """
      benefits {
        ...BenefitFragment
      }
      """
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
      case all = ""
    }

    let productDealSelections: Set<ProductDealSelection>

    enum ProductDealSelection: String, GraphQLSelection {
      case deals = """
      deals {
        ...DealFragment
      }
      """
    }

    init(
      benefitSelections: Set<BenefitSelection> = [],
      campaignAttributeSelections: Set<CampaignAttributeSelection> = [],
      campaignsSelections: Set<CampaignsSelection> = [],
      dealSelections: Set<DealSelection> = [],
      productDealSelections: Set<ProductDealSelection> = []
    ) {
      self.benefitSelections = benefitSelections
      self.campaignAttributeSelections = campaignAttributeSelections
      self.campaignsSelections = campaignsSelections
      self.dealSelections = dealSelections
      self.productDealSelections = productDealSelections
    }

    func declaration() -> String {
      let benefitSelectionsDeclaration = """
      fragment BenefitFragment on Benefit {
      	productID
      	quantity
      	\(benefitSelections.declaration)
      }
      """

      let campaignAttributeSelectionsDeclaration = """
      fragment CampaignAttributeFragment on CampaignAttribute {
      	autoApplied
      	campaignType
      	description
      	id
      	name
      	redemptionLimit
      	source
      	\(campaignAttributeSelections.declaration)
      }
      """

      let campaignsSelectionsDeclaration = """
      fragment CampaignsFragment on Campaigns {

      	\(campaignsSelections.declaration)
      }
      """

      let dealSelectionsDeclaration = """
      fragment DealFragment on Deal {
      	campaignID
      	discountTag
      	triggerQuantity
      	\(dealSelections.declaration)
      }
      """

      let productDealSelectionsDeclaration = """
      fragment ProductDealFragment on ProductDeal {
      	productID
      	\(productDealSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "BenefitFragment": benefitSelectionsDeclaration,
        "CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
        "CampaignsFragment": campaignsSelectionsDeclaration,
        "DealFragment": dealSelectionsDeclaration,
        "ProductDealFragment": productDealSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CampaignsFragment")
    }
  }

  private enum CodingKeys: String, CodingKey {
    case vendorId = "VendorID"

    case globalEntityId = "GlobalEntityID"

    case locale = "Locale"

    case languageId = "LanguageID"

    case languageCode = "LanguageCode"

    case apikY = "APIKey"

    case discoClientId = "DiscoClientID"
  }

  init(
    vendorId: String,
    globalEntityId: String,
    locale: String,
    languageId: String,
    languageCode: String,
    apikY: String,
    discoClientId: String,
    selections: Selections = .init()
  ) {
    self.vendorId = vendorId
    self.globalEntityId = globalEntityId
    self.locale = locale
    self.languageId = languageId
    self.languageCode = languageCode
    self.apikY = apikY
    self.discoClientId = discoClientId
    self.selections = selections
  }
}

struct CampaignsQueryResponse: GraphQLResponseData {
  let data: CampaignsResponseModel?

  enum CodingKeys: String, CodingKey {
    case data = "campaigns"
  }
}
