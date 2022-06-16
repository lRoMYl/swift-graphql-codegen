// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import ApiClient
import Foundation
import RxSwift
// MARK: - GroceriesApiClientProtocol

protocol GroceriesApiClientProtocol {
  func query(
    with request: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<QueryResponseModel>>>
  func campaigns(
    with request: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<CampaignsQueryResponse>>>
  func products(
    with request: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<ProductsQueryResponse>>>
  func shopDetails(
    with request: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<ShopDetailsQueryResponse>>>
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
  ) -> Single<ApiResponse<GraphQLResponse<CampaignsQueryResponse>>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryCampaigns(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func products(
    with request: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<ProductsQueryResponse>>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryProducts(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func shopDetails(
    with request: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<ShopDetailsQueryResponse>>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryShopDetails(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func query(
    with request: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<ApiResponse<GraphQLResponse<QueryResponseModel>>> {
    let resource = GroceriesResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .query(request: request, selections: selections)
    )

    let response: Single<ApiResponse<GraphQLResponse<QueryResponseModel>>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Decodable?)] = [
          (request.campaigns, result.data?.data?.campaigns),
          (request.products, result.data?.data?.products),
          (request.shopDetails, result.data?.data?.shopDetails)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw GroceriesApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
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
  ) -> Single<ApiResponse<GraphQLResponse<Response>>> where Response: Decodable {
    let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data,
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
    case queryProducts(request: ProductsQueryRequest, selections: ProductsQueryRequestSelections)
    case queryShopDetails(request: ShopDetailsQueryRequest, selections: ShopDetailsQueryRequestSelections)
    case query(request: QueryRequest, selections: QueryRequestSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryCampaigns(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryProducts(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryShopDetails(request, selections):
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