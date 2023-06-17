//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenApiClientSwift
import XCTest

final class ApiClientGeneratorTests: XCTestCase {
  func testApiClient() throws {
    let generator = ApiClientGenerator(
      selectionMap: nil,
      entityNameMap: .default,
      scalarMap: .default,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default),
      apiClientPrefix: "Groceries",
      apiClientStrategy: .default
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try #"""
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

      init(
        baseURL: URL,
        urlSession: URLSession = .shared,
        jsonEncoder: JSONEncoder = JSONEncoder(),
        jsonDecoder: JSONDecoder = JSONDecoder(),
        interceptor: GroceriesApiClientIntercepting? = nil
      ) {
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
        self.interceptor = interceptor
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
        with requestParameter: GraphQLQuery,
        selections: GraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<QueryGraphQLObject>, Error>) -> Void)
      ) -> URLSessionTask
      @discardableResult
      func campaignAttribute(
        with requestParameter: CampaignAttributeGraphQLQuery,
        selections: CampaignAttributeGraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignAttributeQueryResponse>, Error>) -> Void)
      ) -> URLSessionTask
      @discardableResult
      func campaigns(
        with requestParameter: CampaignsGraphQLQuery,
        selections: CampaignsGraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignsQueryResponse>, Error>) -> Void)
      ) -> URLSessionTask
      @discardableResult
      func update(
        with requestParameter: GraphQLMutation,
        selections: GraphQLMutationSelections,
        completion: @escaping ((Result<GraphQLResponse<MutationGraphQLObject>, Error>) -> Void)
      ) -> URLSessionTask
      @discardableResult
      func campaignAttribute(
        with requestParameter: CampaignAttributeGraphQLMutation,
        selections: CampaignAttributeGraphQLMutationSelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignAttributeMutationResponse>, Error>) -> Void)
      ) -> URLSessionTask
    }

    extension GroceriesApiClient: GroceriesApi {
      @discardableResult
      func campaignAttribute(
        with requestParameter: CampaignAttributeGraphQLQuery,
        selections: CampaignAttributeGraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignAttributeQueryResponse>, Error>) -> Void)
      ) -> URLSessionTask {
        dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
      }

      @discardableResult
      func campaigns(
        with requestParameter: CampaignsGraphQLQuery,
        selections: CampaignsGraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignsQueryResponse>, Error>) -> Void)
      ) -> URLSessionTask {
        dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
      }

      @discardableResult
      func query(
        with requestParameter: GraphQLQuery,
        selections: GraphQLQuerySelections,
        completion: @escaping ((Result<GraphQLResponse<QueryGraphQLObject>, Error>) -> Void)
      ) -> URLSessionTask {
        let completion = { (result: Result<GraphQLResponse<QueryGraphQLObject>, Error>) in
          switch result {
          case let .success(result):
            do {
              let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
                (request.campaignAttribute, result.data?.data?.campaignAttribute),
                (request.campaigns, result.data?.data?.campaigns)
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

      @discardableResult
      func campaignAttribute(
        with requestParameter: CampaignAttributeGraphQLMutation,
        selections: CampaignAttributeGraphQLMutationSelections,
        completion: @escaping ((Result<GraphQLResponse<CampaignAttributeMutationResponse>, Error>) -> Void)
      ) -> URLSessionTask {
        dataTask(requestParameter: requestParameter, selections: selections, completion: completion)
      }

      @discardableResult
      func update(
        with requestParameter: GraphQLMutation,
        selections: GraphQLMutationSelections,
        completion: @escaping ((Result<GraphQLResponse<MutationGraphQLObject>, Error>) -> Void)
      ) -> URLSessionTask {
        let completion = { (result: Result<GraphQLResponse<MutationGraphQLObject>, Error>) in
          switch result {
          case let .success(result):
            do {
              let responseExpectations: [(GraphQLRequestParameter?, Decodable?)] = [
                (request.campaignAttribute, result.data?.data?.campaignAttribute)
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
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
