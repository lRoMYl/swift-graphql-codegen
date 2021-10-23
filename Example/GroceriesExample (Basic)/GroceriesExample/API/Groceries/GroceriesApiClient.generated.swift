// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

// MARK: - GroceriesApiClientProtocol

protocol GroceriesApiClientProtocol {
  func query(
    with request: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<ApiResponse<QueryResponseModel>>
  func campaigns(
    with request: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections
  ) -> Single<ApiResponse<CampaignsQueryResponse>>
}

enum GroceriesApiClientError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

final class GroceriesApiClient: GroceriesApiClientProtocol {
  private let restClient: RestClient
  private let scheduler: SchedulerType
  private let resourceParametersConfigurator: GroceriesResourceParametersConfigurating?

  init(
    restClient: RestClient,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
    resourceParametersConfigurator: GroceriesResourceParametersConfigurating? = nil
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersConfigurator = resourceParametersConfigurator
  }

  func campaigns(
    with request: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections
  ) -> Single<ApiResponse<CampaignsQueryResponse>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryCampaigns(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func query(
    with request: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<ApiResponse<QueryResponseModel>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .query(request: request, selections: selections)
    )

    let response: Single<ApiResponse<QueryResponseModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.campaigns, result.data?.campaigns)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw GroceriesApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
            )
          }
        }

        return result
      }
  }
}

private extension GroceriesApiClient {
  func executeGraphQLQuery<Response>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<Response>> where Response: Codable {
    let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data?.data,
          httpURLResponse: apiResponse.httpURLResponse,
          metaData: apiResponse.metaData
        )
      }
      .subscribe(on: scheduler)
  }
}

// MARK: - GroceriesResourceParametersProvider

protocol GroceriesResourceParametersConfigurating {
  func servicePath(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> String
  func headers(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> [String: String]?
  func timeoutInterval(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> TimeInterval?
  func preventRetry(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
}

struct GroceriesResourceParametersProvider: ResourceParameters {
  enum BodyParameters {
    case queryCampaigns(request: CampaignsQueryRequest, selections: CampaignsQueryRequestSelections)
    case query(request: QueryRequest, selections: QueryRequestSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryCampaigns(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .query(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      }
    }

    private func bodyParameters<T>(request: T, selections: GraphQLSelections) -> [String: Any] where T: GraphQLRequesting {
      guard
        let data = try? JSONEncoder().encode(GraphQLRequest(parameters: request, selections: selections))
      else { return [:] }

      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
        .flatMap {
          $0 as? [String: Any]
        } ?? [:]
    }
  }

  private let resourceParametersConfigurator: GroceriesResourceParametersConfigurating?
  private let resourceBodyParameters: BodyParameters

  init(
    resourceParametersConfigurator: GroceriesResourceParametersConfigurating?,
    resourceBodyParameters: BodyParameters
  ) {
    self.resourceParametersConfigurator = resourceParametersConfigurator
    self.resourceBodyParameters = resourceBodyParameters
  }

  func bodyFormat() -> HttpBodyFormat {
    .JSON
  }

  func httpMethod() -> RequestHttpMethod {
    .post
  }

  func servicePath() -> String {
    resourceParametersConfigurator?.servicePath(with: resourceBodyParameters) ?? ""
  }

  func headers() -> [String: String]? {
    resourceParametersConfigurator?.headers(with: resourceBodyParameters) ?? nil
  }

  func timeoutInterval() -> TimeInterval? {
    resourceParametersConfigurator?.timeoutInterval(with: resourceBodyParameters) ?? nil
  }

  func preventRetry() -> Bool {
    resourceParametersConfigurator?.preventRetry(with: resourceBodyParameters) ?? false
  }

  func preventAddingLanguageParameters() -> Bool {
    resourceParametersConfigurator?.preventAddingLanguageParameters(with: resourceBodyParameters) ?? false
  }

  func bodyParameters() -> Any? {
    return resourceBodyParameters.bodyParameters()
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

// MARK: - ResponseSelectionDecoder

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
      throw GroceriesApiClientError.missingData(context: "productDeals not found")
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
      throw GroceriesApiClientError.missingData(context: "campaignAttributes not found")
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
      throw GroceriesApiClientError.missingData(context: "productID not found")
    }

    return value
  }

  func quantity() throws -> Int {
    if populateSelections {
      benefitSelections.insert(.quantity)
    }

    guard let value = response.quantity else {
      throw GroceriesApiClientError.missingData(context: "quantity not found")
    }

    return value
  }
}

class CampaignAttributeSelectionDecoder {
  private(set) var campaignAttributeSelections = Set<CampaignAttributeSelection>()
  private(set) var benefitSelections = Set<BenefitSelection>()
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
      throw GroceriesApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func redemptionLimit() throws -> Double {
    if populateSelections {
      campaignAttributeSelections.insert(.redemptionLimit)
    }

    guard let value = response.redemptionLimit else {
      throw GroceriesApiClientError.missingData(context: "redemptionLimit not found")
    }

    return value
  }

  func autoApplied() throws -> Bool {
    if populateSelections {
      campaignAttributeSelections.insert(.autoApplied)
    }

    guard let value = response.autoApplied else {
      throw GroceriesApiClientError.missingData(context: "autoApplied not found")
    }

    return value
  }

  func source<T>(mapper: (CampaignSourceEnumResponseModel) throws -> T) throws -> T {
    if populateSelections {
      campaignAttributeSelections.insert(.source)
    }

    guard let value = response.source else {
      throw GroceriesApiClientError.missingData(context: "source not found")
    }

    return try mapper(value)
  }

  func campaignType<T>(mapper: (CampaignTypeEnumResponseModel) throws -> T) throws -> T {
    if populateSelections {
      campaignAttributeSelections.insert(.campaignType)
    }

    guard let value = response.campaignType else {
      throw GroceriesApiClientError.missingData(context: "campaignType not found")
    }

    return try mapper(value)
  }

  func benefits<T>(mapper: (BenefitSelectionDecoder) throws -> T) throws -> [T]? {
    if populateSelections {
      campaignAttributeSelections.insert(.benefits)
    }

    guard let values = response.benefits else {
      throw GroceriesApiClientError.missingData(context: "benefits not found")
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
      throw GroceriesApiClientError.missingData(context: "name not found")
    }

    return value
  }

  func description() throws -> String {
    if populateSelections {
      campaignAttributeSelections.insert(.description)
    }

    guard let value = response.description else {
      throw GroceriesApiClientError.missingData(context: "description not found")
    }

    return value
  }
}

class CampaignsSelectionDecoder {
  private(set) var campaignsSelections = Set<CampaignsSelection>()
  private(set) var benefitSelections = Set<BenefitSelection>()
  private(set) var campaignAttributeSelections = Set<CampaignAttributeSelection>()
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
      throw GroceriesApiClientError.missingData(context: "productDeals not found")
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
      throw GroceriesApiClientError.missingData(context: "campaignAttributes not found")
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
      throw GroceriesApiClientError.missingData(context: "discountTag not found")
    }

    return value
  }

  func triggerQuantity() throws -> Int {
    if populateSelections {
      dealSelections.insert(.triggerQuantity)
    }

    guard let value = response.triggerQuantity else {
      throw GroceriesApiClientError.missingData(context: "triggerQuantity not found")
    }

    return value
  }

  func campaignId() throws -> String {
    if populateSelections {
      dealSelections.insert(.campaignId)
    }

    guard let value = response.campaignId else {
      throw GroceriesApiClientError.missingData(context: "campaignID not found")
    }

    return value
  }
}

class ProductDealSelectionDecoder {
  private(set) var productDealSelections = Set<ProductDealSelection>()
  private(set) var dealSelections = Set<DealSelection>()
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
      throw GroceriesApiClientError.missingData(context: "productID not found")
    }

    return value
  }

  func deals<T>(mapper: (DealSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      productDealSelections.insert(.deals)
    }

    guard let values = response.deals else {
      throw GroceriesApiClientError.missingData(context: "deals not found")
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
