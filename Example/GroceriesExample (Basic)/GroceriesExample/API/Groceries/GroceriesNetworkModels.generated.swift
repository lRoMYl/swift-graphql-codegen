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
  private static let typename = "Benefit"

  private let _productId: Optional<String>
  func productId() throws -> String {
    guard let value = _productId else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._productId.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _quantity: Optional<Int>
  func quantity() throws -> Int {
    guard let value = _quantity else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._quantity.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _productId = "productID"
    case _quantity = "quantity"
  }
}

struct CampaignAttributeResponseModel: Codable {
  private static let typename = "CampaignAttribute"

  private let _autoApplied: Optional<Bool>
  func autoApplied() throws -> Bool {
    guard let value = _autoApplied else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._autoApplied.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _benefits: Optional<[BenefitResponseModel]?>
  func benefits() throws -> [BenefitResponseModel]? {
    guard let value = _benefits else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._benefits.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _campaignType: Optional<CampaignTypeEnumResponseModel>
  func campaignType() throws -> CampaignTypeEnumResponseModel {
    guard let value = _campaignType else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._campaignType.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _description: Optional<String>
  func description() throws -> String {
    guard let value = _description else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._description.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _id: Optional<String>
  func id() throws -> String {
    guard let value = _id else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._id.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _name: Optional<String>
  func name() throws -> String {
    guard let value = _name else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._name.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _redemptionLimit: Optional<Double>
  func redemptionLimit() throws -> Double {
    guard let value = _redemptionLimit else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._redemptionLimit.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _source: Optional<CampaignSourceEnumResponseModel>
  func source() throws -> CampaignSourceEnumResponseModel {
    guard let value = _source else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._source.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _autoApplied = "autoApplied"
    case _benefits = "benefits"
    case _campaignType = "campaignType"
    case _description = "description"
    case _id = "id"
    case _name = "name"
    case _redemptionLimit = "redemptionLimit"
    case _source = "source"
  }
}

struct CampaignsResponseModel: Codable {
  private static let typename = "Campaigns"

  private let _campaignAttributes: Optional<[CampaignAttributeResponseModel?]?>
  func campaignAttributes() throws -> [CampaignAttributeResponseModel?]? {
    guard let value = _campaignAttributes else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._campaignAttributes.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _productDeals: Optional<[ProductDealResponseModel?]?>
  func productDeals() throws -> [ProductDealResponseModel?]? {
    guard let value = _productDeals else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._productDeals.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _campaignAttributes = "campaignAttributes"
    case _productDeals = "productDeals"
  }
}

struct DealResponseModel: Codable {
  private static let typename = "Deal"

  private let _campaignId: Optional<String>
  func campaignId() throws -> String {
    guard let value = _campaignId else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._campaignId.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  /// things that would change across products for a campaign
  private let _discountTag: Optional<String>
  func discountTag() throws -> String {
    guard let value = _discountTag else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._discountTag.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  /// buy 3 get 1 free
  private let _triggerQuantity: Optional<Int>
  func triggerQuantity() throws -> Int {
    guard let value = _triggerQuantity else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._triggerQuantity.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _campaignId = "campaignID"
    case _discountTag = "discountTag"
    case _triggerQuantity = "triggerQuantity"
  }
}

struct ProductDealResponseModel: Codable {
  private static let typename = "ProductDeal"

  private let _deals: Optional<[DealResponseModel?]?>
  func deals() throws -> [DealResponseModel?]? {
    guard let value = _deals else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._deals.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _productId: Optional<String>
  func productId() throws -> String {
    guard let value = _productId else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._productId.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _deals = "deals"
    case _productId = "productID"
  }
}

struct QueryResponseModel: Codable {
  private static let typename = "Query"

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
  let rootSelectionKeys: Set<String> = ["CampaignsFragment"]

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
       ...CampaignsFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $campaignsVendorId: String!
    $campaignsGlobalEntityId: String!
    $campaignsLocale: String!
    """
  }
}

struct QueryRequest: GraphQLRequesting {
  let requestType: GraphQLRequestType = .query
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
    ...BenefitFragment
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
    ...CampaignAttributeFragment
  }
  """
  case productDeals = """
  productDeals {
    ...ProductDealFragment
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
    ...DealFragment
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

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

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

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let benefitDeclaration = """
    fragment BenefitFragment on Benefit {
    	\(benefit.declaration)
    }
    """

    let campaignAttributeDeclaration = """
    fragment CampaignAttributeFragment on CampaignAttribute {
    	\(campaignAttribute.declaration)
    }
    """

    let campaignsDeclaration = """
    fragment CampaignsFragment on Campaigns {
    	\(campaigns.declaration)
    }
    """

    let dealDeclaration = """
    fragment DealFragment on Deal {
    	\(deal.declaration)
    }
    """

    let productDealDeclaration = """
    fragment ProductDealFragment on ProductDeal {
    	\(productDeal.declaration)
    }
    """

    let selectionDeclarationMap = [
      "BenefitFragment": benefitDeclaration,
      "CampaignAttributeFragment": campaignAttributeDeclaration,
      "CampaignsFragment": campaignsDeclaration,
      "DealFragment": dealDeclaration,
      "ProductDealFragment": productDealDeclaration
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

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let benefitSelectionsDeclaration = """
    fragment BenefitFragment on Benefit {
    	\(benefitSelections.declaration)
    }
    """

    let campaignAttributeSelectionsDeclaration = """
    fragment CampaignAttributeFragment on CampaignAttribute {
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
    	\(dealSelections.declaration)
    }
    """

    let productDealSelectionsDeclaration = """
    fragment ProductDealFragment on ProductDeal {
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
