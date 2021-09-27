// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

protocol BigCommerceGraphQLRepositoring {
  func site(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Site
  ) -> Single<ApiResponse<BigCommerceGraphQL.Site>>
  func customer(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Customer
  ) -> Single<ApiResponse<BigCommerceGraphQL.Customer>>
  func node(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Node
  ) -> Single<ApiResponse<BigCommerceGraphQL.Node>>
  func inventory(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Inventory
  ) -> Single<ApiResponse<BigCommerceGraphQL.Inventory>>
  func login(
    with parameters: BigCommerceGraphQL.MutationRequestParameter.LoginResult
  ) -> Single<ApiResponse<BigCommerceGraphQL.LoginResult>>
  func logout(
    with parameters: BigCommerceGraphQL.MutationRequestParameter.LogoutResult
  ) -> Single<ApiResponse<BigCommerceGraphQL.LogoutResult>>
}

// MARK: - BigCommerceGraphQLRepositoring

final class BigCommerceGraphQLRepository: BigCommerceGraphQLRepositoring {
  private let restClient: RestClient
  private let scheduler: SchedulerType

  init(restClient: RestClient, scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
    self.restClient = restClient
    self.scheduler = scheduler
  }

  func site(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Site
  ) -> Single<ApiResponse<BigCommerceGraphQL.Site>> {
    let resource = BigCommerceGraphQLResourceParameters
      .querySite(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func customer(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Customer
  ) -> Single<ApiResponse<BigCommerceGraphQL.Customer>> {
    let resource = BigCommerceGraphQLResourceParameters
      .queryCustomer(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func node(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Node
  ) -> Single<ApiResponse<BigCommerceGraphQL.Node>> {
    let resource = BigCommerceGraphQLResourceParameters
      .queryNode(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func inventory(
    with parameters: BigCommerceGraphQL.QueryRequestParameter.Inventory
  ) -> Single<ApiResponse<BigCommerceGraphQL.Inventory>> {
    let resource = BigCommerceGraphQLResourceParameters
      .queryInventory(parameters: parameters)

    return executeGraphQLQuery(resource: resource)
  }

  func login(
    with parameters: BigCommerceGraphQL.MutationRequestParameter.LoginResult
  ) -> Single<ApiResponse<BigCommerceGraphQL.LoginResult>> {
    let resource = BigCommerceGraphQLResourceParameters
      .updateLogin(parameters: parameters)

    return executeGraphQLMutation(resource: resource)
  }

  func logout(
    with parameters: BigCommerceGraphQL.MutationRequestParameter.LogoutResult
  ) -> Single<ApiResponse<BigCommerceGraphQL.LogoutResult>> {
    let resource = BigCommerceGraphQLResourceParameters
      .updateLogout(parameters: parameters)

    return executeGraphQLMutation(resource: resource)
  }
}

private extension BigCommerceGraphQLRepository {
  func executeGraphQLQuery<T>(
    resource: ResourceParameters
  ) -> Single<ApiResponse<T>> where T: Codable {
    let request: Single<ApiResponse<GraphQLResponse<BigCommerceGraphQL.Query, T>>> = restClient
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
    let request: Single<ApiResponse<GraphQLResponse<BigCommerceGraphQL.Mutation, T>>> = restClient
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

// MARK: - BigCommerceGraphQLResourceParameters

protocol BigCommerceGraphQLResourceParametersImplementing {
  func servicePath(with resourceParameters: BigCommerceGraphQLResourceParameters) -> String
  func headers(with resourceParameters: BigCommerceGraphQLResourceParameters) -> [String: String]?
  func timeoutInterval(with resourceParameters: BigCommerceGraphQLResourceParameters) -> TimeInterval?
  func preventRetry(with resourceParameters: BigCommerceGraphQLResourceParameters) -> Bool
  func preventAddingLanguageParameters(with resourceParameters: BigCommerceGraphQLResourceParameters) -> Bool
}

final class BigCommerceGraphQLResourceParametersDIContainer {
  static let shared = BigCommerceGraphQLResourceParametersDIContainer()

  var implementation: BigCommerceGraphQLResourceParametersImplementing?
}

enum BigCommerceGraphQLResourceParameters: ResourceParameters {
  private static var diContainer = BigCommerceGraphQLResourceParametersDIContainer.shared

  case querySite(parameters: BigCommerceGraphQL.QueryRequestParameter.Site)
  case queryCustomer(parameters: BigCommerceGraphQL.QueryRequestParameter.Customer)
  case queryNode(parameters: BigCommerceGraphQL.QueryRequestParameter.Node)
  case queryInventory(parameters: BigCommerceGraphQL.QueryRequestParameter.Inventory)
  case updateLogin(parameters: BigCommerceGraphQL.MutationRequestParameter.LoginResult)
  case updateLogout(parameters: BigCommerceGraphQL.MutationRequestParameter.LogoutResult)

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
    case let .querySite(parameters):
      return bodyParameters(parameters: parameters)
    case let .queryCustomer(parameters):
      return bodyParameters(parameters: parameters)
    case let .queryNode(parameters):
      return bodyParameters(parameters: parameters)
    case let .queryInventory(parameters):
      return bodyParameters(parameters: parameters)
    case let .updateLogin(parameters):
      return bodyParameters(parameters: parameters)
    case let .updateLogout(parameters):
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

// MARK: - GraphQLResponse+QueryWrappedValue

extension GraphQLResponse where OperationType == BigCommerceGraphQL.Query {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is BigCommerceGraphQL.Site.Type:
      return data.site as? ReturnType
    case is BigCommerceGraphQL.Customer.Type:
      return data.customer as? ReturnType
    case is BigCommerceGraphQL.Node.Type:
      return data.node as? ReturnType
    case is BigCommerceGraphQL.Inventory.Type:
      return data.inventory as? ReturnType
    default:
      return nil
    }
  }
}

// MARK: - GraphQLResponse+MutationWrappedValue

extension GraphQLResponse where OperationType == BigCommerceGraphQL.Mutation {
  var wrappedValue: ReturnType? {
    switch ReturnType.self {
    case is BigCommerceGraphQL.LoginResult.Type:
      return data.login as? ReturnType
    case is BigCommerceGraphQL.LogoutResult.Type:
      return data.logout as? ReturnType
    default:
      return nil
    }
  }
}
