// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - EnumResponseModel

enum CampaignSourceEnumResponseModel: RawRepresentable, Codable {
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

  static func == (lhs: CampaignSourceEnumResponseModel, rhs: CampaignSourceEnumResponseModel) -> Bool {
    switch (lhs, rhs) {
    case (.djini, .djini): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

enum CampaignTypeEnumResponseModel: RawRepresentable, Codable {
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

  static func == (lhs: CampaignTypeEnumResponseModel, rhs: CampaignTypeEnumResponseModel) -> Bool {
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

enum DiscountTypeEnumResponseModel: RawRepresentable, Codable {
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

  static func == (lhs: DiscountTypeEnumResponseModel, rhs: DiscountTypeEnumResponseModel) -> Bool {
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

  let campaignType: CampaignTypeEnumResponseModel

  let description: String

  let id: String

  let name: String

  let redemptionLimit: Double

  let source: CampaignSourceEnumResponseModel

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
  let campaigns: Optional<CampaignsResponseModel?>

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaigns
  }
}

// MARK: - GraphQLRequesting

/// CampaignsQueryRequest
struct CampaignsQueryRequest: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Arguments

  let vendorId: String

  let globalEntityId: String

  let locale: String

  private enum CodingKeys: String, CodingKey {
    case vendorId = "VendorID"

    case globalEntityId = "GlobalEntityID"

    case locale = "Locale"
  }

  init(
    vendorId: String,
    globalEntityId: String,
    locale: String
  ) {
    self.vendorId = vendorId
    self.globalEntityId = globalEntityId
    self.locale = locale
  }
}

struct QueryRequest: GraphQLRequesting {
  let requestType: GraphQLRequestType = .query

  let campaignsRequest: CampaignsQueryRequest?
}

struct CampaignsQueryResponse: Codable {
  let campaigns: CampaignsResponseModel?
}

// MARK: - GraphQLSelection

enum BenefitSelection: GraphQLSelection {
  static let requiredDeclaration = """
  productID
  quantity
  """
}

enum CampaignAttributeSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  autoApplied
  campaignType
  description
  id
  name
  redemptionLimit
  source
  """

  case benefits = """
  benefits {
    ...BenefitFragment
  }
  """
}

enum CampaignsSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  """

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

enum DealSelection: GraphQLSelection {
  static let requiredDeclaration = """
  campaignID
  discountTag
  triggerQuantity
  """
}

enum ProductDealSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  productID
  """

  case deals = """
  deals {
    ...DealFragment
  }
  """
}

// MARK: - Selections

struct CampaignsQueryRequestSelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $VendorID: String!
    $GlobalEntityID: String!
    $Locale: String!
  ) {
  	campaigns(
      VendorID: $VendorID
      GlobalEntityID: $GlobalEntityID
      Locale: $Locale
  	) {
  		...CampaignsFragment
  	}
  }

  %1$@
  """

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
    let benefitSelectionsDeclaration = """
    fragment BenefitFragment on Benefit {
    	\(BenefitSelection.requiredDeclaration)
    }
    """

    let campaignAttributeSelectionsDeclaration = """
    fragment CampaignAttributeFragment on CampaignAttribute {
    	\(CampaignAttributeSelection.requiredDeclaration)
    	\(campaignAttributeSelections.declaration)
    }
    """

    let campaignsSelectionsDeclaration = """
    fragment CampaignsFragment on Campaigns {
    	\(CampaignsSelection.requiredDeclaration)
    	\(campaignsSelections.declaration)
    }
    """

    let dealSelectionsDeclaration = """
    fragment DealFragment on Deal {
    	\(DealSelection.requiredDeclaration)
    }
    """

    let productDealSelectionsDeclaration = """
    fragment ProductDealFragment on ProductDeal {
    	\(ProductDealSelection.requiredDeclaration)
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

    return declaration(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKey: "CampaignsFragment"
    )
  }
}

struct QueryRequestSelections: GraphQLSelections {
  let campaigns: CampaignsSelection

  private let operationDefinitionFormat: String = ""

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}
