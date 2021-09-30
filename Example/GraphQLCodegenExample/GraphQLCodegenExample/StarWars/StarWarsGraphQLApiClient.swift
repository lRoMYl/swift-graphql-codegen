// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientImplementing {
  func human(
    with parameters: HumanStarWarsQuery
  ) -> Single<ApiResponse<HumanStarWarsObject?>>
  func droid(
    with parameters: DroidStarWarsQuery
  ) -> Single<ApiResponse<DroidStarWarsObject?>>
  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<ApiResponse<CharacterUnionStarWarsUnions?>>
  func luke(
    with parameters: LukeStarWarsQuery
  ) -> Single<ApiResponse<HumanStarWarsObject?>>
  func humans(
    with parameters: HumansStarWarsQuery
  ) -> Single<ApiResponse<[HumanStarWarsObject]>>
  func droids(
    with parameters: DroidsStarWarsQuery
  ) -> Single<ApiResponse<[DroidStarWarsObject]>>
  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<ApiResponse<[CharacterStarWarsInterface]>>
  func greeting(
    with parameters: GreetingStarWarsQuery
  ) -> Single<ApiResponse<String>>
  func whoami(
    with parameters: WhoamiStarWarsQuery
  ) -> Single<ApiResponse<String>>
  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<ApiResponse<String>>
  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<ApiResponse<Bool>>
  func number(
    with parameters: NumberStarWarsSubscription
  ) -> Single<ApiResponse<Int>>
}

// MARK: - StarWarsApiClientImplementing

final class StarWarsApiClient: StarWarsApiClientImplementing {
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
  ) -> Single<ApiResponse<HumanStarWarsObject?>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHuman(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: HumanQueryResponse.self
    )
  }

  func droid(
    with parameters: DroidStarWarsQuery
  ) -> Single<ApiResponse<DroidStarWarsObject?>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroid(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: DroidQueryResponse.self
    )
  }

  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<ApiResponse<CharacterUnionStarWarsUnions?>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacter(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: CharacterQueryResponse.self
    )
  }

  func luke(
    with parameters: LukeStarWarsQuery
  ) -> Single<ApiResponse<HumanStarWarsObject?>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryLuke(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: LukeQueryResponse.self
    )
  }

  func humans(
    with parameters: HumansStarWarsQuery
  ) -> Single<ApiResponse<[HumanStarWarsObject]>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryHumans(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: HumansQueryResponse.self
    )
  }

  func droids(
    with parameters: DroidsStarWarsQuery
  ) -> Single<ApiResponse<[DroidStarWarsObject]>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryDroids(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: DroidsQueryResponse.self
    )
  }

  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<ApiResponse<[CharacterStarWarsInterface]>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryCharacters(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: CharactersQueryResponse.self
    )
  }

  func greeting(
    with parameters: GreetingStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryGreeting(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: GreetingQueryResponse.self
    )
  }

  func whoami(
    with parameters: WhoamiStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryWhoami(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: WhoamiQueryResponse.self
    )
  }

  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .queryTime(parameters: parameters)
    )

    return executeGraphQLQuery(
      resource: resource,
      responseType: TimeQueryResponse.self
    )
  }

  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<ApiResponse<Bool>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .updateMutate(parameters: parameters)
    )

    return executeGraphQLMutation(
      resource: resource,
      responseType: MutateMutationResponse.self
    )
  }

  func number(
    with parameters: NumberStarWarsSubscription
  ) -> Single<ApiResponse<Int>> {
    let resource = StarWarsResourceParameters(
      provider: resourceParametersProvider,
      resourceBodyParameters: .subscribeNumber(parameters: parameters)
    )

    return executeGraphQLSubscription(
      resource: resource,
      responseType: NumberSubscriptionResponse.self
    )
  }
}

private extension StarWarsApiClient {
  func executeGraphQLQuery<Response, ResponseModel>(
    resource: ResourceParameters,
    responseType _: Response.Type
  ) -> Single<ApiResponse<ResponseModel>> where Response: GraphQLResponseData, ResponseModel: Codable {
    let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data?.wrappedValue as? ResponseModel,
          httpURLResponse: apiResponse.httpURLResponse,
          metaData: apiResponse.metaData
        )
      }
      .subscribeOn(scheduler)
  }

  func executeGraphQLMutation<Response, ResponseModel>(
    resource: ResourceParameters,
    responseType _: Response.Type
  ) -> Single<ApiResponse<ResponseModel>> where Response: GraphQLResponseData, ResponseModel: Codable {
    let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data?.wrappedValue as? ResponseModel,
          httpURLResponse: apiResponse.httpURLResponse,
          metaData: apiResponse.metaData
        )
      }
      .subscribeOn(scheduler)
  }

  func executeGraphQLSubscription<Response, ResponseModel>(
    resource: ResourceParameters,
    responseType _: Response.Type
  ) -> Single<ApiResponse<ResponseModel>> where Response: GraphQLResponseData, ResponseModel: Codable {
    let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
      .executeRequest(resource: resource)

    return request
      .map { apiResponse in
        ApiResponse(
          data: apiResponse.data?.wrappedValue as? ResponseModel,
          httpURLResponse: apiResponse.httpURLResponse,
          metaData: apiResponse.metaData
        )
      }
      .subscribeOn(scheduler)
  }
}

// MARK: - StarWarsResourceParameters

protocol StarWarsResourceParametersProviding {
  func servicePath(with resourceParameters: StarWarsResourceBodyParameters) -> String
  func headers(with resourceParameters: StarWarsResourceBodyParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: StarWarsResourceBodyParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: StarWarsResourceBodyParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: StarWarsResourceBodyParameters) -> Bool
}

final class StarWarsResourceParameters: ResourceParameters {
  private let provider: StarWarsResourceParametersProviding?
  private let resourceBodyParameters: StarWarsResourceBodyParameters

  init(
    provider: StarWarsResourceParametersProviding?,
    resourceBodyParameters: StarWarsResourceBodyParameters
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

enum StarWarsResourceBodyParameters {
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
      let data = try? JSONEncoder().encode(GraphQLRequestCodableWrapper(parameters: parameters))
    else { return [:] }

    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
      .flatMap {
        $0 as? [String: Any]
      } ?? [:]
  }
}
