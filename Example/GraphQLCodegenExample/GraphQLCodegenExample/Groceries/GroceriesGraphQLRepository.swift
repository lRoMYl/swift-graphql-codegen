// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol GraphQLRepositoring {
  func campaigns(
    with parameters: QueryRequestParameter.Campaigns
  ) -> Single<ApiResponse<Campaigns>>
}

// MARK: - GraphQLRepositoring

final class GraphQLRepository: GraphQLRepositoring {
  private let restClient: RestClient
  private let scheduler: SchedulerType

  init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.restClient = restClient
    self.scheduler = scheduler
  }

  func campaigns(
    with parameters: QueryRequestParameter.Campaigns
  ) -> Single<ApiResponse<Campaigns>> {
    let resource = DefaultResourceParameters
      .queryCampaigns(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }
}

private extension GraphQLRepository {
  func executeGraphQLQuery<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<Query, T>>> = restClient
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

// MARK: - DefaultResourceParameters

enum DefaultResourceParameters: ResourceParameters {
  case queryCampaigns(parameters: QueryRequestParameter.Campaigns)

  func bodyFormat() -> HttpBodyFormat {
    .JSON
  }

  func httpMethod() -> RequestHttpMethod {
    .post
  }

  func servicePath() -> String {
    "query"
  }

  func headers() -> [String: String]? {
    [:]
  }

  func timeoutInterval() -> TimeInterval? {
    nil
  }

  func preventRetry() -> Bool {
    true
  }

  func bodyParameters() -> Any? {
    switch self {
    case let .queryCampaigns(parameters):
      return bodyParameters(parameters: parameters)
    }
  }

  private func bodyParameters<T>(parameters: T) -> [String: Any] where T: GraphQLRequestParameter {
    guard
      let data = try? JSONEncoder().encode(GraphQLRequest(parameters: parameters))
    else { return [:] }

    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
      .flatMap {
        $0 as? [String: Any]
      } ?? [:]
  }
}

// MARK: - GraphQLResponse+QueryWrappedValue

extension GraphQLResponse where OperationType == Query {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Campaigns.Type:
      return data.campaigns as? ReturnType
    default:
      return nil
    }
  }
}
