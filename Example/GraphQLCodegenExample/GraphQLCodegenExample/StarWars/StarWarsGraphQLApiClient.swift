// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientProtocol {
  func human(
    with parameters: HumanStarWarsQuery
  ) -> Single<ApiResponse<HumanQueryResponse>>
  func droid(
    with parameters: DroidStarWarsQuery
  ) -> Single<ApiResponse<DroidQueryResponse>>
  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<ApiResponse<CharacterQueryResponse>>
  func luke(
    with parameters: LukeStarWarsQuery
  ) -> Single<ApiResponse<LukeQueryResponse>>
  func humans(
    with parameters: HumansStarWarsQuery
  ) -> Single<ApiResponse<HumansQueryResponse>>
  func droids(
    with parameters: DroidsStarWarsQuery
  ) -> Single<ApiResponse<DroidsQueryResponse>>
  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<ApiResponse<CharactersQueryResponse>>
  func greeting(
    with parameters: GreetingStarWarsQuery
  ) -> Single<ApiResponse<GreetingQueryResponse>>
  func whoami(
    with parameters: WhoamiStarWarsQuery
  ) -> Single<ApiResponse<WhoamiQueryResponse>>
  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<ApiResponse<TimeQueryResponse>>
  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<ApiResponse<MutateMutationResponse>>
  func number(
    with parameters: NumberStarWarsSubscription
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
    with parameters: HumanStarWarsQuery
  ) -> Single<ApiResponse<HumanQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHuman(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droid(
    with parameters: DroidStarWarsQuery
  ) -> Single<ApiResponse<DroidQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroid(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<ApiResponse<CharacterQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacter(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func luke(
    with parameters: LukeStarWarsQuery
  ) -> Single<ApiResponse<LukeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryLuke(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func humans(
    with parameters: HumansStarWarsQuery
  ) -> Single<ApiResponse<HumansQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHumans(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func droids(
    with parameters: DroidsStarWarsQuery
  ) -> Single<ApiResponse<DroidsQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroids(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<ApiResponse<CharactersQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacters(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func greeting(
    with parameters: GreetingStarWarsQuery
  ) -> Single<ApiResponse<GreetingQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryGreeting(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func whoami(
    with parameters: WhoamiStarWarsQuery
  ) -> Single<ApiResponse<WhoamiQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryWhoami(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<ApiResponse<TimeQueryResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryTime(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource
    )
  }

  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<ApiResponse<MutateMutationResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .updateMutate(parameters: parameters)
    )

    return executeGraphQLMutation(
      resource: resource
    )
  }

  func number(
    with parameters: NumberStarWarsSubscription
  ) -> Single<ApiResponse<NumberSubscriptionResponse>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .subscribeNumber(parameters: parameters)
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
    case queryHuman(parameters: HumanStarWarsQuery)
    case queryDroid(parameters: DroidStarWarsQuery)
    case queryCharacter(parameters: CharacterStarWarsQuery)
    case queryLuke(parameters: LukeStarWarsQuery)
    case queryHumans(parameters: HumansStarWarsQuery)
    case queryDroids(parameters: DroidsStarWarsQuery)
    case queryCharacters(parameters: CharactersStarWarsQuery)
    case queryGreeting(parameters: GreetingStarWarsQuery)
    case queryWhoami(parameters: WhoamiStarWarsQuery)
    case queryTime(parameters: TimeStarWarsQuery)
    case updateMutate(parameters: MutateStarWarsMutation)
    case subscribeNumber(parameters: NumberStarWarsSubscription)

    func bodyParameters() -> Any? {
      switch self {
      case let .queryHuman(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryDroid(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryCharacter(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryLuke(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryHumans(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryDroids(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryCharacters(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryGreeting(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryWhoami(parameters):
        return bodyParameters(parameters: parameters)
      case let .queryTime(parameters):
        return bodyParameters(parameters: parameters)
      case let .updateMutate(parameters):
        return bodyParameters(parameters: parameters)
      case let .subscribeNumber(parameters):
        return bodyParameters(parameters: parameters)
      }
    }

    private func bodyParameters<T>(parameters: T) -> [String: Any] where T: GraphQLRequesting {
      guard
        let data = try? JSONEncoder().encode(GraphQLRequest(parameters: parameters))
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
