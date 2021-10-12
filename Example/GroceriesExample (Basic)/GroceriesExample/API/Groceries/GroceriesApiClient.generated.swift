// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol GroceriesApiClientProtocol {
  func campaigns(
    with request: CampaignsQueryRequest,
    selections: CampaignsQueryRequestGraphQLSelections
  ) -> Single<ApiResponse<CampaignsQueryResponse>>
}

// MARK: - GroceriesApiClientProtocol

final class GroceriesApiClient: GroceriesApiClientProtocol {
  private let restClient: RestClient
  private let scheduler: SchedulerType
  private let resourceParametersProvider: GroceriesResourceParametersProviding?

  init(
    restClient: RestClient,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
    resourceParametersProvider: GroceriesResourceParametersProviding? = nil
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersProvider = resourceParametersProvider
  }

  func campaigns(
    with request: CampaignsQueryRequest,
    selections: CampaignsQueryRequestGraphQLSelections
  ) -> Single<ApiResponse<CampaignsQueryResponse>> {
    let resource = GroceriesResourceParametersProvider(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCampaigns(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
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

protocol GroceriesResourceParametersProviding {
  func servicePath(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> String
  func headers(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> [String: String]?
  func timeoutInterval(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> TimeInterval?
  func preventRetry(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
}

struct GroceriesResourceParametersProvider: ResourceParameters {
  enum BodyParameters {
    case queryCampaigns(request: CampaignsQueryRequest, selections: CampaignsQueryRequestGraphQLSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryCampaigns(request, selections):
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

  private let provider: GroceriesResourceParametersProviding?
  private let resourceBodyParameters: BodyParameters

  init(
    provider: GroceriesResourceParametersProviding?,
    resourceBodyParameters: BodyParameters
  ) {
    self.provider = provider
    self.resourceBodyParameters = resourceBodyParameters
  }

  func bodyFormat() -> HttpBodyFormat {
    .JSON
  }

  func httpMethod() -> RequestHttpMethod {
    .post
  }

  func servicePath() -> String {
    provider?.servicePath(with: resourceBodyParameters) ?? ""
  }

  func headers() -> [String: String]? {
    provider?.headers(with: resourceBodyParameters) ?? nil
  }

  func timeoutInterval() -> TimeInterval? {
    provider?.timeoutInterval(with: resourceBodyParameters) ?? nil
  }

  func preventRetry() -> Bool {
    provider?.preventRetry(with: resourceBodyParameters) ?? false
  }

  func preventAddingLanguageParameters() -> Bool {
    provider?.preventAddingLanguageParameters(with: resourceBodyParameters) ?? false
  }

  func bodyParameters() -> Any? {
    return resourceBodyParameters.bodyParameters()
  }
}
