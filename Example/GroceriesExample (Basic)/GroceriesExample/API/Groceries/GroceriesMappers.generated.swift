// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

// MARK: - Primitive Selection Mock

private extension Bool {
  static func selectionMock() -> Self { false }
}

private extension Int {
  static func selectionMock() -> Self { 0 }
}

private extension String {
  static func selectionMock() -> Self { "" }
}

private extension Double {
  static func selectionMock() -> Self { 0 }
}

// MARK: - MapperError

enum GroceriesMapperError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

// MARK: - SelectionMock

extension CampaignSourceEnumResponseModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension CampaignTypeEnumResponseModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension DiscountTypeEnumResponseModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension BenefitResponseModel {
  static func selectionMock() -> Self {
    BenefitResponseModel(
      quantity: .selectionMock(),
      productId: .selectionMock()
    )
  }
}

extension CampaignAttributeResponseModel {
  static func selectionMock() -> Self {
    CampaignAttributeResponseModel(
      benefits: [.selectionMock()],
      autoApplied: .selectionMock(),
      source: .selectionMock(),
      campaignType: .selectionMock(),
      redemptionLimit: .selectionMock(),
      id: .selectionMock(),
      name: .selectionMock(),
      description: .selectionMock()
    )
  }
}

extension CampaignsResponseModel {
  static func selectionMock() -> Self {
    CampaignsResponseModel(
      campaignAttributes: [.selectionMock()],
      productDeals: [.selectionMock()]
    )
  }
}

extension DealResponseModel {
  static func selectionMock() -> Self {
    DealResponseModel(
      triggerQuantity: .selectionMock(),
      discountTag: .selectionMock(),
      campaignId: .selectionMock()
    )
  }
}

extension ProductDealResponseModel {
  static func selectionMock() -> Self {
    ProductDealResponseModel(
      deals: [.selectionMock()],
      productId: .selectionMock()
    )
  }
}

extension QueryResponseModel {
  static func selectionMock() -> Self {
    QueryResponseModel(
      campaigns: .selectionMock()
    )
  }
}

// MARK: - SelectionDecoder

class CampaignsQueryResponseSelectionDecoder {
  private(set) var benefitSelections = Set<BenefitSelection>()
  private(set) var campaignAttributeSelections = Set<CampaignAttributeSelection>()
  private(set) var campaignsSelections = Set<CampaignsSelection>()
  private(set) var dealSelections = Set<DealSelection>()
  private(set) var productDealSelections = Set<ProductDealSelection>()
  private let response: CampaignsResponseModel
  private let populateSelections: Bool

  init(response: CampaignsResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func productDeals<T>(mapper: (ProductDealSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      campaignsSelections.insert(.productDeals)
    }

    guard let values = response.productDeals else {
      throw GroceriesMapperError.missingData(context: "productDeals not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = ProductDealSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          dealSelections = decoder.dealSelections
          productDealSelections = decoder.productDealSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }

  func campaignAttributes<T>(mapper: (CampaignAttributeSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      campaignsSelections.insert(.campaignAttributes)
    }

    guard let values = response.campaignAttributes else {
      throw GroceriesMapperError.missingData(context: "campaignAttributes not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = CampaignAttributeSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          benefitSelections = decoder.benefitSelections
          campaignAttributeSelections = decoder.campaignAttributeSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }
}

class BenefitSelectionDecoder {
  private(set) var benefitSelections = Set<BenefitSelection>()
  private let response: BenefitResponseModel
  private let populateSelections: Bool

  init(response: BenefitResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func productId() throws -> String {
    if populateSelections {
      benefitSelections.insert(.productId)
    }

    guard let value = response.productId else {
      throw GroceriesMapperError.missingData(context: "productID not found")
    }

    return value
  }

  func quantity() throws -> Int {
    if populateSelections {
      benefitSelections.insert(.quantity)
    }

    guard let value = response.quantity else {
      throw GroceriesMapperError.missingData(context: "quantity not found")
    }

    return value
  }
}

class CampaignAttributeSelectionDecoder {
  private(set) var benefitSelections = Set<BenefitSelection>()
  private(set) var campaignAttributeSelections = Set<CampaignAttributeSelection>()
  private let response: CampaignAttributeResponseModel
  private let populateSelections: Bool

  init(response: CampaignAttributeResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      campaignAttributeSelections.insert(.id)
    }

    guard let value = response.id else {
      throw GroceriesMapperError.missingData(context: "id not found")
    }

    return value
  }

  func redemptionLimit() throws -> Double {
    if populateSelections {
      campaignAttributeSelections.insert(.redemptionLimit)
    }

    guard let value = response.redemptionLimit else {
      throw GroceriesMapperError.missingData(context: "redemptionLimit not found")
    }

    return value
  }

  func autoApplied() throws -> Bool {
    if populateSelections {
      campaignAttributeSelections.insert(.autoApplied)
    }

    guard let value = response.autoApplied else {
      throw GroceriesMapperError.missingData(context: "autoApplied not found")
    }

    return value
  }

  func source<T>(mapper: (CampaignSourceEnumResponseModel) throws -> T) throws -> T {
    if populateSelections {
      campaignAttributeSelections.insert(.source)
    }

    guard let value = response.source else {
      throw GroceriesMapperError.missingData(context: "source not found")
    }

    return try mapper(value)
  }

  func campaignType<T>(mapper: (CampaignTypeEnumResponseModel) throws -> T) throws -> T {
    if populateSelections {
      campaignAttributeSelections.insert(.campaignType)
    }

    guard let value = response.campaignType else {
      throw GroceriesMapperError.missingData(context: "campaignType not found")
    }

    return try mapper(value)
  }

  func benefits<T>(mapper: (BenefitSelectionDecoder) throws -> T) throws -> [T]? {
    if populateSelections {
      campaignAttributeSelections.insert(.benefits)
    }

    guard let values = response.benefits else {
      throw GroceriesMapperError.missingData(context: "benefits not found")
    }

    if let values = values {
      return try values.compactMap { value in
        let decoder = BenefitSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        benefitSelections = decoder.benefitSelections

        return result
      }
    } else {
      return nil
    }
  }

  func name() throws -> String {
    if populateSelections {
      campaignAttributeSelections.insert(.name)
    }

    guard let value = response.name else {
      throw GroceriesMapperError.missingData(context: "name not found")
    }

    return value
  }

  func description() throws -> String {
    if populateSelections {
      campaignAttributeSelections.insert(.description)
    }

    guard let value = response.description else {
      throw GroceriesMapperError.missingData(context: "description not found")
    }

    return value
  }
}

class CampaignsSelectionDecoder {
  private(set) var benefitSelections = Set<BenefitSelection>()
  private(set) var campaignAttributeSelections = Set<CampaignAttributeSelection>()
  private(set) var campaignsSelections = Set<CampaignsSelection>()
  private(set) var dealSelections = Set<DealSelection>()
  private(set) var productDealSelections = Set<ProductDealSelection>()
  private let response: CampaignsResponseModel
  private let populateSelections: Bool

  init(response: CampaignsResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func productDeals<T>(mapper: (ProductDealSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      campaignsSelections.insert(.productDeals)
    }

    guard let values = response.productDeals else {
      throw GroceriesMapperError.missingData(context: "productDeals not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = ProductDealSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          dealSelections = decoder.dealSelections
          productDealSelections = decoder.productDealSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }

  func campaignAttributes<T>(mapper: (CampaignAttributeSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      campaignsSelections.insert(.campaignAttributes)
    }

    guard let values = response.campaignAttributes else {
      throw GroceriesMapperError.missingData(context: "campaignAttributes not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = CampaignAttributeSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          benefitSelections = decoder.benefitSelections
          campaignAttributeSelections = decoder.campaignAttributeSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }
}

class DealSelectionDecoder {
  private(set) var dealSelections = Set<DealSelection>()
  private let response: DealResponseModel
  private let populateSelections: Bool

  init(response: DealResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func discountTag() throws -> String {
    if populateSelections {
      dealSelections.insert(.discountTag)
    }

    guard let value = response.discountTag else {
      throw GroceriesMapperError.missingData(context: "discountTag not found")
    }

    return value
  }

  func triggerQuantity() throws -> Int {
    if populateSelections {
      dealSelections.insert(.triggerQuantity)
    }

    guard let value = response.triggerQuantity else {
      throw GroceriesMapperError.missingData(context: "triggerQuantity not found")
    }

    return value
  }

  func campaignId() throws -> String {
    if populateSelections {
      dealSelections.insert(.campaignId)
    }

    guard let value = response.campaignId else {
      throw GroceriesMapperError.missingData(context: "campaignID not found")
    }

    return value
  }
}

class ProductDealSelectionDecoder {
  private(set) var dealSelections = Set<DealSelection>()
  private(set) var productDealSelections = Set<ProductDealSelection>()
  private let response: ProductDealResponseModel
  private let populateSelections: Bool

  init(response: ProductDealResponseModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func productId() throws -> String {
    if populateSelections {
      productDealSelections.insert(.productId)
    }

    guard let value = response.productId else {
      throw GroceriesMapperError.missingData(context: "productID not found")
    }

    return value
  }

  func deals<T>(mapper: (DealSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      productDealSelections.insert(.deals)
    }

    guard let values = response.deals else {
      throw GroceriesMapperError.missingData(context: "deals not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = DealSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          dealSelections = decoder.dealSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }
}

// MARK: - Mappers

struct CampaignsQueryMapper<T> {
  typealias MapperBlock = (CampaignsQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CampaignsQueryRequestSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CampaignsQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = CampaignsQueryRequestSelections(
      benefitSelections: decoder.benefitSelections,
      campaignAttributeSelections: decoder.campaignAttributeSelections,
      campaignsSelections: decoder.campaignsSelections,
      dealSelections: decoder.dealSelections,
      productDealSelections: decoder.productDealSelections
    )
  }

  func map(response: CampaignsResponseModel) throws -> T {
    try block(CampaignsQueryResponseSelectionDecoder(response: response))
  }
}
