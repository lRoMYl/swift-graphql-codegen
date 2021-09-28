// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol StarWarsGraphQLRepositoring {
  func human(
    with parameters: StarWarsGraphQLQueries.HumanRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>>
  func droid(
    with parameters: StarWarsGraphQLQueries.DroidRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Droid>>
  func character(
    with parameters: StarWarsGraphQLQueries.CharacterRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLUnions.CharacterUnion>>
  func luke(
    with parameters: StarWarsGraphQLQueries.LukeRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>>
  func humans(
    with parameters: StarWarsGraphQLQueries.HumansRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>>
  func droids(
    with parameters: StarWarsGraphQLQueries.DroidsRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Droid>>
  func characters(
    with parameters: StarWarsGraphQLQueries.CharactersRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLInterfaces.Character>>
  func greeting(
    with parameters: StarWarsGraphQLQueries.GreetingRequestParameter
  ) -> Single<ApiResponse<String>>
  func whoami(
    with parameters: StarWarsGraphQLQueries.WhoamiRequestParameter
  ) -> Single<ApiResponse<String>>
  func time(
    with parameters: StarWarsGraphQLQueries.TimeRequestParameter
  ) -> Single<ApiResponse<String>>
  func mutate(
    with parameters: StarWarsGraphQLMutations.MutateRequestParameter
  ) -> Single<ApiResponse<Bool>>
  func number(
    with parameters: StarWarsGraphQLSubscriptions.NumberRequestParameter
  ) -> Single<ApiResponse<Int>>
}

// MARK: - StarWarsGraphQLRepositoring

final class StarWarsGraphQLRepository: StarWarsGraphQLRepositoring {
  private let restClient: RestClient
  private let scheduler: SchedulerType

  init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.restClient = restClient
    self.scheduler = scheduler
  }

  func human(
    with parameters: StarWarsGraphQLQueries.HumanRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryHuman(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droid(
    with parameters: StarWarsGraphQLQueries.DroidRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Droid>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryDroid(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func character(
    with parameters: StarWarsGraphQLQueries.CharacterRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLUnions.CharacterUnion>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryCharacter(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func luke(
    with parameters: StarWarsGraphQLQueries.LukeRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryLuke(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func humans(
    with parameters: StarWarsGraphQLQueries.HumansRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Human>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryHumans(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func droids(
    with parameters: StarWarsGraphQLQueries.DroidsRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLObjects.Droid>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryDroids(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func characters(
    with parameters: StarWarsGraphQLQueries.CharactersRequestParameter
  ) -> Single<ApiResponse<StarWarsGraphQLInterfaces.Character>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryCharacters(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func greeting(
    with parameters: StarWarsGraphQLQueries.GreetingRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryGreeting(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func whoami(
    with parameters: StarWarsGraphQLQueries.WhoamiRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryWhoami(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func time(
    with parameters: StarWarsGraphQLQueries.TimeRequestParameter
  ) -> Single<ApiResponse<String>> {
    let resource = StarWarsGraphQLResourceParameters
      .queryTime(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func mutate(
    with parameters: StarWarsGraphQLMutations.MutateRequestParameter
  ) -> Single<ApiResponse<Bool>> {
    let resource = StarWarsGraphQLResourceParameters
      .updateMutate(parameters: parameters)

    return executeGraphQLMutation(resource: resource)
  }

  func number(
    with parameters: StarWarsGraphQLSubscriptions.NumberRequestParameter
  ) -> Single<ApiResponse<Int>> {
    let resource = StarWarsGraphQLResourceParameters
      .subscribeNumber(parameters: parameters)

    return executeGraphQLSubscription(resource: resource)
  }
}

private extension StarWarsGraphQLRepository {
  func executeGraphQLQuery<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<StarWarsGraphQLObjects.Query, T>>> = restClient
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
    let request: Single<ApiResponse<GraphQLResponse<StarWarsGraphQLObjects.Mutation, T>>> = restClient
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
    let request: Single<ApiResponse<GraphQLResponse<StarWarsGraphQLObjects.Subscription, T>>> = restClient
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

// MARK: - StarWarsGraphQLResourceParameters

protocol StarWarsGraphQLResourceParametersImplementing {
  func servicePath(with resourceParameters: StarWarsGraphQLResourceParameters) -> String
  func headers(with resourceParameters: StarWarsGraphQLResourceParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: StarWarsGraphQLResourceParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: StarWarsGraphQLResourceParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: StarWarsGraphQLResourceParameters) -> Bool
}

final class StarWarsGraphQLResourceParametersDIContainer {
  static let shared = StarWarsGraphQLResourceParametersDIContainer()

  var implementation: StarWarsGraphQLResourceParametersImplementing?
}

enum StarWarsGraphQLResourceParameters: ResourceParameters {
  private static var diContainer = StarWarsGraphQLResourceParametersDIContainer.shared

  case queryHuman(parameters: StarWarsGraphQLQueries.HumanRequestParameter)
  case queryDroid(parameters: StarWarsGraphQLQueries.DroidRequestParameter)
  case queryCharacter(parameters: StarWarsGraphQLQueries.CharacterRequestParameter)
  case queryLuke(parameters: StarWarsGraphQLQueries.LukeRequestParameter)
  case queryHumans(parameters: StarWarsGraphQLQueries.HumansRequestParameter)
  case queryDroids(parameters: StarWarsGraphQLQueries.DroidsRequestParameter)
  case queryCharacters(parameters: StarWarsGraphQLQueries.CharactersRequestParameter)
  case queryGreeting(parameters: StarWarsGraphQLQueries.GreetingRequestParameter)
  case queryWhoami(parameters: StarWarsGraphQLQueries.WhoamiRequestParameter)
  case queryTime(parameters: StarWarsGraphQLQueries.TimeRequestParameter)
  case updateMutate(parameters: StarWarsGraphQLMutations.MutateRequestParameter)
  case subscribeNumber(parameters: StarWarsGraphQLSubscriptions.NumberRequestParameter)

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

// MARK: - GraphQLResponse+StarWarsGraphQLObjects.QueryWrappedValue

extension GraphQLResponse where OperationType == StarWarsGraphQLObjects.Query {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is StarWarsGraphQLObjects.Human.Type:
      return data.human as? ReturnType
    case is StarWarsGraphQLObjects.Droid.Type:
      return data.droid as? ReturnType
    case is StarWarsGraphQLUnions.CharacterUnion.Type:
      return data.character as? ReturnType
    case is StarWarsGraphQLObjects.Human.Type:
      return data.luke as? ReturnType
    case is StarWarsGraphQLObjects.Human.Type:
      return data.humans as? ReturnType
    case is StarWarsGraphQLObjects.Droid.Type:
      return data.droids as? ReturnType
    case is StarWarsGraphQLInterfaces.Character.Type:
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

// MARK: - GraphQLResponse+StarWarsGraphQLObjects.MutationWrappedValue

extension GraphQLResponse where OperationType == StarWarsGraphQLObjects.Mutation {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Bool.Type:
      return data.mutate as? ReturnType
    default:
      return nil
    }
  }
}

// MARK: - GraphQLResponse+StarWarsGraphQLObjects.SubscriptionWrappedValue

extension GraphQLResponse where OperationType == StarWarsGraphQLObjects.Subscription {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is Int.Type:
      return data.number as? ReturnType
    default:
      return nil
    }
  }
}
