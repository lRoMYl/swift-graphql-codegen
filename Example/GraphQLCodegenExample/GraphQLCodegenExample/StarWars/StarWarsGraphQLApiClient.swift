// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsApiClientImplementing {
  func human(
    with parameters: StarWarsQueries.HumanRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>>
  func droid(
    with parameters: StarWarsQueries.DroidRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Droid>>
  func character(
    with parameters: StarWarsQueries.CharacterRequestParameter
  ) -> Single<ApiResponse<StarWarsUnions.CharacterUnion>>
  func luke(
    with parameters: StarWarsQueries.LukeRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>>
  func humans(
    with parameters: StarWarsQueries.HumansRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>>
  func droids(
    with parameters: StarWarsQueries.DroidsRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Droid>>
  func characters(
    with parameters: StarWarsQueries.CharactersRequestParameter
  ) -> Single<ApiResponse<StarWarsInterfaces.Character>>
  func greeting(
    with parameters: StarWarsQueries.GreetingRequestParameter
  ) -> Single<ApiResponse<String>>
  func whoami(
    with parameters: StarWarsQueries.WhoamiRequestParameter
  ) -> Single<ApiResponse<String>>
  func time(
    with parameters: StarWarsQueries.TimeRequestParameter
  ) -> Single<ApiResponse<String>>
  func mutate(
    with parameters: StarWarsMutations.MutateRequestParameter
  ) -> Single<ApiResponse<Bool>>
  func number(
    with parameters: StarWarsSubscriptions.NumberRequestParameter
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
    with parameters: StarWarsQueries.HumanRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>> {
    let resource = StarWarsResourceParameters
      .queryHuman(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droid(
    with parameters: StarWarsQueries.DroidRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Droid>> {
    let resource = StarWarsResourceParameters
      .queryDroid(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func character(
    with parameters: StarWarsQueries.CharacterRequestParameter
  ) -> Single<ApiResponse<StarWarsUnions.CharacterUnion>> {
    let resource = StarWarsResourceParameters
      .queryCharacter(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func luke(
    with parameters: StarWarsQueries.LukeRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>> {
    let resource = StarWarsResourceParameters
      .queryLuke(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func humans(
    with parameters: StarWarsQueries.HumansRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Human>> {
    let resource = StarWarsResourceParameters
      .queryHumans(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droids(
    with parameters: StarWarsQueries.DroidsRequestParameter
  ) -> Single<ApiResponse<StarWarsObjects.Droid>> {
    let resource = StarWarsResourceParameters
      .queryDroids(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func characters(
    with parameters: StarWarsQueries.CharactersRequestParameter
  ) -> Single<ApiResponse<StarWarsInterfaces.Character>> {
    let resource = StarWarsResourceParameters
      .queryCharacters(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func greeting(
    with parameters: StarWarsQueries.GreetingRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryGreeting(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func whoami(
    with parameters: StarWarsQueries.WhoamiRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryWhoami(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func time(
    with parameters: StarWarsQueries.TimeRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsResourceParameters
      .queryTime(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func mutate(
    with parameters: StarWarsMutations.MutateRequestParameter
  ) -> Single<ApiResponse<Bool>> {
    let resource = StarWarsResourceParameters
      .updateMutate(parameters: parameters)

    return executeGraphQLMutation(resource: resource)
  }

  func number(
    with parameters: StarWarsSubscriptions.NumberRequestParameter
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
    let request: Single<ApiResponse<GraphQLResponse<StarWarsObjects.Query, T>>> = restClient
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
    let request: Single<ApiResponse<GraphQLResponse<StarWarsObjects.Mutation, T>>> = restClient
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
    let request: Single<ApiResponse<GraphQLResponse<StarWarsObjects.Subscription, T>>> = restClient
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

  case queryHuman(parameters: StarWarsQueries.HumanRequestParameter)
  case queryDroid(parameters: StarWarsQueries.DroidRequestParameter)
  case queryCharacter(parameters: StarWarsQueries.CharacterRequestParameter)
  case queryLuke(parameters: StarWarsQueries.LukeRequestParameter)
  case queryHumans(parameters: StarWarsQueries.HumansRequestParameter)
  case queryDroids(parameters: StarWarsQueries.DroidsRequestParameter)
  case queryCharacters(parameters: StarWarsQueries.CharactersRequestParameter)
  case queryGreeting(parameters: StarWarsQueries.GreetingRequestParameter)
  case queryWhoami(parameters: StarWarsQueries.WhoamiRequestParameter)
  case queryTime(parameters: StarWarsQueries.TimeRequestParameter)
  case updateMutate(parameters: StarWarsMutations.MutateRequestParameter)
  case subscribeNumber(parameters: StarWarsSubscriptions.NumberRequestParameter)

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

// MARK: - GraphQLResponse+StarWarsObjects.QueryWrappedValue

extension GraphQLResponse where OperationType == StarWarsObjects.Query {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is StarWarsObjects.Human.Type:
      return data.human as? ReturnType
    case is StarWarsObjects.Droid.Type:
      return data.droid as? ReturnType
    case is StarWarsUnions.CharacterUnion.Type:
      return data.character as? ReturnType
    case is StarWarsObjects.Human.Type:
      return data.luke as? ReturnType
    case is StarWarsObjects.Human.Type:
      return data.humans as? ReturnType
    case is StarWarsObjects.Droid.Type:
      return data.droids as? ReturnType
    case is StarWarsInterfaces.Character.Type:
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

// MARK: - GraphQLResponse+StarWarsObjects.MutationWrappedValue

extension GraphQLResponse where OperationType == StarWarsObjects.Mutation {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Bool.Type:
      return data.mutate as? ReturnType
    default:
      return nil
    }
  }
}

// MARK: - GraphQLResponse+StarWarsObjects.SubscriptionWrappedValue

extension GraphQLResponse where OperationType == StarWarsObjects.Subscription {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Int.Type:
      return data.number as? ReturnType
    default:
      return nil
    }
  }
}
