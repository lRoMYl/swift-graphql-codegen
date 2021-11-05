// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import ApiClient
import Foundation
import RxSwift
// MARK: - ApolloApiClientProtocol

protocol ApolloApiClientProtocol {
  func query(
    with request: ApolloQuery,
    selections: ApolloQuerySelections
  ) -> Single<ApiResponse<QueryApolloModel>>
  func launches(
    with request: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections
  ) -> Single<ApiResponse<LaunchesQueryResponse>>
  func launch(
    with request: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections
  ) -> Single<ApiResponse<LaunchQueryResponse>>
  func me(
    with request: MeApolloQuery,
    selections: MeApolloQuerySelections
  ) -> Single<ApiResponse<MeQueryResponse>>
  func totalTripsBooked(
    with request: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections
  ) -> Single<ApiResponse<TotalTripsBookedQueryResponse>>
  func update(
    with request: ApolloMutation,
    selections: ApolloMutationSelections
  ) -> Single<ApiResponse<MutationApolloModel>>
  func bookTrips(
    with request: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections
  ) -> Single<ApiResponse<BookTripsMutationResponse>>
  func cancelTrip(
    with request: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections
  ) -> Single<ApiResponse<CancelTripMutationResponse>>
  func login(
    with request: LoginApolloMutation,
    selections: LoginApolloMutationSelections
  ) -> Single<ApiResponse<LoginMutationResponse>>
  func uploadProfileImage(
    with request: UploadProfileImageApolloMutation,
    selections: UploadProfileImageApolloMutationSelections
  ) -> Single<ApiResponse<UploadProfileImageMutationResponse>>
  func subscribe(
    with request: ApolloSubscription,
    selections: ApolloSubscriptionSelections
  ) -> Single<ApiResponse<SubscriptionApolloModel>>
  func tripsBooked(
    with request: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections
  ) -> Single<ApiResponse<TripsBookedSubscriptionResponse>>
}

enum ApolloApiClientError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

final class ApolloApiClient: ApolloApiClientProtocol {
  private let restClient: RestClient
  private let scheduler: SchedulerType
  private let resourceParametersConfigurator: ApolloResourceParametersConfigurating?

  init(
    restClient: RestClient,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
    resourceParametersConfigurator: ApolloResourceParametersConfigurating? = nil
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersConfigurator = resourceParametersConfigurator
  }

  func launches(
    with request: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections
  ) -> Single<ApiResponse<LaunchesQueryResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryLaunches(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func launch(
    with request: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections
  ) -> Single<ApiResponse<LaunchQueryResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryLaunch(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func me(
    with request: MeApolloQuery,
    selections: MeApolloQuerySelections
  ) -> Single<ApiResponse<MeQueryResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryMe(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func totalTripsBooked(
    with request: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections
  ) -> Single<ApiResponse<TotalTripsBookedQueryResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryTotalTripsBooked(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func query(
    with request: ApolloQuery,
    selections: ApolloQuerySelections
  ) -> Single<ApiResponse<QueryApolloModel>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .query(request: request, selections: selections)
    )

    let response: Single<ApiResponse<QueryApolloModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.launches, result.data?.launches),
          (request.launch, result.data?.launch),
          (request.me, result.data?.me),
          (request.totalTripsBooked, result.data?.totalTripsBooked)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery()) }"
            )
          }
        }

        return result
      }
  }

  func bookTrips(
    with request: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections
  ) -> Single<ApiResponse<BookTripsMutationResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .updateBookTrips(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func cancelTrip(
    with request: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections
  ) -> Single<ApiResponse<CancelTripMutationResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .updateCancelTrip(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func login(
    with request: LoginApolloMutation,
    selections: LoginApolloMutationSelections
  ) -> Single<ApiResponse<LoginMutationResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .updateLogin(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func uploadProfileImage(
    with request: UploadProfileImageApolloMutation,
    selections: UploadProfileImageApolloMutationSelections
  ) -> Single<ApiResponse<UploadProfileImageMutationResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .updateUploadProfileImage(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func update(
    with request: ApolloMutation,
    selections: ApolloMutationSelections
  ) -> Single<ApiResponse<MutationApolloModel>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .update(request: request, selections: selections)
    )

    let response: Single<ApiResponse<MutationApolloModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.bookTrips, result.data?.bookTrips),
          (request.cancelTrip, result.data?.cancelTrip),
          (request.login, result.data?.login),
          (request.uploadProfileImage, result.data?.uploadProfileImage)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery()) }"
            )
          }
        }

        return result
      }
  }

  func tripsBooked(
    with request: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections
  ) -> Single<ApiResponse<TripsBookedSubscriptionResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .subscribeTripsBooked(request: request, selections: selections)
    )

    return executeGraphQLSubscription(
      resource: resource
    )
  }

  func subscribe(
    with request: ApolloSubscription,
    selections: ApolloSubscriptionSelections
  ) -> Single<ApiResponse<SubscriptionApolloModel>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .subscribe(request: request, selections: selections)
    )

    let response: Single<ApiResponse<SubscriptionApolloModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.tripsBooked, result.data?.tripsBooked)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery()) }"
            )
          }
        }

        return result
      }
  }
}

private extension ApolloApiClient {
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

  func executeGraphQLMutation<Response>(
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

  func executeGraphQLSubscription<Response>(
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

// MARK: - ApolloResourceParametersProvider

protocol ApolloResourceParametersConfigurating {
  func servicePath(with bodyParameters: ApolloResourceParametersProvider.BodyParameters) -> String
  func headers(with bodyParameters: ApolloResourceParametersProvider.BodyParameters) -> [String: String]?
  func timeoutInterval(with bodyParameters: ApolloResourceParametersProvider.BodyParameters) -> TimeInterval?
  func preventRetry(with bodyParameters: ApolloResourceParametersProvider.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with bodyParameters: ApolloResourceParametersProvider.BodyParameters) -> Bool
}

struct ApolloResourceParametersProvider: ResourceParameters {
  enum BodyParameters {
    case queryLaunches(request: LaunchesApolloQuery, selections: LaunchesApolloQuerySelections)
    case queryLaunch(request: LaunchApolloQuery, selections: LaunchApolloQuerySelections)
    case queryMe(request: MeApolloQuery, selections: MeApolloQuerySelections)
    case queryTotalTripsBooked(request: TotalTripsBookedApolloQuery, selections: TotalTripsBookedApolloQuerySelections)
    case query(request: ApolloQuery, selections: ApolloQuerySelections)
    case updateBookTrips(request: BookTripsApolloMutation, selections: BookTripsApolloMutationSelections)
    case updateCancelTrip(request: CancelTripApolloMutation, selections: CancelTripApolloMutationSelections)
    case updateLogin(request: LoginApolloMutation, selections: LoginApolloMutationSelections)
    case updateUploadProfileImage(request: UploadProfileImageApolloMutation, selections: UploadProfileImageApolloMutationSelections)
    case update(request: ApolloMutation, selections: ApolloMutationSelections)
    case subscribeTripsBooked(request: TripsBookedApolloSubscription, selections: TripsBookedApolloSubscriptionSelections)
    case subscribe(request: ApolloSubscription, selections: ApolloSubscriptionSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryLaunches(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryLaunch(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryMe(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryTotalTripsBooked(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .query(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .updateBookTrips(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .updateCancelTrip(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .updateLogin(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .updateUploadProfileImage(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .update(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .subscribeTripsBooked(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .subscribe(request, selections):
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

  private let resourceParametersConfigurator: ApolloResourceParametersConfigurating?
  private let resourceBodyParameters: BodyParameters

  init(
    resourceParametersConfigurator: ApolloResourceParametersConfigurating?,
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