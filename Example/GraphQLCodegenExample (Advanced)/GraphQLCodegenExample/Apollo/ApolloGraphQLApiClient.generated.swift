// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation
import RxSwift
// MARK: - ApolloApiClientError

enum ApolloApiClientError: Error, LocalizedError {
  case missingSelf
  case missingData(context: String)
  case error(Error)
  case unknown(context: String)

  var errorDescription: String? {
    switch self {
    case .missingSelf:
      return "\(Self.self): self is dequeued"
    case let .missingData(context):
      return "\(Self.self): \(context)"
    case let .error(error):
      return "\(Self.self): \(error.localizedDescription)"
    case let .unknown(context):
      return "\(Self.self): \(context)"
    }
  }
}

protocol ApolloApiClientIntercepting {
  func headers(urlRequest: URLRequest, requestParameter: GraphQLRequestParameter) -> [String: String]?
}

// MARK: - ApolloApiClient

final class ApolloApiClient {
  private let baseURL: URL
  private let urlSession: URLSession
  private let jsonEncoder: JSONEncoder
  private let jsonDecoder: JSONDecoder

  private let interceptor: GroceriesApiClientIntercepting?
  private let scheduler: SchedulerType

  init(
    baseURL: URL,
    urlSession: URLSession = .shared,
    jsonEncoder: JSONEncoder = JSONEncoder(),
    jsonDecoder: JSONDecoder = JSONDecoder(),
    interceptor: GroceriesApiClientIntercepting? = nil,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
  ) {
    self.baseURL = baseURL
    self.urlSession = urlSession
    self.jsonEncoder = jsonEncoder
    self.jsonDecoder = jsonDecoder
    self.interceptor = interceptor
    self.scheduler = scheduler
  }
}

// MARK: - Private URLSession Convenient funcs

private extension ApolloApiClient {
  func dataTask<RequestParameter, Response>(
    requestParameter: RequestParameter,
    selections: GraphQLSelections,
    completion: @escaping ((Result<Response, Error>) -> Void)
  ) -> URLSessionTask where RequestParameter: GraphQLRequestParameter, Response: Decodable {
    let task = urlSession
      .dataTask(
        with: urlRequest(with: requestParameter, selections: selections),
        completionHandler: { [weak self] responseData, _, error in
          guard let self = self else {
            completion(.failure(ApolloApiClientError.missingSelf))
            return
          }

          guard error == nil else {
            completion(.failure(ApolloApiClientError.error(error!)))
            return
          }

          guard let responseData = responseData else {
            completion(.failure(ApolloApiClientError.missingData(context: "Empty response")))
            return
          }

          do {
            let response = try self.jsonDecoder.decode(Response.self, from: responseData)
            completion(.success(response))
          } catch {
            completion(.failure(ApolloApiClientError.error(error)))
          }
        }
      )

    return task
  }

  func urlRequest<RequestParameter>(
    with requestParameter: RequestParameter,
    selections: GraphQLSelections
  ) -> URLRequest where RequestParameter: GraphQLRequestParameter {
    var urlRequest = URLRequest(
      url: baseURL,
      cachePolicy: urlSession.configuration.requestCachePolicy,
      timeoutInterval: urlSession.configuration.timeoutIntervalForRequest
    )
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpBody = try? jsonEncoder.encode(
      GraphQLRequest(parameters: requestParameter, selections: selections)
    )

    if let interceptor = interceptor {
      urlRequest.allHTTPHeaderFields = interceptor.headers(
        urlRequest: urlRequest,
        requestParameter: requestParameter
      )
    }

    return urlRequest
  }
}

// MARK: - ApolloApi

protocol ApolloApi {
  @discardableResult
  func query(
    with requestParameter: ApolloQuery,
    selections: ApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<QueryApolloModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func launch(
    with requestParameter: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LaunchQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func launches(
    with requestParameter: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LaunchesQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func me(
    with requestParameter: MeApolloQuery,
    selections: MeApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<MeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func totalTripsBooked(
    with requestParameter: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<TotalTripsBookedQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func update(
    with requestParameter: ApolloMutation,
    selections: ApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutationApolloModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func bookTrips(
    with requestParameter: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<BookTripsMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func cancelTrip(
    with requestParameter: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<CancelTripMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func login(
    with requestParameter: LoginApolloMutation,
    selections: LoginApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<LoginMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func subscribe(
    with requestParameter: ApolloSubscription,
    selections: ApolloSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<SubscriptionApolloModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func tripsBooked(
    with requestParameter: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<TripsBookedSubscriptionResponse>, Error>) -> Void)
  ) -> URLSessionTask
}

extension ApolloApiClient: ApolloApi {
  @discardableResult
  func launch(
    with requestParameter: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LaunchQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func launches(
    with requestParameter: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LaunchesQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func me(
    with requestParameter: MeApolloQuery,
    selections: MeApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<MeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func totalTripsBooked(
    with requestParameter: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<TotalTripsBookedQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func query(
    with requestParameter: ApolloQuery,
    selections: ApolloQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<QueryApolloModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<QueryApolloModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.launch, result.data?.launch),
            (requestParameter.launches, result.data?.launches),
            (requestParameter.me, result.data?.me),
            (requestParameter.totalTripsBooked, result.data?.totalTripsBooked)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw ApolloApiClientError.missingData(
                context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
              )
            }
          }
        } catch {
          completion(.failure(error))
        }
      case .failure:
        completion(result)
      }
    }

    return dataTask(
      requestParameter: requestParameter,
      selections: selections,
      completion: completion
    )
  }

  @discardableResult
  func bookTrips(
    with requestParameter: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<BookTripsMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func cancelTrip(
    with requestParameter: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<CancelTripMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func login(
    with requestParameter: LoginApolloMutation,
    selections: LoginApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<LoginMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func update(
    with requestParameter: ApolloMutation,
    selections: ApolloMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutationApolloModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<MutationApolloModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.bookTrips, result.data?.bookTrips),
            (requestParameter.cancelTrip, result.data?.cancelTrip),
            (requestParameter.login, result.data?.login)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw ApolloApiClientError.missingData(
                context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
              )
            }
          }
        } catch {
          completion(.failure(error))
        }
      case .failure:
        completion(result)
      }
    }

    return dataTask(
      requestParameter: requestParameter,
      selections: selections,
      completion: completion
    )
  }

  @discardableResult
  func tripsBooked(
    with requestParameter: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<TripsBookedSubscriptionResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func subscribe(
    with requestParameter: ApolloSubscription,
    selections: ApolloSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<SubscriptionApolloModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<SubscriptionApolloModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.tripsBooked, result.data?.tripsBooked)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw ApolloApiClientError.missingData(
                context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
              )
            }
          }
        } catch {
          completion(.failure(error))
        }
      case .failure:
        completion(result)
      }
    }

    return dataTask(
      requestParameter: requestParameter,
      selections: selections,
      completion: completion
    )
  }
}

// MARK: - Private RxSwift Convenient funcs

private extension ApolloApiClient {
  func singleDataTask<RequestParameter, Response>(
    with requestParameter: RequestParameter,
    selections: GraphQLSelections
  ) -> Single<Response> where RequestParameter: GraphQLRequestParameter, Response: Decodable {
    Single.create { single in
      let task = self.dataTask(
        requestParameter: requestParameter,
        selections: selections
      ) { (result: Result<Response, Error>) in
        switch result {
        case let .success(response):
          single(.success(response))
        case let .failure(error):
          single(.failure(error))
        }
      }

      task.resume()

      return Disposables.create {
        task.cancel()
      }
    }
  }

  func observableDataTask<RequestParameter, Response>(
    with requestParameter: RequestParameter,
    selections: GraphQLSelections
  ) -> Observable<Response> where RequestParameter: GraphQLRequestParameter, Response: Decodable {
    Observable.create { observer in
      let task = self.dataTask(
        requestParameter: requestParameter,
        selections: selections
      ) { (result: Result<Response, Error>) in
        switch result {
        case let .success(response):
          observer.onNext(response)
        case let .failure(error):
          observer.onError(error)
        }

        observer.onCompleted()
      }

      task.resume()

      return Disposables.create {
        task.cancel()
      }
    }
  }
}

// MARK: - ApolloRxApi

protocol ApolloRxApi {
  func query(
    with requestParameter: ApolloQuery,
    selections: ApolloQuerySelections
  ) -> Single<GraphQLResponse<QueryApolloModel>>
  func launch(
    with requestParameter: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections
  ) -> Single<GraphQLResponse<LaunchQueryResponse>>
  func launches(
    with requestParameter: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections
  ) -> Single<GraphQLResponse<LaunchesQueryResponse>>
  func me(
    with requestParameter: MeApolloQuery,
    selections: MeApolloQuerySelections
  ) -> Single<GraphQLResponse<MeQueryResponse>>
  func totalTripsBooked(
    with requestParameter: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections
  ) -> Single<GraphQLResponse<TotalTripsBookedQueryResponse>>
  func update(
    with requestParameter: ApolloMutation,
    selections: ApolloMutationSelections
  ) -> Single<GraphQLResponse<MutationApolloModel>>
  func bookTrips(
    with requestParameter: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections
  ) -> Single<GraphQLResponse<BookTripsMutationResponse>>
  func cancelTrip(
    with requestParameter: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections
  ) -> Single<GraphQLResponse<CancelTripMutationResponse>>
  func login(
    with requestParameter: LoginApolloMutation,
    selections: LoginApolloMutationSelections
  ) -> Single<GraphQLResponse<LoginMutationResponse>>
  func subscribe(
    with requestParameter: ApolloSubscription,
    selections: ApolloSubscriptionSelections
  ) -> Observable<GraphQLResponse<SubscriptionApolloModel>>
  func tripsBooked(
    with requestParameter: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections
  ) -> Observable<GraphQLResponse<TripsBookedSubscriptionResponse>>
}

extension ApolloApiClient: ApolloRxApi {
  func launch(
    with requestParameter: LaunchApolloQuery,
    selections: LaunchApolloQuerySelections
  ) -> Single<GraphQLResponse<LaunchQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func launches(
    with requestParameter: LaunchesApolloQuery,
    selections: LaunchesApolloQuerySelections
  ) -> Single<GraphQLResponse<LaunchesQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func me(
    with requestParameter: MeApolloQuery,
    selections: MeApolloQuerySelections
  ) -> Single<GraphQLResponse<MeQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func totalTripsBooked(
    with requestParameter: TotalTripsBookedApolloQuery,
    selections: TotalTripsBookedApolloQuerySelections
  ) -> Single<GraphQLResponse<TotalTripsBookedQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func query(
    with requestParameter: ApolloQuery,
    selections: ApolloQuerySelections
  ) -> Single<GraphQLResponse<QueryApolloModel>> {
    let task: Single<GraphQLResponse<QueryApolloModel>> = singleDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.launch, result.data?.launch),
          (requestParameter.launches, result.data?.launches),
          (requestParameter.me, result.data?.me),
          (requestParameter.totalTripsBooked, result.data?.totalTripsBooked)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }

  func bookTrips(
    with requestParameter: BookTripsApolloMutation,
    selections: BookTripsApolloMutationSelections
  ) -> Single<GraphQLResponse<BookTripsMutationResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func cancelTrip(
    with requestParameter: CancelTripApolloMutation,
    selections: CancelTripApolloMutationSelections
  ) -> Single<GraphQLResponse<CancelTripMutationResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func login(
    with requestParameter: LoginApolloMutation,
    selections: LoginApolloMutationSelections
  ) -> Single<GraphQLResponse<LoginMutationResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func update(
    with requestParameter: ApolloMutation,
    selections: ApolloMutationSelections
  ) -> Single<GraphQLResponse<MutationApolloModel>> {
    let task: Single<GraphQLResponse<MutationApolloModel>> = singleDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.bookTrips, result.data?.bookTrips),
          (requestParameter.cancelTrip, result.data?.cancelTrip),
          (requestParameter.login, result.data?.login)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }

  func tripsBooked(
    with requestParameter: TripsBookedApolloSubscription,
    selections: TripsBookedApolloSubscriptionSelections
  ) -> Observable<GraphQLResponse<TripsBookedSubscriptionResponse>> {
    observableDataTask(with: requestParameter, selections: selections)
  }

  func subscribe(
    with requestParameter: ApolloSubscription,
    selections: ApolloSubscriptionSelections
  ) -> Observable<GraphQLResponse<SubscriptionApolloModel>> {
    let task: Observable<GraphQLResponse<SubscriptionApolloModel>> = observableDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.tripsBooked, result.data?.tripsBooked)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw ApolloApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }
}