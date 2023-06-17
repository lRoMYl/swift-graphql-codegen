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

struct ApiClientRxGenerator: Generating {
  private let apiClientPrefix: String

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
    apiClientPrefix: String
  ) {
    self.apiClientPrefix = apiClientPrefix
    self.apiClientName = entityNameMap.apiClientName(apiClientPrefix: apiClientPrefix)
    self.apiClientErrorName = entityNameMap.apiClientErrorName(apiClientPrefix: apiClientPrefix)
    self.apiClientProtocolName = entityNameMap.apiClientRxProtocolName(apiClientPrefix: apiClientPrefix)
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.scalarMap = scalarMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    return """
    \(helperCode())

    \(try protocolCode(with: schema.operations))

    extension \(apiClientName): \(apiClientProtocolName) {
      \(try schema.operations.map { try funcCode(with: $0).lines }.lines)
    }
    """
  }
}

extension ApiClientRxGenerator {
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
        \(dataTaskCode(with: operation))(with: \(Variables.requestParameter), selections: selections)
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
      let task: \(responseType) = \(dataTaskCode(with: operation))(with: \(Variables.requestParameter), selections: selections)

      return task
        .map { result in
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

          return result
        }
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
    func \(field.funcName)(
      with \(Variables.requestParameter): \(parametersName),
      selections: \(selectionsName)
    ) -> \(responseGenericCode(operation: operation, text: responseDataText))
    """
  }

  func funcSignatureCode(operation: GraphQLAST.Operation) throws -> String {
    let responseText = try entityNameProvider.responseDataName(with: operation)
    let responseDataText = "\(entityNameMap.response)<\(responseText)>"

    let parametersName = try entityNameProvider.requestParameterName(with: operation)
    let selectionsName = try entityNameProvider.selectionsName(with: operation)

    return """
    func \(operation.funcName)(
      with \(Variables.requestParameter): \(parametersName),
      selections: \(selectionsName)
    ) -> \(responseGenericCode(operation: operation, text: responseDataText))
    """
  }

  func responseGenericCode(operation: GraphQLAST.Operation, text: String) -> String {
    switch operation {
    case .query:
      return "Single<\(text)>"
    case .mutation:
      return "Single<\(text)>"
    case .subscription:
      return "Observable<\(text)>"
    }
  }

  func dataTaskCode(with operation: GraphQLAST.Operation) -> String {
    switch operation {
    case .subscription:
      return "observableDataTask"
    case .query, .mutation:
      return "singleDataTask"
    }
  }
}

extension ApiClientRxGenerator {
  func helperCode() -> String {
    """
    // MARK: - Private RxSwift Convenient funcs

    private extension \(apiClientName) {
      func singleDataTask<\(Variables.requestParameterGeneric), Response>(
        with \(Variables.requestParameter): \(Variables.requestParameterGeneric),
        selections: \(entityNameMap.selections)
      ) -> Single<\(Variables.responseGeneric)> where \(Variables.requestParameterGeneric): \(entityNameMap.requestParameter), \(Variables.responseGeneric): \(entityNameProvider.responseType) {
        Single.create { single in
          let task = self.dataTask(
            \(Variables.requestParameter): \(Variables.requestParameter),
            selections: selections
          ) { (result: Result<\(Variables.responseGeneric), Error>) in
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

      func observableDataTask<\(Variables.requestParameterGeneric), \(Variables.responseGeneric)>(
        with \(Variables.requestParameter): \(Variables.requestParameterGeneric),
        selections: \(entityNameMap.selections)
      ) -> Observable<\(Variables.responseGeneric)> where \(Variables.requestParameterGeneric): \(entityNameMap.requestParameter), \(Variables.responseGeneric): \(entityNameProvider.responseType) {
        Observable.create { observer in
          let task = self.dataTask(
            \(Variables.requestParameter): \(Variables.requestParameter),
            selections: selections
          ) { (result: Result<\(Variables.responseGeneric), Error>) in
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
    """
  }
}
