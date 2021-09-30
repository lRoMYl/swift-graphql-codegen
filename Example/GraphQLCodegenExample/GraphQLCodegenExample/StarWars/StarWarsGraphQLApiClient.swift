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

  init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.restClient = restClient
    self.scheduler = scheduler
  }

  func human(
    with parameters: HumanStarWarsQuery
  ) -> Single<ApiResponse<HumanStarWarsObject?>> {
    let resource = StarWarsResourceParameters
      .queryHuman(parameters: parameters)

    return executeGraphQLQuery(
      responseData: HumanQueryResponse.self,
      resource: resource
    )
  }

  func droid(
    with parameters: DroidStarWarsQuery
  ) -> Single<ApiResponse<DroidStarWarsObject?>> {
    let resource = StarWarsResourceParameters
      .queryDroid(parameters: parameters)

    return executeGraphQLQuery(
      responseData: DroidQueryResponse.self,
      resource: resource
    )
  }

  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<ApiResponse<CharacterUnionStarWarsUnions?>> {
    let resource = StarWarsResourceParameters
      .queryCharacter(parameters: parameters)

    return executeGraphQLQuery(
      responseData: CharacterQueryResponse.self,
      resource: resource
    )
  }

  func luke(
    with parameters: LukeStarWarsQuery
  ) -> Single<ApiResponse<HumanStarWarsObject?>> {
    let resource = StarWarsResourceParameters
      .queryLuke(parameters: parameters)

    return executeGraphQLQuery(
      responseData: LukeQueryResponse.self,
      resource: resource
    )
  }

  func humans(
    with parameters: HumansStarWarsQuery
  ) -> Single<ApiResponse<[HumanStarWarsObject]>> {
    let resource = StarWarsResourceParameters
      .queryHumans(parameters: parameters)

    return executeGraphQLQuery(
      responseData: HumansQueryResponse.self,
      resource: resource
    )
  }

  func droids(
    with parameters: DroidsStarWarsQuery
  ) -> Single<ApiResponse<[DroidStarWarsObject]>> {
    let resource = StarWarsResourceParameters
      .queryDroids(parameters: parameters)

    return executeGraphQLQuery(
      responseData: DroidsQueryResponse.self,
      resource: resource
    )
  }

  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<ApiResponse<[CharacterStarWarsInterface]>> {
    let resource = StarWarsResourceParameters
      .queryCharacters(parameters: parameters)

    return executeGraphQLQuery(
      responseData: CharactersQueryResponse.self,
      resource: resource
    )
  }

  func greeting(
    with parameters: GreetingStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryGreeting(parameters: parameters)

    return executeGraphQLQuery(
      responseData: GreetingQueryResponse.self,
      resource: resource
    )
  }

  func whoami(
    with parameters: WhoamiStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryWhoami(parameters: parameters)

    return executeGraphQLQuery(
      responseData: WhoamiQueryResponse.self,
      resource: resource
    )
  }

  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryTime(parameters: parameters)

    return executeGraphQLQuery(
      responseData: TimeQueryResponse.self,
      resource: resource
    )
  }

  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<ApiResponse<Bool>> {
    let resource = StarWarsResourceParameters
      .updateMutate(parameters: parameters)

    return executeGraphQLMutation(
      responseData: MutateMutationResponse.self,
      resource: resource
    )
  }

  func number(
    with parameters: NumberStarWarsSubscription
  ) -> Single<ApiResponse<Int>> {
    let resource = StarWarsResourceParameters
      .subscribeNumber(parameters: parameters)

    return executeGraphQLSubscription(
      responseData: NumberSubscriptionResponse.self,
      resource: resource
    )
  }
}

private extension StarWarsApiClient {
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

  func executeGraphQLMutation<R, T>(
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

  func executeGraphQLSubscription<R, T>(
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

// MARK: - StarWarsResourceParameters

protocol StarWarsResourceParametersImplementing {
  func servicePath(with resourceParameters: StarWarsResourceParameters) -> String
  func headers(with resourceParameters: StarWarsResourceParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: StarWarsResourceParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: StarWarsResourceParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: StarWarsResourceParameters) -> Bool
}

final class StarWarsResourceParametersDIContainer {
  static let shared = StarWarsResourceParametersDIContainer()

  var implementation: StarWarsResourceParametersImplementing?
}

enum StarWarsResourceParameters: ResourceParameters {
  private static var diContainer = StarWarsResourceParametersDIContainer.shared

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

extension GraphQLResponse where ResponseData == HumanQueryResponse {
  var wrappedValue: ReturnType? {
    return data.human as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == DroidQueryResponse {
  var wrappedValue: ReturnType? {
    return data.droid as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == CharacterQueryResponse {
  var wrappedValue: ReturnType? {
    return data.character as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == LukeQueryResponse {
  var wrappedValue: ReturnType? {
    return data.luke as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == HumansQueryResponse {
  var wrappedValue: ReturnType? {
    return data.humans as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == DroidsQueryResponse {
  var wrappedValue: ReturnType? {
    return data.droids as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == CharactersQueryResponse {
  var wrappedValue: ReturnType? {
    return data.characters as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == GreetingQueryResponse {
  var wrappedValue: ReturnType? {
    return data.greeting as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == WhoamiQueryResponse {
  var wrappedValue: ReturnType? {
    return data.whoami as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == TimeQueryResponse {
  var wrappedValue: ReturnType? {
    return data.time as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == MutateMutationResponse {
  var wrappedValue: ReturnType? {
    return data.mutate as? ReturnType
  }
}

extension GraphQLResponse where ResponseData == NumberSubscriptionResponse {
  var wrappedValue: ReturnType? {
    return data.number as? ReturnType
  }
}
