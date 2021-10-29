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
  private let internalProductId: Optional<String>
  private let internalQuantity: Optional<Int>

  func productId() throws -> String {
    try value(for: \.internalProductId, codingKey: CodingKeys.internalProductId)
  }

  func quantity() throws -> Int {
    try value(for: \.internalQuantity, codingKey: CodingKeys.internalQuantity)
  }

  private func value<Value>(for keyPath: KeyPath<BenefitResponseModel, Value?>, codingKey: CodingKey) throws -> Value {
    guard let value = self[keyPath: keyPath] else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: "Benefit")
    }

    return value
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
    try value(for: \.internalAutoApplied, codingKey: CodingKeys.internalAutoApplied)
  }

  func benefits() throws -> [BenefitResponseModel]? {
    try value(for: \.internalBenefits, codingKey: CodingKeys.internalBenefits)
  }

  func campaignType() throws -> CampaignTypeEnumResponseModel {
    try value(for: \.internalCampaignType, codingKey: CodingKeys.internalCampaignType)
  }

  func description() throws -> String {
    try value(for: \.internalDescription, codingKey: CodingKeys.internalDescription)
  }

  func id() throws -> String {
    try value(for: \.internalId, codingKey: CodingKeys.internalId)
  }

  func name() throws -> String {
    try value(for: \.internalName, codingKey: CodingKeys.internalName)
  }

  func redemptionLimit() throws -> Double {
    try value(for: \.internalRedemptionLimit, codingKey: CodingKeys.internalRedemptionLimit)
  }

  func source() throws -> CampaignSourceEnumResponseModel {
    try value(for: \.internalSource, codingKey: CodingKeys.internalSource)
  }

  private func value<Value>(for keyPath: KeyPath<CampaignAttributeResponseModel, Value?>, codingKey: CodingKey) throws -> Value {
    guard let value = self[keyPath: keyPath] else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: "CampaignAttribute")
    }

    return value
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
    try value(for: \.internalCampaignAttributes, codingKey: CodingKeys.internalCampaignAttributes)
  }

  func productDeals() throws -> [ProductDealResponseModel?]? {
    try value(for: \.internalProductDeals, codingKey: CodingKeys.internalProductDeals)
  }

  private func value<Value>(for keyPath: KeyPath<CampaignsResponseModel, Value?>, codingKey: CodingKey) throws -> Value {
    guard let value = self[keyPath: keyPath] else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: "Campaigns")
    }

    return value
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
    try value(for: \.internalCampaignId, codingKey: CodingKeys.internalCampaignId)
  }

  /// things that would change across products for a campaign
  func discountTag() throws -> String {
    try value(for: \.internalDiscountTag, codingKey: CodingKeys.internalDiscountTag)
  }

  /// buy 3 get 1 free
  func triggerQuantity() throws -> Int {
    try value(for: \.internalTriggerQuantity, codingKey: CodingKeys.internalTriggerQuantity)
  }

  private func value<Value>(for keyPath: KeyPath<DealResponseModel, Value?>, codingKey: CodingKey) throws -> Value {
    guard let value = self[keyPath: keyPath] else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: "Deal")
    }

    return value
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
    try value(for: \.internalDeals, codingKey: CodingKeys.internalDeals)
  }

  func productId() throws -> String {
    try value(for: \.internalProductId, codingKey: CodingKeys.internalProductId)
  }

  private func value<Value>(for keyPath: KeyPath<ProductDealResponseModel, Value?>, codingKey: CodingKey) throws -> Value {
    guard let value = self[keyPath: keyPath] else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: "ProductDeal")
    }

    return value
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
  let rootSelectionKeys: Set<String> = ["campaignsCampaignsFragment"]

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

  func operationDefinition() -> String {
    return """
    campaigns(
      VendorID: $campaignsVendorId
      GlobalEntityID: $campaignsGlobalEntityId
      Locale: $campaignsLocale
    ) {
       ...campaignsCampaignsFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $campaignsGlobalEntityId: String!,
    $campaignsLocale: String!,
    $campaignsVendorId: String!
    """
  }

  func fragments(with selections: GraphQLSelections) -> String {
    selections.declaration(for: requestName, rootSelectionKeys: rootSelectionKeys)
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

  func operationDefinition() -> String {
    requests
      .map { $0.operationDefinition() }
      .joined(separator: "\n")
  }

  func operationArguments() -> String {
    requests
      .map { $0.operationArguments() }
      .joined(separator: "\n")
  }

  func fragments(with selections: GraphQLSelections) -> String {
    requests.map {
      selections.declaration(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
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

  func declaration(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let benefitDeclaration = """
    fragment \(requestName)BenefitFragment on Benefit {
    	\(benefit.declaration(requestName: requestName))
    }
    """

    let campaignAttributeDeclaration = """
    fragment \(requestName)CampaignAttributeFragment on CampaignAttribute {
    	\(campaignAttribute.declaration(requestName: requestName))
    }
    """

    let campaignsDeclaration = """
    fragment \(requestName)CampaignsFragment on Campaigns {
    	\(campaigns.declaration(requestName: requestName))
    }
    """

    let dealDeclaration = """
    fragment \(requestName)DealFragment on Deal {
    	\(deal.declaration(requestName: requestName))
    }
    """

    let productDealDeclaration = """
    fragment \(requestName)ProductDealFragment on ProductDeal {
    	\(productDeal.declaration(requestName: requestName))
    }
    """

    let selectionDeclarationMap = [
      "\(requestName)BenefitFragment": benefitDeclaration,
      "\(requestName)CampaignAttributeFragment": campaignAttributeDeclaration,
      "\(requestName)CampaignsFragment": campaignsDeclaration,
      "\(requestName)DealFragment": dealDeclaration,
      "\(requestName)ProductDealFragment": productDealDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
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

  func declaration(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let benefitSelectionsDeclaration = """
    fragment \(requestName)BenefitFragment on Benefit {
    	\(benefitSelections.declaration(requestName: requestName))
    }
    """

    let campaignAttributeSelectionsDeclaration = """
    fragment \(requestName)CampaignAttributeFragment on CampaignAttribute {
    	\(campaignAttributeSelections.declaration(requestName: requestName))
    }
    """

    let campaignsSelectionsDeclaration = """
    fragment \(requestName)CampaignsFragment on Campaigns {
    	\(campaignsSelections.declaration(requestName: requestName))
    }
    """

    let dealSelectionsDeclaration = """
    fragment \(requestName)DealFragment on Deal {
    	\(dealSelections.declaration(requestName: requestName))
    }
    """

    let productDealSelectionsDeclaration = """
    fragment \(requestName)ProductDealFragment on ProductDeal {
    	\(productDealSelections.declaration(requestName: requestName))
    }
    """

    let selectionDeclarationMap = [
      "\(requestName)BenefitFragment": benefitSelectionsDeclaration,
      "\(requestName)CampaignAttributeFragment": campaignAttributeSelectionsDeclaration,
      "\(requestName)CampaignsFragment": campaignsSelectionsDeclaration,
      "\(requestName)DealFragment": dealSelectionsDeclaration,
      "\(requestName)ProductDealFragment": productDealSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
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
