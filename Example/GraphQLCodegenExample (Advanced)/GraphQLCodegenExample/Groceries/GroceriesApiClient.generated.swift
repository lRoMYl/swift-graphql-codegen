// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation
import RxSwift
// MARK: - GroceriesApiClientError

enum GroceriesApiClientError: Error, LocalizedError {
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

protocol GroceriesApiClientIntercepting {
  func headers(urlRequest: URLRequest, requestParameter: GraphQLRequestParameter) -> [String: String]?
}

// MARK: - GroceriesApiClient

final class GroceriesApiClient {
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

private extension GroceriesApiClient {
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
            completion(.failure(GroceriesApiClientError.missingSelf))
            return
          }

          guard error == nil else {
            completion(.failure(GroceriesApiClientError.error(error!)))
            return
          }

          guard let responseData = responseData else {
            completion(.failure(GroceriesApiClientError.missingData(context: "Empty response")))
            return
          }

          do {
            let response = try self.jsonDecoder.decode(Response.self, from: responseData)
            completion(.success(response))
          } catch {
            completion(.failure(GroceriesApiClientError.error(error)))
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

// MARK: - GroceriesApi

protocol GroceriesApi {
  @discardableResult
  func query(
    with requestParameter: QueryRequest,
    selections: QueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<QueryResponseModel>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func campaigns(
    with requestParameter: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<CampaignsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func productDetails(
    with requestParameter: ProductDetailsQueryRequest,
    selections: ProductDetailsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ProductDetailsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func products(
    with requestParameter: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ProductsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
  @discardableResult
  func shopDetails(
    with requestParameter: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ShopDetailsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask
}

extension GroceriesApiClient: GroceriesApi {
  @discardableResult
  func campaigns(
    with requestParameter: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<CampaignsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func productDetails(
    with requestParameter: ProductDetailsQueryRequest,
    selections: ProductDetailsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ProductDetailsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func products(
    with requestParameter: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ProductsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func shopDetails(
    with requestParameter: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<ShopDetailsQueryResponse>, Error>) -> Void)
  ) -> URLSessionTask {
    dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
  }

  @discardableResult
  func query(
    with requestParameter: QueryRequest,
    selections: QueryRequestSelections,
    completion: @escaping ((Result<GraphQLResponse<QueryResponseModel>, Error>) -> Void)
  ) -> URLSessionTask {
    let completion = { (result: Result<GraphQLResponse<QueryResponseModel>, Error>) in
      switch result {
      case let .success(result):
        do {
          let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
            (requestParameter.campaigns, result.data?.campaigns),
            (requestParameter.productDetails, result.data?.productDetails),
            (requestParameter.products, result.data?.products),
            (requestParameter.shopDetails, result.data?.shopDetails)
          ]

          // Validate response to ensure all selected queries are returned
          try responseExpectations.forEach {
            if let request = $0.0, $0.1 == nil {
              throw GroceriesApiClientError.missingData(
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

private extension GroceriesApiClient {
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

// MARK: - GroceriesRxApi

protocol GroceriesRxApi {
  func query(
    with requestParameter: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<GraphQLResponse<QueryResponseModel>>
  func campaigns(
    with requestParameter: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections
  ) -> Single<GraphQLResponse<CampaignsQueryResponse>>
  func productDetails(
    with requestParameter: ProductDetailsQueryRequest,
    selections: ProductDetailsQueryRequestSelections
  ) -> Single<GraphQLResponse<ProductDetailsQueryResponse>>
  func products(
    with requestParameter: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections
  ) -> Single<GraphQLResponse<ProductsQueryResponse>>
  func shopDetails(
    with requestParameter: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections
  ) -> Single<GraphQLResponse<ShopDetailsQueryResponse>>
}

extension GroceriesApiClient: GroceriesRxApi {
  func campaigns(
    with requestParameter: CampaignsQueryRequest,
    selections: CampaignsQueryRequestSelections
  ) -> Single<GraphQLResponse<CampaignsQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func productDetails(
    with requestParameter: ProductDetailsQueryRequest,
    selections: ProductDetailsQueryRequestSelections
  ) -> Single<GraphQLResponse<ProductDetailsQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func products(
    with requestParameter: ProductsQueryRequest,
    selections: ProductsQueryRequestSelections
  ) -> Single<GraphQLResponse<ProductsQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func shopDetails(
    with requestParameter: ShopDetailsQueryRequest,
    selections: ShopDetailsQueryRequestSelections
  ) -> Single<GraphQLResponse<ShopDetailsQueryResponse>> {
    singleDataTask(with: requestParameter, selections: selections)
  }

  func query(
    with requestParameter: QueryRequest,
    selections: QueryRequestSelections
  ) -> Single<GraphQLResponse<QueryResponseModel>> {
    let task: Single<GraphQLResponse<QueryResponseModel>> = singleDataTask(with: requestParameter, selections: selections)

    return task
      .map { result in
        let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
          (requestParameter.campaigns, result.data?.campaigns),
          (requestParameter.productDetails, result.data?.productDetails),
          (requestParameter.products, result.data?.products),
          (requestParameter.shopDetails, result.data?.shopDetails)
        ]

        // Validate response to ensure all selected queries are returned
        try responseExpectations.forEach {
          if let request = $0.0, $0.1 == nil {
            throw GroceriesApiClientError.missingData(
              context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
            )
          }
        }

        return result
      }
  }
}