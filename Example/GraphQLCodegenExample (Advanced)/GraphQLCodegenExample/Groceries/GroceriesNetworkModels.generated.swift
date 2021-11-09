// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

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
  private let internalProductId: Optional<String>
  private let internalQuantity: Optional<Int>

  func productId() throws -> String {
    try value(for: \Self.internalProductId, codingKey: CodingKeys.internalProductId)
  }

  func quantity() throws -> Int {
    try value(for: \Self.internalQuantity, codingKey: CodingKeys.internalQuantity)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalProductId = try container.decodeOptionalIfPresent(String.self, forKey: .internalProductId)
    internalQuantity = try container.decodeOptionalIfPresent(Int.self, forKey: .internalQuantity)
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case internalProductId = "productID"
    case internalQuantity = "quantity"
  }
}

struct CampaignAttributeResponseModel: Codable {
  private let internalAutoApplied: Optional<Bool>
  private let internalBenefits: Optional<[BenefitResponseModel]?>
  private let internalCampaignType: Optional<CampaignTypeEnumResponseModel>
  private let internalDescription: Optional<String>
  private let internalId: Optional<String>
  private let internalName: Optional<String>
  private let internalRedemptionLimit: Optional<Double>
  private let internalSource: Optional<CampaignSourceEnumResponseModel>

  func autoApplied() throws -> Bool {
    try value(for: \Self.internalAutoApplied, codingKey: CodingKeys.internalAutoApplied)
  }

  func benefits() throws -> [BenefitResponseModel]? {
    try value(for: \Self.internalBenefits, codingKey: CodingKeys.internalBenefits)
  }

  func campaignType() throws -> CampaignTypeEnumResponseModel {
    try value(for: \Self.internalCampaignType, codingKey: CodingKeys.internalCampaignType)
  }

  func description() throws -> String {
    try value(for: \Self.internalDescription, codingKey: CodingKeys.internalDescription)
  }

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  func name() throws -> String {
    try value(for: \Self.internalName, codingKey: CodingKeys.internalName)
  }

  func redemptionLimit() throws -> Double {
    try value(for: \Self.internalRedemptionLimit, codingKey: CodingKeys.internalRedemptionLimit)
  }

  func source() throws -> CampaignSourceEnumResponseModel {
    try value(for: \Self.internalSource, codingKey: CodingKeys.internalSource)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalAutoApplied = try container.decodeOptionalIfPresent(Bool.self, forKey: .internalAutoApplied)
    internalBenefits = try container.decodeOptionalIfPresent([BenefitResponseModel]?.self, forKey: .internalBenefits)
    internalCampaignType = try container.decodeOptionalIfPresent(CampaignTypeEnumResponseModel.self, forKey: .internalCampaignType)
    internalDescription = try container.decodeOptionalIfPresent(String.self, forKey: .internalDescription)
    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
    internalName = try container.decodeOptionalIfPresent(String.self, forKey: .internalName)
    internalRedemptionLimit = try container.decodeOptionalIfPresent(Double.self, forKey: .internalRedemptionLimit)
    internalSource = try container.decodeOptionalIfPresent(CampaignSourceEnumResponseModel.self, forKey: .internalSource)
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case internalAutoApplied = "autoApplied"
    case internalBenefits = "benefits"
    case internalCampaignType = "campaignType"
    case internalDescription = "description"
    case internalId = "id"
    case internalName = "name"
    case internalRedemptionLimit = "redemptionLimit"
    case internalSource = "source"
  }
}

struct CampaignsResponseModel: Codable {
  private let internalCampaignAttributes: Optional<[CampaignAttributeResponseModel?]?>
  private let internalProductDeals: Optional<[ProductDealResponseModel?]?>

  func campaignAttributes() throws -> [CampaignAttributeResponseModel?]? {
    try value(for: \Self.internalCampaignAttributes, codingKey: CodingKeys.internalCampaignAttributes)
  }

  func productDeals() throws -> [ProductDealResponseModel?]? {
    try value(for: \Self.internalProductDeals, codingKey: CodingKeys.internalProductDeals)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalCampaignAttributes = try container.decodeOptionalIfPresent([CampaignAttributeResponseModel?]?.self, forKey: .internalCampaignAttributes)
    internalProductDeals = try container.decodeOptionalIfPresent([ProductDealResponseModel?]?.self, forKey: .internalProductDeals)
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case internalCampaignAttributes = "campaignAttributes"
    case internalProductDeals = "productDeals"
  }
}

struct DealResponseModel: Codable {
  private let internalCampaignId: Optional<String>
  private let internalDiscountTag: Optional<String>
  private let internalTriggerQuantity: Optional<Int>

  func campaignId() throws -> String {
    try value(for: \Self.internalCampaignId, codingKey: CodingKeys.internalCampaignId)
  }

  /// things that would change across products for a campaign
  func discountTag() throws -> String {
    try value(for: \Self.internalDiscountTag, codingKey: CodingKeys.internalDiscountTag)
  }

  /// buy 3 get 1 free
  func triggerQuantity() throws -> Int {
    try value(for: \Self.internalTriggerQuantity, codingKey: CodingKeys.internalTriggerQuantity)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalCampaignId = try container.decodeOptionalIfPresent(String.self, forKey: .internalCampaignId)
    internalDiscountTag = try container.decodeOptionalIfPresent(String.self, forKey: .internalDiscountTag)
    internalTriggerQuantity = try container.decodeOptionalIfPresent(Int.self, forKey: .internalTriggerQuantity)
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case internalCampaignId = "campaignID"
    case internalDiscountTag = "discountTag"
    case internalTriggerQuantity = "triggerQuantity"
  }
}

struct ProductDealResponseModel: Codable {
  private let internalDeals: Optional<[DealResponseModel?]?>
  private let internalProductId: Optional<String>

  func deals() throws -> [DealResponseModel?]? {
    try value(for: \Self.internalDeals, codingKey: CodingKeys.internalDeals)
  }

  func productId() throws -> String {
    try value(for: \Self.internalProductId, codingKey: CodingKeys.internalProductId)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalDeals = try container.decodeOptionalIfPresent([DealResponseModel?]?.self, forKey: .internalDeals)
    internalProductId = try container.decodeOptionalIfPresent(String.self, forKey: .internalProductId)
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case internalDeals = "deals"
    case internalProductId = "productID"
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
  let requestName: String = "campaigns"
  let rootSelectionKeys: Set<String> = ["CampaignsCampaignsFragment"]

  // MARK: - Arguments

  let vendorId: String

  let globalEntityId: String

  let locale: String

  private enum CodingKeys: String, CodingKey {
    case vendorId = "campaignsVendorId"

    case globalEntityId = "campaignsGlobalEntityId"

    case locale = "campaignsLocale"
  }

  init(
    globalEntityId: String,
    locale: String,
    vendorId: String
  ) {
    self.globalEntityId = globalEntityId
    self.locale = locale
    self.vendorId = vendorId
  }

  // MARK: - Operation Definition

  let requestQuery: String = {
    """
    campaigns(
      VendorID: $campaignsVendorId
      GlobalEntityID: $campaignsGlobalEntityId
      Locale: $campaignsLocale
    ) {
       ...CampaignsCampaignsFragment
    }
    """
  }()

  let requestArguments: String = {
    """
    $campaignsGlobalEntityId: String!,
    $campaignsLocale: String!,
    $campaignsVendorId: String!
    """
  }()

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

struct QueryRequest: GraphQLRequesting {
  let requestType: GraphQLRequestType = .query
  let requestName: String = ""
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let campaigns: CampaignsQueryRequest?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      campaigns
    ]

    return requests.compactMap { $0 }
  }

  init(
    campaigns: CampaignsQueryRequest? = nil
  ) {
    self.campaigns = campaigns
  }

  func encode(to encoder: Encoder) throws {
    try requests.forEach {
      try $0.encode(to: encoder)
    }
  }

  var requestQuery: String {
    requests
      .map { $0.requestQuery }
      .joined(separator: "\n")
  }

  var requestArguments: String {
    requests
      .map { $0.requestArguments }
      .joined(separator: "\n")
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    requests.map {
      selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
    }.joined(separator: "\n")
  }
}

struct CampaignsQueryResponse: Codable {
  let campaigns: CampaignsResponseModel?
}

// MARK: - GraphQLSelection

enum BenefitSelection: String, GraphQLSelection {
  case productId = "productID"
  case quantity
}

enum CampaignAttributeSelection: String, GraphQLSelection {
  case autoApplied
  case benefits = """
  benefits {
    ...%@BenefitFragment
  }
  """
  case campaignType
  case description
  case id
  case name
  case redemptionLimit
  case source
}

enum CampaignsSelection: String, GraphQLSelection {
  case campaignAttributes = """
  campaignAttributes {
    ...%@CampaignAttributeFragment
  }
  """
  case productDeals = """
  productDeals {
    ...%@ProductDealFragment
  }
  """
}

enum DealSelection: String, GraphQLSelection {
  case campaignId = "campaignID"
  case discountTag
  case triggerQuantity
}

enum ProductDealSelection: String, GraphQLSelection {
  case deals = """
  deals {
    ...%@DealFragment
  }
  """
  case productId = "productID"
}

struct QueryRequestSelections: GraphQLSelections {
  let benefit: Set<BenefitSelection>
  let campaignAttribute: Set<CampaignAttributeSelection>
  let campaigns: Set<CampaignsSelection>
  let deal: Set<DealSelection>
  let productDeal: Set<ProductDealSelection>

  init(
    benefit: Set<BenefitSelection> = .allFields,
    campaignAttribute: Set<CampaignAttributeSelection> = .allFields,
    campaigns: Set<CampaignsSelection> = .allFields,
    deal: Set<DealSelection> = .allFields,
    productDeal: Set<ProductDealSelection> = .allFields
  ) {
    self.benefit = benefit
    self.campaignAttribute = campaignAttribute
    self.campaigns = campaigns
    self.deal = deal
    self.productDeal = productDeal
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let capitalizedRequestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let benefitDeclaration = """
    fragment \(capitalizedRequestName)BenefitFragment on Benefit {
    	\(benefit.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let campaignAttributeDeclaration = """
    fragment \(capitalizedRequestName)CampaignAttributeFragment on CampaignAttribute {
    	\(campaignAttribute.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let campaignsDeclaration = """
    fragment \(capitalizedRequestName)CampaignsFragment on Campaigns {
    	\(campaigns.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let dealDeclaration = """
    fragment \(capitalizedRequestName)DealFragment on Deal {
    	\(deal.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let productDealDeclaration = """
    fragment \(capitalizedRequestName)ProductDealFragment on ProductDeal {
    	\(productDeal.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let selectionDeclarationMap = [
      "\(capitalizedRequestName)BenefitFragment": benefitDeclaration,
      "\(capitalizedRequestName)CampaignAttributeFragment": campaignAttributeDeclaration,
      "\(capitalizedRequestName)CampaignsFragment": campaignsDeclaration,
      "\(capitalizedRequestName)DealFragment": dealDeclaration,
      "\(capitalizedRequestName)ProductDealFragment": productDealDeclaration
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

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct CampaignsQueryRequestSelections: GraphQLSelections {
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

    let benefitSelectionsDeclaration = """
    fragment \(capitalizedRequestName)BenefitFragment on Benefit {
    	\(benefitSelections.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let campaignAttributeSelectionsDeclaration = """
    fragment \(capitalizedRequestName)CampaignAttributeFragment on CampaignAttribute {
    	\(campaignAttributeSelections.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let campaignsSelectionsDeclaration = """
    fragment \(capitalizedRequestName)CampaignsFragment on Campaigns {
    	\(campaignsSelections.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let dealSelectionsDeclaration = """
    fragment \(capitalizedRequestName)DealFragment on Deal {
    	\(dealSelections.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let productDealSelectionsDeclaration = """
    fragment \(capitalizedRequestName)ProductDealFragment on ProductDeal {
    	\(productDealSelections.requestFragments(requestName: capitalizedRequestName))
    }
    """

    let selectionDeclarationMap = [
      "\(capitalizedRequestName)BenefitFragment": benefitSelectionsDeclaration,
      "\(capitalizedRequestName)CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
      "\(capitalizedRequestName)CampaignsFragment": campaignsSelectionsDeclaration,
      "\(capitalizedRequestName)DealFragment": dealSelectionsDeclaration,
      "\(capitalizedRequestName)ProductDealFragment": productDealSelectionsDeclaration
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

    return fragmentMaps.values.joined(separator: "\n")
  }
}