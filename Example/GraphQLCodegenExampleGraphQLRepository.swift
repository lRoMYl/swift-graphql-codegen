// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol GraphQLRepositoring {
  func campaigns(
    with parameters: GraphQLQueries.CampaignsRequestParameter
  ) -> Single<ApiResponse<GraphQLObjects.Campaigns>>
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
    with parameters: GraphQLQueries.CampaignsRequestParameter
  ) -> Single<ApiResponse<GraphQLObjects.Campaigns>> {
    let resource = GraphQLResourceParameters
      .queryCampaigns(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }
}

private extension GraphQLRepository {
  func executeGraphQLQuery<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<GraphQLObjects.Query, T>>> = restClient
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

// MARK: - GraphQLResourceParameters

protocol GraphQLResourceParametersImplementing {
  func servicePath(with resourceParameters: GraphQLResourceParameters) -> String
  func headers(with resourceParameters: GraphQLResourceParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: GraphQLResourceParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: GraphQLResourceParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: GraphQLResourceParameters) -> Bool
}

final class GraphQLResourceParametersDIContainer {
  static let shared = GraphQLResourceParametersDIContainer()

  var implementation: GraphQLResourceParametersImplementing?
}

enum GraphQLResourceParameters: ResourceParameters {
  private static var diContainer = GraphQLResourceParametersDIContainer.shared

  case queryCampaigns(parameters: GraphQLQueries.CampaignsRequestParameter)

  func bodyFormat() -> HttpBodyFormat {
    .JSON
  }

  func httpMethod() -> RequestHttpMethod {
    .post
  }

  func servicePath() -> String {
    Self.diContainer.implementation?.servicePath(with: self) ?? ""
  }

  func headers() -> [String: String]? {
    Self.diContainer.implementation?.headers(with: self) ?? nil
  }

  func timeoutInterval() -> TimeInterval? {
    Self.diContainer.implementation?.timeoutInterval(with: self) ?? nil
  }

  func preventRetry() -> Bool {
    Self.diContainer.implementation?.preventRetry(with: self) ?? false
  }

  func preventAddingLanguageParameters() -> Bool {
    Self.diContainer.implementation?.preventAddingLanguageParameters(with: self) ?? false
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

// MARK: - GraphQLResponse+GraphQLObjects.QueryWrappedValue

extension GraphQLResponse where OperationType == GraphQLObjects.Query {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is GraphQLObjects.Campaigns.Type:
      return data.campaigns as? ReturnType
    default:
      return nil
    }
  }
}
