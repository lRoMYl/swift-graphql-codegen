// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation
import RxSwift
// MARK: - StarWarsApiClientError

enum StarWarsApiClientError: Error, LocalizedError {
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

protocol StarWarsApiClientIntercepting {
  func headers(urlRequest: URLRequest, requestParameter: GraphQLRequestParameter) -> [String: String]?
}

// MARK: - StarWarsApiClient

final class StarWarsApiClient {
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

private extension StarWarsApiClient {
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
            completion(.failure(StarWarsApiClientError.missingSelf))
            return
          }

          guard error == nil else {
            completion(.failure(StarWarsApiClientError.error(error!)))
            return
          }

          guard let responseData = responseData else {
            completion(.failure(StarWarsApiClientError.missingData(context: "Empty response")))
            return
          }

          do {
            let response = try self.jsonDecoder.decode(Response.self, from: responseData)
            completion(.success(response))
          } catch {
            completion(.failure(StarWarsApiClientError.error(error)))
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

// MARK: - StarWarsApi

protocol StarWarsApi {
  @discardableResult
  func query(
    with requestParameter: StarWarsQuery,
    selections: StarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<QueryStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func character(
    with requestParameter: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<CharacterQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func characters(
    with requestParameter: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<CharactersQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func droid(
    with requestParameter: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<DroidQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func droids(
    with requestParameter: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<DroidsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func greeting(
    with requestParameter: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<GreetingQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func human(
    with requestParameter: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<HumanQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func humans(
    with requestParameter: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<HumansQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func luke(
    with requestParameter: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LukeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func time(
    with requestParameter: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<TimeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func whoami(
    with requestParameter: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<WhoamiQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func update(
    with requestParameter: StarWarsMutation,
    selections: StarWarsMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutationStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func mutate(
    with requestParameter: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutateMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func subscribe(
    with requestParameter: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<SubscriptionStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func number(
    with requestParameter: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<NumberSubscriptionResponse>, Error>) -> Void)
  ) -> URLSessionTask
}

extension StarWarsApiClient: StarWarsApi {
  @discardableResult
  func character(
    with requestParameter: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<CharacterQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func characters(
    with requestParameter: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<CharactersQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func droid(
    with requestParameter: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<DroidQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func droids(
    with requestParameter: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<DroidsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func greeting(
    with requestParameter: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<GreetingQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func human(
    with requestParameter: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<HumanQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func humans(
    with requestParameter: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<HumansQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func luke(
    with requestParameter: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<LukeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func time(
    with requestParameter: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<TimeQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func whoami(
    with requestParameter: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<WhoamiQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func query(
    with requestParameter: StarWarsQuery,
    selections: StarWarsQuerySelections,
    completion: @escaping ((Result<GraphQLResponse<QueryStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<QueryStarWarsModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.character, result.data?.character),
            (requestParameter.characters, result.data?.characters),
            (requestParameter.droid, result.data?.droid),
            (requestParameter.droids, result.data?.droids),
            (requestParameter.greeting, result.data?.greeting),
            (requestParameter.human, result.data?.human),
            (requestParameter.humans, result.data?.humans),
            (requestParameter.luke, result.data?.luke),
            (requestParameter.time, result.data?.time),
            (requestParameter.whoami, result.data?.whoami)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw StarWarsApiClientError.missingData(
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
  func mutate(
    with requestParameter: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutateMutationResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func update(
    with requestParameter: StarWarsMutation,
    selections: StarWarsMutationSelections,
    completion: @escaping ((Result<GraphQLResponse<MutationStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<MutationStarWarsModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.mutate, result.data?.mutate)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw StarWarsApiClientError.missingData(
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
  func number(
    with requestParameter: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<NumberSubscriptionResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func subscribe(
    with requestParameter: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections,
    completion: @escaping ((Result<GraphQLResponse<SubscriptionStarWarsModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<SubscriptionStarWarsModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.number, result.data?.number)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw StarWarsApiClientError.missingData(
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

private extension StarWarsApiClient {
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

// MARK: - StarWarsRxApi

protocol StarWarsRxApi {
  func query(
    with requestParameter: StarWarsQuery,
    selections: StarWarsQuerySelections
  ) -> Single<GraphQLResponse<QueryStarWarsModel>>
  func character(
    with requestParameter: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections
  ) -> Single<GraphQLResponse<CharacterQueryResponse>>
  func characters(
    with requestParameter: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections
  ) -> Single<GraphQLResponse<CharactersQueryResponse>>
  func droid(
    with requestParameter: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections
  ) -> Single<GraphQLResponse<DroidQueryResponse>>
  func droids(
    with requestParameter: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections
  ) -> Single<GraphQLResponse<DroidsQueryResponse>>
  func greeting(
    with requestParameter: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections
  ) -> Single<GraphQLResponse<GreetingQueryResponse>>
  func human(
    with requestParameter: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections
  ) -> Single<GraphQLResponse<HumanQueryResponse>>
  func humans(
    with requestParameter: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections
  ) -> Single<GraphQLResponse<HumansQueryResponse>>
  func luke(
    with requestParameter: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections
  ) -> Single<GraphQLResponse<LukeQueryResponse>>
  func time(
    with requestParameter: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections
  ) -> Single<GraphQLResponse<TimeQueryResponse>>
  func whoami(
    with requestParameter: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections
  ) -> Single<GraphQLResponse<WhoamiQueryResponse>>
  func update(
    with requestParameter: StarWarsMutation,
    selections: StarWarsMutationSelections
  ) -> Single<GraphQLResponse<MutationStarWarsModel>>
  func mutate(
    with requestParameter: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections
  ) -> Single<GraphQLResponse<MutateMutationResponse>>
  func subscribe(
    with requestParameter: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections
  ) -> Observable<GraphQLResponse<SubscriptionStarWarsModel>>
  func number(
    with requestParameter: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections
  ) -> Observable<GraphQLResponse<NumberSubscriptionResponse>>
}

extension StarWarsApiClient: StarWarsRxApi {
  func character(
    with requestParameter: CharacterStarWarsQuery,
    selections: CharacterStarWarsQuerySelections
  ) -> Single<GraphQLResponse<CharacterQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func characters(
    with requestParameter: CharactersStarWarsQuery,
    selections: CharactersStarWarsQuerySelections
  ) -> Single<GraphQLResponse<CharactersQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func droid(
    with requestParameter: DroidStarWarsQuery,
    selections: DroidStarWarsQuerySelections
  ) -> Single<GraphQLResponse<DroidQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func droids(
    with requestParameter: DroidsStarWarsQuery,
    selections: DroidsStarWarsQuerySelections
  ) -> Single<GraphQLResponse<DroidsQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func greeting(
    with requestParameter: GreetingStarWarsQuery,
    selections: GreetingStarWarsQuerySelections
  ) -> Single<GraphQLResponse<GreetingQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func human(
    with requestParameter: HumanStarWarsQuery,
    selections: HumanStarWarsQuerySelections
  ) -> Single<GraphQLResponse<HumanQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func humans(
    with requestParameter: HumansStarWarsQuery,
    selections: HumansStarWarsQuerySelections
  ) -> Single<GraphQLResponse<HumansQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func luke(
    with requestParameter: LukeStarWarsQuery,
    selections: LukeStarWarsQuerySelections
  ) -> Single<GraphQLResponse<LukeQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func time(
    with requestParameter: TimeStarWarsQuery,
    selections: TimeStarWarsQuerySelections
  ) -> Single<GraphQLResponse<TimeQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func whoami(
    with requestParameter: WhoamiStarWarsQuery,
    selections: WhoamiStarWarsQuerySelections
  ) -> Single<GraphQLResponse<WhoamiQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func query(
    with requestParameter: StarWarsQuery,
    selections: StarWarsQuerySelections
  ) -> Single<GraphQLResponse<QueryStarWarsModel>> {
    let task: Single<GraphQLResponse<QueryStarWarsModel>> = singleDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.character, result.data?.character),
          (requestParameter.characters, result.data?.characters),
          (requestParameter.droid, result.data?.droid),
          (requestParameter.droids, result.data?.droids),
          (requestParameter.greeting, result.data?.greeting),
          (requestParameter.human, result.data?.human),
          (requestParameter.humans, result.data?.humans),
          (requestParameter.luke, result.data?.luke),
          (requestParameter.time, result.data?.time),
          (requestParameter.whoami, result.data?.whoami)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }

  func mutate(
    with requestParameter: MutateStarWarsMutation,
    selections: MutateStarWarsMutationSelections
  ) -> Single<GraphQLResponse<MutateMutationResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func update(
    with requestParameter: StarWarsMutation,
    selections: StarWarsMutationSelections
  ) -> Single<GraphQLResponse<MutationStarWarsModel>> {
    let task: Single<GraphQLResponse<MutationStarWarsModel>> = singleDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.mutate, result.data?.mutate)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }

  func number(
    with requestParameter: NumberStarWarsSubscription,
    selections: NumberStarWarsSubscriptionSelections
  ) -> Observable<GraphQLResponse<NumberSubscriptionResponse>> {
    observableDataTask(with: requestParameter, selections: selections)
  }

  func subscribe(
    with requestParameter: StarWarsSubscription,
    selections: StarWarsSubscriptionSelections
  ) -> Observable<GraphQLResponse<SubscriptionStarWarsModel>> {
    let task: Observable<GraphQLResponse<SubscriptionStarWarsModel>> = observableDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.number, result.data?.number)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw StarWarsApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }
}