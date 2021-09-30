// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol GroceriesApiClientImplementing {
  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<ApiResponse<CampaignsResponseModel?>>
}

// MARK: - GroceriesApiClientImplementing

final class GroceriesApiClient: GroceriesApiClientImplementing {
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
  ) -> Single<ApiResponse<CampaignsResponseModel?>> {
    let resource = GroceriesResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCampaigns(parameters: parameters)
    )

    return executeGraphQLQuery(
      responseData: CampaignsQueryResponse.self,
      resource: resource
    )
  }
}

private extension GroceriesApiClient {
  func executeGraphQLQuery<R, T>(
    responseData _: R.Type,
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where R: GraphQLResponseData, T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<R, T>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data?.wrappedValue,
          httpURLResponse: apiResponse.httpURLResponse,
          metaData: apiResponse.metaData
        )
      }
      .subscribeOn(scheduler)
  }
}

// MARK: - GroceriesResourceParameters

protocol GroceriesResourceParametersProviding {
  func servicePath(with resourceParameters: GroceriesResourceBodyParameters) -> String
  func headers(with resourceParameters: GroceriesResourceBodyParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: GroceriesResourceBodyParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: GroceriesResourceBodyParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: GroceriesResourceBodyParameters) -> Bool
}

final class GroceriesResourceParameters: ResourceParameters {
  private let provider: GroceriesResourceParametersProviding?
  private let resourceBodyParameters: GroceriesResourceBodyParameters

  init(
    provider: GroceriesResourceParametersProviding?,
    resourceBodyParameters: GroceriesResourceBodyParameters
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

enum GroceriesResourceBodyParameters {
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

extension GraphQLResponse where ResponseData == CampaignsQueryResponse {
  var wrappedValue: ReturnType? {
    return data.campaigns as? ReturnType
  }
}
