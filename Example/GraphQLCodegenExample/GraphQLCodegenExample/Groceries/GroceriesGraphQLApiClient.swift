// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol GroceriesApiClientProtocol {
  func campaigns(
    with parameters: CampaignsQueryRequest
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
    resourceParametersProvider: GroceriesResourceParametersProviding?
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersProvider = resourceParametersProvider
  }

  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<ApiResponse<CampaignsQueryResponse>> {
    let resource = GroceriesResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCampaigns(parameters: parameters)
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
      .subscribeOn(scheduler)
  }
}

// MARK: - GroceriesResourceParameters

protocol GroceriesResourceParametersProviding {
  func servicePath(with resourceParameters: GroceriesResourceParameters.BodyParameters) -> String
  func headers(with resourceParameters: GroceriesResourceParameters.BodyParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: GroceriesResourceParameters.BodyParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: GroceriesResourceParameters.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: GroceriesResourceParameters.BodyParameters) -> Bool
}

struct GroceriesResourceParameters: ResourceParameters {
  enum BodyParameters {
    case queryCampaigns(parameters: CampaignsQueryRequest)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryCampaigns(parameters):
        return bodyParameters(parameters: parameters)
      }
    }

    private func bodyParameters<T>(parameters: T) -> [String: Any] where T: GraphQLRequesting {
      guard
        let data = try? JSONEncoder().encode(GraphQLRequestCodableWrapper(parameters: parameters))
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
