// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientProtocol {
  func human(
    with parameters: HumanStarWarsQuery,
    selections: HumanStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumanQueryResponse>>
  func droid(
    with parameters: DroidStarWarsQuery,
    selections: DroidStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidQueryResponse>>
  func character(
    with parameters: CharacterStarWarsQuery,
    selections: CharacterStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharacterQueryResponse>>
  func luke(
    with parameters: LukeStarWarsQuery,
    selections: LukeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<LukeQueryResponse>>
  func humans(
    with parameters: HumansStarWarsQuery,
    selections: HumansStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumansQueryResponse>>
  func droids(
    with parameters: DroidsStarWarsQuery,
    selections: DroidsStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidsQueryResponse>>
  func characters(
    with parameters: CharactersStarWarsQuery,
    selections: CharactersStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharactersQueryResponse>>
  func greeting(
    with parameters: GreetingStarWarsQuery,
    selections: GreetingStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<GreetingQueryResponse>>
  func whoami(
    with parameters: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>>
  func time(
    with parameters: TimeStarWarsQuery,
    selections: TimeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<TimeQueryResponse>>
  func mutate(
    with parameters: MutateStarWarsMutation,
    selections: MutateStarWarsMutationGraphQLSelections
  ) -> Single<ApiResponse<MutateMutationResponse>>
  func number(
    with parameters: NumberStarWarsSubscription,
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
    resourceParametersProvider: StarWarsResourceParametersProviding?
  ) {
    self.restClient = restClient
    self.scheduler = scheduler
    self.resourceParametersProvider = resourceParametersProvider
  }

  func human(
    with parameters: HumanStarWarsQuery,
    selections: HumanStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumanQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHuman(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droid(
    with parameters: DroidStarWarsQuery,
    selections: DroidStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroid(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func character(
    with parameters: CharacterStarWarsQuery,
    selections: CharacterStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharacterQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacter(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func luke(
    with parameters: LukeStarWarsQuery,
    selections: LukeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<LukeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryLuke(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func humans(
    with parameters: HumansStarWarsQuery,
    selections: HumansStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<HumansQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHumans(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droids(
    with parameters: DroidsStarWarsQuery,
    selections: DroidsStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<DroidsQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroids(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func characters(
    with parameters: CharactersStarWarsQuery,
    selections: CharactersStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<CharactersQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacters(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func greeting(
    with parameters: GreetingStarWarsQuery,
    selections: GreetingStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<GreetingQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryGreeting(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func whoami(
    with parameters: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<WhoamiQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryWhoami(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func time(
    with parameters: TimeStarWarsQuery,
    selections: TimeStarWarsQueryGraphQLSelections
  ) -> Single<ApiResponse<TimeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryTime(parameters: parameters, selections: selections)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func mutate(
    with parameters: MutateStarWarsMutation,
    selections: MutateStarWarsMutationGraphQLSelections
  ) -> Single<ApiResponse<MutateMutationResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .updateMutate(parameters: parameters, selections: selections)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func number(
    with parameters: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionGraphQLSelections
  ) -> Single<ApiResponse<NumberSubscriptionResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .subscribeNumber(parameters: parameters, selections: selections)
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
  func servicePath(with resourceParameters: StarWarsResourceParameters.BodyParameters) -> String
  func headers(with resourceParameters: StarWarsResourceParameters.BodyParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: StarWarsResourceParameters.BodyParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: StarWarsResourceParameters.BodyParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: StarWarsResourceParameters.BodyParameters) -> Bool
}

struct StarWarsResourceParameters: ResourceParameters {
  enum BodyParameters {
    case queryHuman(parameters: HumanStarWarsQuery, selections: HumanStarWarsQueryGraphQLSelections)
    case queryDroid(parameters: DroidStarWarsQuery, selections: DroidStarWarsQueryGraphQLSelections)
    case queryCharacter(parameters: CharacterStarWarsQuery, selections: CharacterStarWarsQueryGraphQLSelections)
    case queryLuke(parameters: LukeStarWarsQuery, selections: LukeStarWarsQueryGraphQLSelections)
    case queryHumans(parameters: HumansStarWarsQuery, selections: HumansStarWarsQueryGraphQLSelections)
    case queryDroids(parameters: DroidsStarWarsQuery, selections: DroidsStarWarsQueryGraphQLSelections)
    case queryCharacters(parameters: CharactersStarWarsQuery, selections: CharactersStarWarsQueryGraphQLSelections)
    case queryGreeting(parameters: GreetingStarWarsQuery, selections: GreetingStarWarsQueryGraphQLSelections)
    case queryWhoami(parameters: WhoamiStarWarsQuery, selections: WhoamiStarWarsQueryGraphQLSelections)
    case queryTime(parameters: TimeStarWarsQuery, selections: TimeStarWarsQueryGraphQLSelections)
    case updateMutate(parameters: MutateStarWarsMutation, selections: MutateStarWarsMutationGraphQLSelections)
    case subscribeNumber(parameters: NumberStarWarsSubscription, selections: NumberStarWarsSubscriptionGraphQLSelections)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryHuman(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryDroid(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryCharacter(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryLuke(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryHumans(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryDroids(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryCharacters(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryGreeting(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryWhoami(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .queryTime(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .updateMutate(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      case let .subscribeNumber(parameters, selections):
        return bodyParameters(parameters: parameters, selections: selections as GraphQLSelections)
      }
    }

    private func bodyParameters<T>(parameters: T, selections: GraphQLSelections) -> [String: Any] where T: GraphQLRequesting {
      guard
        let data = try? JSONEncoder().encode(GraphQLRequest(parameters: parameters, selections: selections))
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
