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

private extension Double {
  static func selectionMock() -> Self { 0 }
}

private extension Int {
  static func selectionMock() -> Self { 0 }
}

private extension String {
  static func selectionMock() -> Self { "" }
}

// MARK: - Extensions

private extension Optional {
  func unwrapOrFail(context: String = "") throws -> Wrapped {
    guard let value = self else {
      throw GroceriesMapperError.missingData(context: context)
    }

    return value
  }
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
      productId: .selectionMock(),
      quantity: .selectionMock()
    )
  }
}

extension CampaignAttributeResponseModel {
  static func selectionMock() -> Self {
    CampaignAttributeResponseModel(
      autoApplied: .selectionMock(),
      benefits: [.selectionMock()],
      campaignType: .selectionMock(),
      description: .selectionMock(),
      id: .selectionMock(),
      name: .selectionMock(),
      redemptionLimit: .selectionMock(),
      source: .selectionMock()
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
      campaignId: .selectionMock(),
      discountTag: .selectionMock(),
      triggerQuantity: .selectionMock()
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

class CampaignsQuerySelectionDecoder {
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

  func campaignAttributes<T>(mapper: (CampaignAttributeSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .campaignAttributes)

    let values = try response.campaignAttributes.unwrapOrFail(context: "campaignAttributes not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = CampaignAttributeSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
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

  func productDeals<T>(mapper: (ProductDealSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .productDeals)

    let values = try response.productDeals.unwrapOrFail(context: "productDeals not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = ProductDealSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
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

  private func insert(selection: CampaignsSelection) {
    if populateSelections {
      campaignsSelections.insert(selection)
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
    insert(selection: .productId)

    let value = try response.productId.unwrapOrFail(context: "productID not found")

    return value
  }

  func quantity() throws -> Int {
    insert(selection: .quantity)

    let value = try response.quantity.unwrapOrFail(context: "quantity not found")

    return value
  }

  private func insert(selection: BenefitSelection) {
    if populateSelections {
      benefitSelections.insert(selection)
    }
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

  func autoApplied() throws -> Bool {
    insert(selection: .autoApplied)

    let value = try response.autoApplied.unwrapOrFail(context: "autoApplied not found")

    return value
  }

  func benefits<T>(mapper: (BenefitSelectionDecoder) throws -> T) throws -> [T]? {
    insert(selection: .benefits)

    let values = try response.benefits.unwrapOrFail(context: "benefits not found")

    if let values = values {
      return try values.compactMap { value in
        let decoder = BenefitSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        benefitSelections = decoder.benefitSelections

        return result
      }
    } else {
      return nil
    }
  }

  func campaignType<T>(mapper: (CampaignTypeEnumResponseModel) throws -> T) throws -> T {
    insert(selection: .campaignType)

    let value = try response.campaignType.unwrapOrFail(context: "campaignType not found")

    return try mapper(value)
  }

  func description() throws -> String {
    insert(selection: .description)

    let value = try response.description.unwrapOrFail(context: "description not found")

    return value
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func name() throws -> String {
    insert(selection: .name)

    let value = try response.name.unwrapOrFail(context: "name not found")

    return value
  }

  func redemptionLimit() throws -> Double {
    insert(selection: .redemptionLimit)

    let value = try response.redemptionLimit.unwrapOrFail(context: "redemptionLimit not found")

    return value
  }

  func source<T>(mapper: (CampaignSourceEnumResponseModel) throws -> T) throws -> T {
    insert(selection: .source)

    let value = try response.source.unwrapOrFail(context: "source not found")

    return try mapper(value)
  }

  private func insert(selection: CampaignAttributeSelection) {
    if populateSelections {
      campaignAttributeSelections.insert(selection)
    }
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

  func campaignAttributes<T>(mapper: (CampaignAttributeSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .campaignAttributes)

    let values = try response.campaignAttributes.unwrapOrFail(context: "campaignAttributes not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = CampaignAttributeSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
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

  func productDeals<T>(mapper: (ProductDealSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .productDeals)

    let values = try response.productDeals.unwrapOrFail(context: "productDeals not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = ProductDealSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
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

  private func insert(selection: CampaignsSelection) {
    if populateSelections {
      campaignsSelections.insert(selection)
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

  func campaignId() throws -> String {
    insert(selection: .campaignId)

    let value = try response.campaignId.unwrapOrFail(context: "campaignID not found")

    return value
  }

  func discountTag() throws -> String {
    insert(selection: .discountTag)

    let value = try response.discountTag.unwrapOrFail(context: "discountTag not found")

    return value
  }

  func triggerQuantity() throws -> Int {
    insert(selection: .triggerQuantity)

    let value = try response.triggerQuantity.unwrapOrFail(context: "triggerQuantity not found")

    return value
  }

  private func insert(selection: DealSelection) {
    if populateSelections {
      dealSelections.insert(selection)
    }
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

  func deals<T>(mapper: (DealSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .deals)

    let values = try response.deals.unwrapOrFail(context: "deals not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = DealSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
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

  func productId() throws -> String {
    insert(selection: .productId)

    let value = try response.productId.unwrapOrFail(context: "productID not found")

    return value
  }

  private func insert(selection: ProductDealSelection) {
    if populateSelections {
      productDealSelections.insert(selection)
    }
  }
}

// MARK: - Mappers

struct CampaignsQueryMapper<T> {
  typealias MapperBlock = (CampaignsQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CampaignsQueryRequestSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CampaignsQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(CampaignsQuerySelectionDecoder(response: response))
  }
}
