//
//  File.swift
//  
//
//  Created by Romy Cheah on 20/9/21.
//

import Foundation
import GraphQLAST

enum APIClientError: Error, LocalizedError {
  case emptyData
}

public final class APIClient {
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()

  public init() {}

  public func fetchIntrospection(
    request: IntroSpectionRequest,
    url: URL,
    headers: [String: String],
    _ completion: @escaping (Result<Schema, Error>, Data?) -> ()
  ) {
    var urlRequest = URLRequest(url: url)

    do {
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
      urlRequest.httpMethod = "POST"
      urlRequest.httpBody = try encoder.encode(request)

      headers.forEach {
        urlRequest.setValue($1, forHTTPHeaderField: $0)
      }
    } catch {
      completion(.failure(error), nil)
    }

    URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
      guard error == nil else {
        completion(.failure(error!), nil)
        return
      }

      guard let data = data else {
        completion(.failure(APIClientError.emptyData), nil)
        return
      }

      do {
        let schemaResponse = try self.decoder.decode(IntrospectionResponse.self, from: data)

        completion(.success(schemaResponse.schema.schema), data)
      } catch {
        completion(.failure(error), nil)
      }
    }
    .resume()
  }
}
