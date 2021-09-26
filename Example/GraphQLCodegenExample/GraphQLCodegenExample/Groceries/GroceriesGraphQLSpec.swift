// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - Enums

enum CampaignSource: RawRepresentable, CaseIterable, Codable {
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

  static func == (lhs: CampaignSource, rhs: CampaignSource) -> Bool {
    switch (lhs, rhs) {
    case (.djini, .djini): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }

  static var allCases: [CampaignSource] {
    return [
      .djini
    ]
  }
}

enum CampaignType: RawRepresentable, CaseIterable, Codable {
  typealias RawValue = String

  case strikeThrough

  case sameItemBundleFree

  case sameItemBundlePercentage

  case sameItemBundleAbsolute

  case mixAndMatchSameFree

  case mixAndMatchSamePercentage

  case mixAndMatchSameAbsolute

  case mixAndMatchDifferent

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "StrikeThrough": self = .strikeThrough
    case "SameItemBundleFree": self = .sameItemBundleFree
    case "SameItemBundlePercentage": self = .sameItemBundlePercentage
    case "SameItemBundleAbsolute": self = .sameItemBundleAbsolute
    case "MixAndMatchSameFree": self = .mixAndMatchSameFree
    case "MixAndMatchSamePercentage": self = .mixAndMatchSamePercentage
    case "MixAndMatchSameAbsolute": self = .mixAndMatchSameAbsolute
    case "MixAndMatchDifferent": self = .mixAndMatchDifferent
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .strikeThrough: return "StrikeThrough"
    case .sameItemBundleFree: return "SameItemBundleFree"
    case .sameItemBundlePercentage: return "SameItemBundlePercentage"
    case .sameItemBundleAbsolute: return "SameItemBundleAbsolute"
    case .mixAndMatchSameFree: return "MixAndMatchSameFree"
    case .mixAndMatchSamePercentage: return "MixAndMatchSamePercentage"
    case .mixAndMatchSameAbsolute: return "MixAndMatchSameAbsolute"
    case .mixAndMatchDifferent: return "MixAndMatchDifferent"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: CampaignType, rhs: CampaignType) -> Bool {
    switch (lhs, rhs) {
    case (.strikeThrough, .strikeThrough): return true
    case (.sameItemBundleFree, .sameItemBundleFree): return true
    case (.sameItemBundlePercentage, .sameItemBundlePercentage): return true
    case (.sameItemBundleAbsolute, .sameItemBundleAbsolute): return true
    case (.mixAndMatchSameFree, .mixAndMatchSameFree): return true
    case (.mixAndMatchSamePercentage, .mixAndMatchSamePercentage): return true
    case (.mixAndMatchSameAbsolute, .mixAndMatchSameAbsolute): return true
    case (.mixAndMatchDifferent, .mixAndMatchDifferent): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }

  static var allCases: [CampaignType] {
    return [
      .strikeThrough,
      .sameItemBundleFree,
      .sameItemBundlePercentage,
      .sameItemBundleAbsolute,
      .mixAndMatchSameFree,
      .mixAndMatchSamePercentage,
      .mixAndMatchSameAbsolute,
      .mixAndMatchDifferent
    ]
  }
}

enum DiscountType: RawRepresentable, CaseIterable, Codable {
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

  static func == (lhs: DiscountType, rhs: DiscountType) -> Bool {
    switch (lhs, rhs) {
    case (.free, .free): return true
    case (.absolute, .absolute): return true
    case (.percentage, .percentage): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }

  static var allCases: [DiscountType] {
    return [
      .free,
      .absolute,
      .percentage
    ]
  }
}

// MARK: - Objects

struct Benefit: Codable {
  let productId: String

  let quantity: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case productId = "productID"
    case quantity
  }
}

struct CampaignAttribute: Codable {
  let autoApplied: Bool

  let benefits: [Benefit]?

  let campaignType: CampaignType

  let description: String

  let id: String

  let name: String

  let redemptionLimit: Double

  let source: CampaignSource

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

struct Campaigns: Codable {
  let campaignAttributes: [CampaignAttribute?]?

  let productDeals: [ProductDeal?]?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaignAttributes
    case productDeals
  }
}

struct Deal: Codable {
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

struct ProductDeal: Codable {
  let deals: [Deal?]?

  let productId: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case deals
    case productId = "productID"
  }
}

struct Query: Codable {
  let campaigns: Campaigns?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case campaigns
  }
}

// MARK: - Input Objects

// MARK: - GraphQLRequestParameter

enum QueryParameter {}

// MARK: - QueryParameter

extension QueryParameter {
  // MARK: - CampaignsRequestParameter

  struct CampaignsRequestParameter: GraphQLRequestParameter {
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
        case productID
        case quantity
      }

      let campaignAttributeSelections: Set<CampaignAttributeSelection>

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
        fragment BenefitFragment on Benefit {\(benefitSelections.declaration)
        }
        """

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

        let productDealSelectionsDeclaration = """
        fragment ProductDealFragment on ProductDeal {\(productDealSelections.declaration)
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
}
