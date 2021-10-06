// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientProtocol {
  func human(
    with request: HumanStarWarsQuery,
    selections: HumanStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumanQueryResponse>>
  func droid(
    with request: DroidStarWarsQuery,
    selections: DroidStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidQueryResponse>>
  func character(
    with request: CharacterStarWarsQuery,
    selections: CharacterStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharacterQueryResponse>>
  func luke(
    with request: LukeStarWarsQuery,
    selections: LukeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<LukeQueryResponse>>
  func humans(
    with request: HumansStarWarsQuery,
    selections: HumansStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumansQueryResponse>>
  func droids(
    with request: DroidsStarWarsQuery,
    selections: DroidsStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidsQueryResponse>>
  func characters(
    with request: CharactersStarWarsQuery,
    selections: CharactersStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharactersQueryResponse>>
  func greeting(
    with request: GreetingStarWarsQuery,
    selections: GreetingStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<GreetingQueryResponse>>
  func whoami(
    with request: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>>
  func time(
    with request: TimeStarWarsQuery,
    selections: TimeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<TimeQueryResponse>>
  func mutate(
    with request: MutateStarWarsMutation,
    selections: MutateStarWarsMutationGraphQLSelections
  ) -> Single<ApiResponse<MutateMutationResponse>>
  func number(
    with request: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionGraphQLSelections
  ) -> Single<ApiResponse<NumberSubscriptionResponse>>
}

// MARK: - StarWarsApiClientProtocol

final class StarWarsApiClient: StarWarsApiClientProtocol {
  private let restClient: RestClient
  private let scheduler: SchedulerType
  private let resourceParametersProvider: StarWarsResourceParametersProviding?

  init(
    restClient: RestClient,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
    resourceParametersProvider: StarWarsResourceParametersProviding? = nil
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersProvider = resourceParametersProvider
  }

  func human(
    with request: HumanStarWarsQuery,
    selections: HumanStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumanQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHuman(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droid(
    with request: DroidStarWarsQuery,
    selections: DroidStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroid(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func character(
    with request: CharacterStarWarsQuery,
    selections: CharacterStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharacterQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacter(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func luke(
    with request: LukeStarWarsQuery,
    selections: LukeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<LukeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryLuke(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func humans(
    with request: HumansStarWarsQuery,
    selections: HumansStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumansQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHumans(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droids(
    with request: DroidsStarWarsQuery,
    selections: DroidsStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidsQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroids(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func characters(
    with request: CharactersStarWarsQuery,
    selections: CharactersStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharactersQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacters(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func greeting(
    with request: GreetingStarWarsQuery,
    selections: GreetingStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<GreetingQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryGreeting(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func whoami(
    with request: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryWhoami(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func time(
    with request: TimeStarWarsQuery,
    selections: TimeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<TimeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryTime(request: request, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func mutate(
    with request: MutateStarWarsMutation,
    selections: MutateStarWarsMutationGraphQLSelections
  ) -> Single<ApiResponse<MutateMutationResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .updateMutate(request: request, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func number(
    with request: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionGraphQLSelections
  ) -> Single<ApiResponse<NumberSubscriptionResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .subscribeNumber(request: request, selections: selections)
    )

    return executeGraphQLSubscription(
      resource: resource
    )
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
      .subscribeOn(scheduler)
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
      .subscribeOn(scheduler)
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
      .subscribeOn(scheduler)
  }
}

// MARK: - StarWarsResourceParameters

protocol StarWarsResourceParametersProviding {
  func servicePath(with bodyParameters: StarWarsResourceParameters.BodyParameters) -> String
  func headers(with bodyParameters: StarWarsResourceParameters.BodyParameters) -> [String: String]?
  func timeoutInterval(with bodyParameters: StarWarsResourceParameters.BodyParameters) -> TimeInterval?
  func preventRetry(with bodyParameters: StarWarsResourceParameters.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with bodyParameters: StarWarsResourceParameters.BodyParameters) -> Bool
}

struct StarWarsResourceParameters: ResourceParameters {
  enum BodyParameters {
    case queryHuman(request: HumanStarWarsQuery, selections: HumanStarWarsQueryGraphQLSelections)
    case queryDroid(request: DroidStarWarsQuery, selections: DroidStarWarsQueryGraphQLSelections)
    case queryCharacter(request: CharacterStarWarsQuery, selections: CharacterStarWarsQueryGraphQLSelections)
    case queryLuke(request: LukeStarWarsQuery, selections: LukeStarWarsQueryGraphQLSelections)
    case queryHumans(request: HumansStarWarsQuery, selections: HumansStarWarsQueryGraphQLSelections)
    case queryDroids(request: DroidsStarWarsQuery, selections: DroidsStarWarsQueryGraphQLSelections)
    case queryCharacters(request: CharactersStarWarsQuery, selections: CharactersStarWarsQueryGraphQLSelections)
    case queryGreeting(request: GreetingStarWarsQuery, selections: GreetingStarWarsQueryGraphQLSelections)
    case queryWhoami(request: WhoamiStarWarsQuery, selections: WhoamiStarWarsQueryGraphQLSelections)
    case queryTime(request: TimeStarWarsQuery, selections: TimeStarWarsQueryGraphQLSelections)
    case updateMutate(request: MutateStarWarsMutation, selections: MutateStarWarsMutationGraphQLSelections)
    case subscribeNumber(request: NumberStarWarsSubscription, selections: NumberStarWarsSubscriptionGraphQLSelections)

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
      case let .updateMutate(request, selections):
        return bodyParameters(request: request, selections: selections as GraphQLSelections)
      case let .subscribeNumber(request, selections):
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

  private let provider: StarWarsResourceParametersProviding?
  private let resourceBodyParameters: BodyParameters

  init(
    provider: StarWarsResourceParametersProviding?,
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
