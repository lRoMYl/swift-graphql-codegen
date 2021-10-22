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
