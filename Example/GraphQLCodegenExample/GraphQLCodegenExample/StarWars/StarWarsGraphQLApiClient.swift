// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientImplementing {
  func human(
    with parameters: HumanStarWarsQueries
  ) -> Single<ApiResponse<HumanStarWarsObjects?>>
  func droid(
    with parameters: DroidStarWarsQueries
  ) -> Single<ApiResponse<DroidStarWarsObjects?>>
  func character(
    with parameters: CharacterStarWarsQueries
  ) -> Single<ApiResponse<CharacterUnionStarWarsUnions?>>
  func luke(
    with parameters: LukeStarWarsQueries
  ) -> Single<ApiResponse<HumanStarWarsObjects?>>
  func humans(
    with parameters: HumansStarWarsQueries
  ) -> Single<ApiResponse<[HumanStarWarsObjects]>>
  func droids(
    with parameters: DroidsStarWarsQueries
  ) -> Single<ApiResponse<[DroidStarWarsObjects]>>
  func characters(
    with parameters: CharactersStarWarsQueries
  ) -> Single<ApiResponse<[CharacterStarWarsInterfaces]>>
  func greeting(
    with parameters: GreetingStarWarsQueries
  ) -> Single<ApiResponse<String>>
  func whoami(
    with parameters: WhoamiStarWarsQueries
  ) -> Single<ApiResponse<String>>
  func time(
    with parameters: TimeStarWarsQueries
  ) -> Single<ApiResponse<String>>
  func mutate(
    with parameters: MutateStarWarsMutations
  ) -> Single<ApiResponse<Bool>>
  func number(
    with parameters: NumberStarWarsSubscriptions
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
    with parameters: HumanStarWarsQueries
  ) -> Single<ApiResponse<HumanStarWarsObjects?>> {
    let resource = StarWarsResourceParameters
      .queryHuman(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droid(
    with parameters: DroidStarWarsQueries
  ) -> Single<ApiResponse<DroidStarWarsObjects?>> {
    let resource = StarWarsResourceParameters
      .queryDroid(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func character(
    with parameters: CharacterStarWarsQueries
  ) -> Single<ApiResponse<CharacterUnionStarWarsUnions?>> {
    let resource = StarWarsResourceParameters
      .queryCharacter(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func luke(
    with parameters: LukeStarWarsQueries
  ) -> Single<ApiResponse<HumanStarWarsObjects?>> {
    let resource = StarWarsResourceParameters
      .queryLuke(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func humans(
    with parameters: HumansStarWarsQueries
  ) -> Single<ApiResponse<[HumanStarWarsObjects]>> {
    let resource = StarWarsResourceParameters
      .queryHumans(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droids(
    with parameters: DroidsStarWarsQueries
  ) -> Single<ApiResponse<[DroidStarWarsObjects]>> {
    let resource = StarWarsResourceParameters
      .queryDroids(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func characters(
    with parameters: CharactersStarWarsQueries
  ) -> Single<ApiResponse<[CharacterStarWarsInterfaces]>> {
    let resource = StarWarsResourceParameters
      .queryCharacters(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func greeting(
    with parameters: GreetingStarWarsQueries
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryGreeting(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func whoami(
    with parameters: WhoamiStarWarsQueries
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryWhoami(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func time(
    with parameters: TimeStarWarsQueries
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryTime(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func mutate(
    with parameters: MutateStarWarsMutations
  ) -> Single<ApiResponse<Bool>> {
    let resource = StarWarsResourceParameters
      .updateMutate(parameters: parameters)

    return executeGraphQLMutation(resource: resource)
  }

  func number(
    with parameters: NumberStarWarsSubscriptions
  ) -> Single<ApiResponse<Int>> {
    let resource = StarWarsResourceParameters
      .subscribeNumber(parameters: parameters)

    return executeGraphQLSubscription(resource: resource)
  }
}

private extension StarWarsApiClient {
  func executeGraphQLQuery<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<QueryStarWarsObjects, T>>> = restClient
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

  func executeGraphQLMutation<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<MutationStarWarsObjects, T>>> = restClient
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

  func executeGraphQLSubscription<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<SubscriptionStarWarsObjects, T>>> = restClient
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

  case queryHuman(parameters: HumanStarWarsQueries)
  case queryDroid(parameters: DroidStarWarsQueries)
  case queryCharacter(parameters: CharacterStarWarsQueries)
  case queryLuke(parameters: LukeStarWarsQueries)
  case queryHumans(parameters: HumansStarWarsQueries)
  case queryDroids(parameters: DroidsStarWarsQueries)
  case queryCharacters(parameters: CharactersStarWarsQueries)
  case queryGreeting(parameters: GreetingStarWarsQueries)
  case queryWhoami(parameters: WhoamiStarWarsQueries)
  case queryTime(parameters: TimeStarWarsQueries)
  case updateMutate(parameters: MutateStarWarsMutations)
  case subscribeNumber(parameters: NumberStarWarsSubscriptions)

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

// MARK: - GraphQLResponse+QueryStarWarsObjectsWrappedValue

extension GraphQLResponse where OperationType == QueryStarWarsObjects {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is HumanStarWarsObjects?.Type:
      return data.human as? ReturnType
    case is DroidStarWarsObjects?.Type:
      return data.droid as? ReturnType
    case is CharacterUnionStarWarsUnions?.Type:
      return data.character as? ReturnType
    case is HumanStarWarsObjects?.Type:
      return data.luke as? ReturnType
    case is [HumanStarWarsObjects].Type:
      return data.humans as? ReturnType
    case is [DroidStarWarsObjects].Type:
      return data.droids as? ReturnType
    case is [CharacterStarWarsInterfaces].Type:
      return data.characters as? ReturnType
    case is String.Type:
      return data.greeting as? ReturnType
    case is String.Type:
      return data.whoami as? ReturnType
    case is String.Type:
      return data.time as? ReturnType
    default:
      return nil
    }
  }
}

// MARK: - GraphQLResponse+MutationStarWarsObjectsWrappedValue

extension GraphQLResponse where OperationType == MutationStarWarsObjects {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Bool.Type:
      return data.mutate as? ReturnType
    default:
      return nil
    }
  }
}

// MARK: - GraphQLResponse+SubscriptionStarWarsObjectsWrappedValue

extension GraphQLResponse where OperationType == SubscriptionStarWarsObjects {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Int.Type:
      return data.number as? ReturnType
    default:
      return nil
    }
  }
}
