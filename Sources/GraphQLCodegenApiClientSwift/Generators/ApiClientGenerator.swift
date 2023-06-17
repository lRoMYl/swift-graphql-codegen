//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum ApiClientGeneratorError: Error, LocalizedError {
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ApiClientGenerator: Generating {
  private let apiClientPrefix: String
  private let apiClientStrategy: ApiClientStrategy

  private let apiClientName: String
  private let apiClientErrorName: String
  private let apiClientProtocolName: String

  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let scalarMap: ScalarMap
  private let entityNameProvider: EntityNameProviding

  enum Variables {
    static let requestParameter = "requestParameter"
    static let requestParameterGeneric = "RequestParameter"
    static let responseGeneric = "Response"
  }

  init(
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    scalarMap: ScalarMap,
    entityNameProvider: EntityNameProviding,
    apiClientPrefix: String,
    apiClientStrategy: ApiClientStrategy
  ) {
    self.apiClientPrefix = apiClientPrefix
    self.apiClientName = entityNameMap.apiClientName(apiClientPrefix: apiClientPrefix)
    self.apiClientErrorName = entityNameMap.apiClientErrorName(apiClientPrefix: apiClientPrefix)
    self.apiClientProtocolName = entityNameMap.apiClientProtocolName(apiClientPrefix: apiClientPrefix)
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
    self.apiClientStrategy = apiClientStrategy
  }

  func code(schema: Schema) throws -> String {
    return """
    \(apiClientErrorCode())

    \(apiClientInterceptingCode())

    \(apiClientCode())

    \(helperCode())

    \(try protocolCode(with: schema.operations))

    extension \(apiClientName): \(apiClientProtocolName) {
      \(try schema.operations.map { try funcCode(with: $0).lines }.lines)
    }
    """
  }
}

extension ApiClientGenerator {
  func protocolCode(with operation: GraphQLAST.Operation) throws -> String {
    var funcDeclarations: [String] = try operation
      .type
      .selectableFields(selectionMap: selectionMap).map {
        try funcSignatureCode(field: $0, operation: operation)
      }

    funcDeclarations.insert(try funcSignatureCode(operation: operation), at: 0)

    return funcDeclarations.lines
  }

  func protocolCode(with operations: [GraphQLAST.Operation]) throws -> String {
    return """
    // MARK: - \(apiClientProtocolName)

    protocol \(apiClientProtocolName) {
      \(
        try operations.map {
          try protocolCode(with: $0)
        }.lines
      )
    }
    """
  }

  func funcCode(with operation: GraphQLAST.Operation) throws -> [String] {
    var codes: [String] = try operation.type.selectableFields(selectionMap: selectionMap).map {
      let funcSignature = try funcSignatureCode(field: $0, operation: operation)

      return """
      \(funcSignature) {
        \(dataTaskCode(with: operation))
      }
      """
    }

    // Root operation
    let responseText = try entityNameProvider.responseDataName(with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"
    let responseType = responseGenericCode(operation: operation, text: responseDataText)
    let requestQueryName = entityNameProvider.requestQueryName

    codes.append("""
    \(try funcSignatureCode(operation: operation)) {
      let completion = { (result: Result<\(responseType), Error>) in
        switch result {
        case let .success(result):
          do {
            let responseExpectations: [(\(entityNameMap.requestParameter)?, \(entityNameProvider.responseType)?)] = [
              \(
                operation.type.selectableFields(selectionMap: selectionMap).map {
                  let fieldFuncName = $0.funcName

                  return "(request.\(fieldFuncName), result.data?.data?.\(fieldFuncName))"
                }.joined(separator: ",\n")
              )
            ]

            // Validate response to ensure all selected queries are returned
            try responseExpectations.forEach {
              if let request = $0.0, $0.1 == nil {
                throw \(apiClientErrorName).missingData(
                  context: "Missing data for \\(request.requestType.rawValue) { \\(request.\(requestQueryName)) }"
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
    """)

    return codes
  }

  func funcSignatureCode(field: Field, operation: GraphQLAST.Operation) throws -> String {
    let responseText = try entityNameProvider.responseDataName(for: field, with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"

    let parametersName = try entityNameProvider.requestParameterName(for: field, with: operation)
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)

    return """
    @discardableResult
    func \(field.funcName)(
      with \(Variables.requestParameter): \(parametersName),
      selections: \(selectionsName),
      completion: @escaping ((Result<\(responseGenericCode(operation: operation, text: responseDataText)), Error>) -> Void)
    ) -> URLSessionTask
    """
  }

  func funcSignatureCode(operation: GraphQLAST.Operation) throws -> String {
    let responseText = try entityNameProvider.responseDataName(with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"

    let parametersName = try entityNameProvider.requestParameterName(with: operation)
    let selectionsName = try entityNameProvider.selectionsName(with: operation)

    return """
    @discardableResult
    func \(operation.funcName)(
      with \(Variables.requestParameter): \(parametersName),
      selections: \(selectionsName),
      completion: @escaping ((Result<\(responseGenericCode(operation: operation, text: responseDataText)), Error>) -> Void)
    ) -> URLSessionTask
    """
  }

  func responseGenericCode(operation: GraphQLAST.Operation, text: String) -> String {
    text
  }

  func dataTaskCode(with operation: GraphQLAST.Operation) -> String {
    let name = dataTaskName(with: operation)
    let requestParameterDeclaration = "\(Variables.requestParameter): \(Variables.requestParameter)"
    let selectionsDeclaration = "selections: selections"
    let completionDeclaration = "completion: completion"
    let parameters = [
      requestParameterDeclaration,
      selectionsDeclaration,
      completionDeclaration
    ]

    return "\(name)(\(parameters.joined(separator: ",")))"
  }

  func dataTaskName(with operation: GraphQLAST.Operation) -> String {
    switch operation {
    case .subscription:
      return "dataTask"
    case .query, .mutation:
      return "dataTask"
    }
  }
}

extension ApiClientGenerator {
  func apiClientErrorCode() -> String {
    """
    // MARK: - \(apiClientErrorName)

    enum \(apiClientErrorName): Error, LocalizedError {
      case missingSelf
      case missingData(context: String)
      case error(Error)
      case unknown(context: String)

      var errorDescription: String? {
        switch self {
        case .missingSelf:
          return "\\(Self.self): self is dequeued"
        case let .missingData(context):
          return "\\(Self.self): \\(context)"
        case let .error(error):
          return "\\(Self.self): \\(error.localizedDescription)"
        case let .unknown(context):
          return "\\(Self.self): \\(context)"
        }
      }
    }
    """
  }

  func apiClientInterceptingCode() -> String {
    """
    protocol \(apiClientName)Intercepting {
      func headers(urlRequest: URLRequest, \(Variables.requestParameter): \(entityNameMap.requestParameter)) -> [String: String]?
    }
    """
  }

  func apiClientCode() -> String {
    var variables: [String] = [
      "private let baseURL: URL",
      "private let urlSession: URLSession",
      "private let jsonEncoder: JSONEncoder",
      "private let jsonDecoder: JSONDecoder",
      "",
      "private let interceptor: GroceriesApiClientIntercepting?"
    ]

    var initVariables: [String] = [
      "baseURL: URL",
      "urlSession: URLSession = .shared",
      "jsonEncoder: JSONEncoder = JSONEncoder()",
      "jsonDecoder: JSONDecoder = JSONDecoder()",
      "interceptor: GroceriesApiClientIntercepting? = nil"
    ]

    var initAssignments: [String] = [
      "self.baseURL = baseURL",
      "self.urlSession = urlSession",
      "self.jsonEncoder = jsonEncoder",
      "self.jsonDecoder = jsonDecoder",
      "self.interceptor = interceptor"
    ]

    switch apiClientStrategy {
    case .default:
      break
    case .rxSwift:
      variables.append("private let scheduler: SchedulerType")
      initVariables.append("scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)")
      initAssignments.append("self.scheduler = scheduler")
    }

    return """
    // MARK: - \(apiClientName)

    final class \(apiClientName) {
      \(variables.joined(separator: "\n"))

      init(
        \(initVariables.joined(separator: ",\n"))
      ) {
        \(initAssignments.joined(separator: "\n"))
      }
    }
    """
  }

  func helperCode() -> String {
    """
    // MARK: - Private URLSession Convenient funcs

    private extension \(apiClientName) {
      func dataTask<\(Variables.requestParameterGeneric), \(Variables.responseGeneric)>(
        \(Variables.requestParameter): \(Variables.requestParameterGeneric),
        selections: \(entityNameMap.selections),
        completion: @escaping ((Result<\(Variables.responseGeneric), Error>) -> Void)
      ) -> URLSessionTask where \(Variables.requestParameterGeneric): \(entityNameMap.requestParameter), Response: Decodable {
        let task = urlSession
          .dataTask(
            with: urlRequest(with: \(Variables.requestParameter), selections: selections),
            completionHandler: { [weak self] responseData, urlResponse, error in
              guard let self = self else {
                completion(.failure(\(apiClientErrorName).missingSelf))
                return
              }

              guard error == nil else {
                completion(.failure(\(apiClientErrorName).error(error!)))
                return
              }

              guard let responseData = responseData else {
                completion(.failure(\(apiClientErrorName).missingData(context: "Empty response")))
                return
              }

              do {
                let response = try self.jsonDecoder.decode(Response.self, from: responseData)
                completion(.success(response))
              } catch {
                completion(.failure(\(apiClientErrorName).error(error)))
              }
            }
          )

        return task
      }

      func urlRequest<\(Variables.requestParameterGeneric)>(
        with \(Variables.requestParameter): \(Variables.requestParameterGeneric),
        selections: \(entityNameMap.selections)
      ) -> URLRequest where \(Variables.requestParameterGeneric): \(entityNameMap.requestParameter) {
        var urlRequest = URLRequest(
          url: baseURL,
          cachePolicy: urlSession.configuration.requestCachePolicy,
          timeoutInterval: urlSession.configuration.timeoutIntervalForRequest
        )
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? jsonEncoder.encode(
          \(entityNameMap.request)(parameters: \(Variables.requestParameter), selections: selections)
        )

        if let interceptor = interceptor {
          urlRequest.allHTTPHeaderFields = interceptor.headers(
            urlRequest: urlRequest,
            \(Variables.requestParameter): \(Variables.requestParameter)
          )
        }

        return urlRequest
      }
    }
    """
  }
}
