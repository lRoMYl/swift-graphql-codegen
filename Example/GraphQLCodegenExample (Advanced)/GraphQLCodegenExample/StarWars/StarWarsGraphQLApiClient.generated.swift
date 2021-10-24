// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

// MARK: - StarWarsApiClientProtocol

protocol StarWarsApiClientProtocol {
  func query(
    with request: StarWarsQuery,
    selections: StarWarsQuerySelections
  ) -> Single<ApiResponse<QueryStarWarsModel>>
  func human(
    with request: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections
  ) -> Single<ApiResponse<HumanQueryResponse>>
  func droid(
    with request: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections
  ) -> Single<ApiResponse<DroidQueryResponse>>
  func character(
    with request: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections
  ) -> Single<ApiResponse<CharacterQueryResponse>>
  func luke(
    with request: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections
  ) -> Single<ApiResponse<LukeQueryResponse>>
  func humans(
    with request: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections
  ) -> Single<ApiResponse<HumansQueryResponse>>
  func droids(
    with request: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections
  ) -> Single<ApiResponse<DroidsQueryResponse>>
  func characters(
    with request: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections
  ) -> Single<ApiResponse<CharactersQueryResponse>>
  func greeting(
    with request: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections
  ) -> Single<ApiResponse<GreetingQueryResponse>>
  func whoami(
    with request: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>>
  func time(
    with request: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections
  ) -> Single<ApiResponse<TimeQueryResponse>>
  func update(
    with request: StarWarsMutation,
    selections: StarWarsMutationSelections
  ) -> Single<ApiResponse<MutationStarWarsModel>>
  func mutate(
    with request: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections
  ) -> Single<ApiResponse<MutateMutationResponse>>
  func subscribe(
    with request: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections
  ) -> Single<ApiResponse<SubscriptionStarWarsModel>>
  func number(
    with request: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections
  ) -> Single<ApiResponse<NumberSubscriptionResponse>>
}

enum StarWarsApiClientError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

final class StarWarsApiClient: StarWarsApiClientProtocol {
  private let restClient: RestClient
  private let scheduler: SchedulerType
  private let resourceParametersConfigurator: StarWarsResourceParametersConfigurating?

  init(
    restClient: RestClient,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
    resourceParametersConfigurator: StarWarsResourceParametersConfigurating? = nil
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersConfigurator = resourceParametersConfigurator
  }

  func human(
    with request: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections
  ) -> Single<ApiResponse<HumanQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryHuman(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droid(
    with request: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections
  ) -> Single<ApiResponse<DroidQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryDroid(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func character(
    with request: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections
  ) -> Single<ApiResponse<CharacterQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryCharacter(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func luke(
    with request: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections
  ) -> Single<ApiResponse<LukeQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryLuke(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func humans(
    with request: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections
  ) -> Single<ApiResponse<HumansQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryHumans(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droids(
    with request: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections
  ) -> Single<ApiResponse<DroidsQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryDroids(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func characters(
    with request: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections
  ) -> Single<ApiResponse<CharactersQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryCharacters(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func greeting(
    with request: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections
  ) -> Single<ApiResponse<GreetingQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryGreeting(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func whoami(
    with request: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryWhoami(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func time(
    with request: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections
  ) -> Single<ApiResponse<TimeQueryResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .queryTime(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func query(
    with request: StarWarsQuery,
    selections: StarWarsQuerySelections
  ) -> Single<ApiResponse<QueryStarWarsModel>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .query(request: request, selections: selections)
    )

    let response: Single<ApiResponse<QueryStarWarsModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.human, result.data?.human),
          (request.droid, result.data?.droid),
          (request.character, result.data?.character),
          (request.luke, result.data?.luke),
          (request.humans, result.data?.humans),
          (request.droids, result.data?.droids),
          (request.characters, result.data?.characters),
          (request.greeting, result.data?.greeting),
          (request.whoami, result.data?.whoami),
          (request.time, result.data?.time)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
            )
          }
        }

        return result
      }
  }

  func mutate(
    with request: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections
  ) -> Single<ApiResponse<MutateMutationResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .updateMutate(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func update(
    with request: StarWarsMutation,
    selections: StarWarsMutationSelections
  ) -> Single<ApiResponse<MutationStarWarsModel>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .update(request: request, selections: selections)
    )

    let response: Single<ApiResponse<MutationStarWarsModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.mutate, result.data?.mutate)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
            )
          }
        }

        return result
      }
  }

  func number(
    with request: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections
  ) -> Single<ApiResponse<NumberSubscriptionResponse>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .subscribeNumber(request: request, selections: selections)
    )

    return executeGraphQLSubscription(
      resource: resource
    )
  }

  func subscribe(
    with request: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections
  ) -> Single<ApiResponse<SubscriptionStarWarsModel>> {
    let resource = StarWarsResourceParametersProvider(
      resourceParametersConfigurator: resourceParametersConfigurator,
      resourceBodyParameters: .subscribe(request: request, selections: selections)
    )

    let response: Single<ApiResponse<SubscriptionStarWarsModel>> = executeGraphQLQuery(resource: resource)

    return response
      .map { result in
        let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
          (request.number, result.data?.number)
        ]

        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.operationDefinition()) }"
            )
          }
        }

        return result
      }
  }
}

private extension StarWarsApiClient {
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

// MARK: - StarWarsResourceParametersProvider

protocol StarWarsResourceParametersConfigurating {
  func servicePath(with bodyParameters: StarWarsResourceParametersProvider.BodyParameters) -> String
  func headers(with bodyParameters: StarWarsResourceParametersProvider.BodyParameters) -> [String: String]?
  func timeoutInterval(with bodyParameters: StarWarsResourceParametersProvider.BodyParameters) -> TimeInterval?
  func preventRetry(with bodyParameters: StarWarsResourceParametersProvider.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with bodyParameters: StarWarsResourceParametersProvider.BodyParameters) -> Bool
}

struct StarWarsResourceParametersProvider: ResourceParameters {
  enum BodyParameters {
    case queryHuman(request: HumanStarWarsQuery, selections: HumanStarWarsQuerySelections)
    case queryDroid(request: DroidStarWarsQuery, selections: DroidStarWarsQuerySelections)
    case queryCharacter(request: CharacterStarWarsQuery, selections: CharacterStarWarsQuerySelections)
    case queryLuke(request: LukeStarWarsQuery, selections: LukeStarWarsQuerySelections)
    case queryHumans(request: HumansStarWarsQuery, selections: HumansStarWarsQuerySelections)
    case queryDroids(request: DroidsStarWarsQuery, selections: DroidsStarWarsQuerySelections)
    case queryCharacters(request: CharactersStarWarsQuery, selections: CharactersStarWarsQuerySelections)
    case queryGreeting(request: GreetingStarWarsQuery, selections: GreetingStarWarsQuerySelections)
    case queryWhoami(request: WhoamiStarWarsQuery, selections: WhoamiStarWarsQuerySelections)
    case queryTime(request: TimeStarWarsQuery, selections: TimeStarWarsQuerySelections)
    case query(request: StarWarsQuery, selections: StarWarsQuerySelections)
    case updateMutate(request: MutateStarWarsMutation, selections: MutateStarWarsMutationSelections)
    case update(request: StarWarsMutation, selections: StarWarsMutationSelections)
    case subscribeNumber(request: NumberStarWarsSubscription, selections: NumberStarWarsSubscriptionSelections)
    case subscribe(request: StarWarsSubscription, selections: StarWarsSubscriptionSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryHuman(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryDroid(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryCharacter(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryLuke(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryHumans(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryDroids(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryCharacters(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryGreeting(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryWhoami(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .queryTime(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .query(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .updateMutate(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .update(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .subscribeNumber(request, selections):
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

  private let resourceParametersConfigurator: StarWarsResourceParametersConfigurating?
  private let resourceBodyParameters: BodyParameters

  init(
    resourceParametersConfigurator: StarWarsResourceParametersConfigurating?,
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