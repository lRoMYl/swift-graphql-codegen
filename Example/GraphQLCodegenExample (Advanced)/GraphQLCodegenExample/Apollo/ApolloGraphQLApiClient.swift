// @generated
// Do not edit this generated file
// swiftlint:disable all

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
  func tripsBooked(
    with request: TripsBookedApolloQuery,
    selections: TripsBookedApolloQuerySelections
  ) -> Single<ApiResponse<TripsBookedQueryResponse>>
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

  func tripsBooked(
    with request: TripsBookedApolloQuery,
    selections: TripsBookedApolloQuerySelections
  ) -> Single<ApiResponse<TripsBookedQueryResponse>> {
    let resource = ApolloResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryTripsBooked(request: request, selections: selections)
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
          (request.tripsBooked, result.data?.tripsBooked)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
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
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
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
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
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
    case queryTripsBooked(request: TripsBookedApolloQuery, selections: TripsBookedApolloQuerySelections)
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
      case let .queryTripsBooked(request, selections):
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

// MARK: - SelectionMock

extension PatchSizeApolloEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension CacheControlScopeApolloEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension QueryApolloModel {
  static func selectionMock() -> Self {
    QueryApolloModel(
      launch: .selectionMock(),
      launches: .selectionMock(),
      me: .selectionMock(),
      tripsBooked: .selectionMock()
    )
  }
}

extension LaunchConnectionApolloModel {
  static func selectionMock() -> Self {
    LaunchConnectionApolloModel(
      cursor: .selectionMock(),
      hasMore: .selectionMock(),
      launches: [.selectionMock()]
    )
  }
}

extension LaunchApolloModel {
  static func selectionMock() -> Self {
    LaunchApolloModel(
      id: .selectionMock(),
      isBooked: .selectionMock(),
      mission: .selectionMock(),
      rocket: .selectionMock(),
      site: .selectionMock()
    )
  }
}

extension MissionApolloModel {
  static func selectionMock() -> Self {
    MissionApolloModel(
      missionPatch: .selectionMock(),
      name: .selectionMock()
    )
  }
}

extension RocketApolloModel {
  static func selectionMock() -> Self {
    RocketApolloModel(
      id: .selectionMock(),
      name: .selectionMock(),
      type: .selectionMock()
    )
  }
}

extension UserApolloModel {
  static func selectionMock() -> Self {
    UserApolloModel(
      email: .selectionMock(),
      id: .selectionMock(),
      profileImage: .selectionMock(),
      trips: [.selectionMock()]
    )
  }
}

extension MutationApolloModel {
  static func selectionMock() -> Self {
    MutationApolloModel(
      bookTrips: .selectionMock(),
      cancelTrip: .selectionMock(),
      login: .selectionMock(),
      uploadProfileImage: .selectionMock()
    )
  }
}

extension TripUpdateResponseApolloModel {
  static func selectionMock() -> Self {
    TripUpdateResponseApolloModel(
      launches: [.selectionMock()],
      message: .selectionMock(),
      success: .selectionMock()
    )
  }
}

extension SubscriptionApolloModel {
  static func selectionMock() -> Self {
    SubscriptionApolloModel(
      tripsBooked: .selectionMock()
    )
  }
}

// MARK: - ResponseSelectionDecoder

class LaunchesQueryResponseSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var launchConnectionSelections = Set<LaunchConnectionSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchConnectionApolloModel
  private let populateSelections: Bool

  init(response: LaunchConnectionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func cursor() throws -> String {
    if populateSelections {
      launchConnectionSelections.insert(.cursor)
    }

    guard let value = response.cursor else {
      throw ApolloApiClientError.missingData(context: "cursor not found")
    }

    return value
  }

  func hasMore() throws -> Bool {
    if populateSelections {
      launchConnectionSelections.insert(.hasMore)
    }

    guard let value = response.hasMore else {
      throw ApolloApiClientError.missingData(context: "hasMore not found")
    }

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      launchConnectionSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloApiClientError.missingData(context: "launches not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        launchSelections = decoder.launchSelections
        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections

        return result
      } else {
        return nil
      }
    }
  }
}

class LaunchQueryResponseSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchApolloModel
  private let populateSelections: Bool

  init(response: LaunchApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      launchSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func site() throws -> String? {
    if populateSelections {
      launchSelections.insert(.site)
    }

    guard let value = response.site else {
      throw ApolloApiClientError.missingData(context: "site not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.mission)
    }

    guard let value = response.mission else {
      throw ApolloApiClientError.missingData(context: "mission not found")
    }

    if let value = value {
      let decoder = MissionSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.rocket)
    }

    guard let value = response.rocket else {
      throw ApolloApiClientError.missingData(context: "rocket not found")
    }

    if let value = value {
      let decoder = RocketSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func isBooked() throws -> Bool {
    if populateSelections {
      launchSelections.insert(.isBooked)
    }

    guard let value = response.isBooked else {
      throw ApolloApiClientError.missingData(context: "isBooked not found")
    }

    return value
  }
}

class MeQueryResponseSelectionDecoder {
  private(set) var userSelections = Set<UserSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloApiClientError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloApiClientError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloApiClientError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }
}

class BookTripsMutationResponseSelectionDecoder {
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloApiClientError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloApiClientError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloApiClientError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

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

class CancelTripMutationResponseSelectionDecoder {
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloApiClientError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloApiClientError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloApiClientError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

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

class UploadProfileImageMutationResponseSelectionDecoder {
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var userSelections = Set<UserSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloApiClientError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloApiClientError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloApiClientError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }
}

class LaunchConnectionSelectionDecoder {
  private(set) var launchConnectionSelections = Set<LaunchConnectionSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchConnectionApolloModel
  private let populateSelections: Bool

  init(response: LaunchConnectionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func cursor() throws -> String {
    if populateSelections {
      launchConnectionSelections.insert(.cursor)
    }

    guard let value = response.cursor else {
      throw ApolloApiClientError.missingData(context: "cursor not found")
    }

    return value
  }

  func hasMore() throws -> Bool {
    if populateSelections {
      launchConnectionSelections.insert(.hasMore)
    }

    guard let value = response.hasMore else {
      throw ApolloApiClientError.missingData(context: "hasMore not found")
    }

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      launchConnectionSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloApiClientError.missingData(context: "launches not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        launchSelections = decoder.launchSelections
        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections

        return result
      } else {
        return nil
      }
    }
  }
}

class LaunchSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchApolloModel
  private let populateSelections: Bool

  init(response: LaunchApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      launchSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func site() throws -> String? {
    if populateSelections {
      launchSelections.insert(.site)
    }

    guard let value = response.site else {
      throw ApolloApiClientError.missingData(context: "site not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.mission)
    }

    guard let value = response.mission else {
      throw ApolloApiClientError.missingData(context: "mission not found")
    }

    if let value = value {
      let decoder = MissionSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.rocket)
    }

    guard let value = response.rocket else {
      throw ApolloApiClientError.missingData(context: "rocket not found")
    }

    if let value = value {
      let decoder = RocketSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func isBooked() throws -> Bool {
    if populateSelections {
      launchSelections.insert(.isBooked)
    }

    guard let value = response.isBooked else {
      throw ApolloApiClientError.missingData(context: "isBooked not found")
    }

    return value
  }
}

class MissionSelectionDecoder {
  private(set) var missionSelections = Set<MissionSelection>()
  private let response: MissionApolloModel
  private let populateSelections: Bool

  init(response: MissionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func name() throws -> String? {
    if populateSelections {
      missionSelections.insert(.name)
    }

    guard let value = response.name else {
      throw ApolloApiClientError.missingData(context: "name not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func missionPatch() throws -> String? {
    if populateSelections {
      missionSelections.insert(.missionPatch)
    }

    guard let value = response.missionPatch else {
      throw ApolloApiClientError.missingData(context: "missionPatch not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }
}

class RocketSelectionDecoder {
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: RocketApolloModel
  private let populateSelections: Bool

  init(response: RocketApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      rocketSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func name() throws -> String? {
    if populateSelections {
      rocketSelections.insert(.name)
    }

    guard let value = response.name else {
      throw ApolloApiClientError.missingData(context: "name not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func type() throws -> String? {
    if populateSelections {
      rocketSelections.insert(.type)
    }

    guard let value = response.type else {
      throw ApolloApiClientError.missingData(context: "type not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }
}

class UserSelectionDecoder {
  private(set) var userSelections = Set<UserSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloApiClientError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloApiClientError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloApiClientError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloApiClientError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }
}

class TripUpdateResponseSelectionDecoder {
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloApiClientError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloApiClientError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloApiClientError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

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
