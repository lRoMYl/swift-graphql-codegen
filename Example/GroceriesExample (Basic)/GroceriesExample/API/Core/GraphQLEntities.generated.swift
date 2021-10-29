// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - Interfaces

protocol GraphQLRequesting: Encodable {
  var requestType: GraphQLRequestType { get }
  var requestName: String { get }
  var rootSelectionKeys: Set<String> { get }

  func operationDefinition() -> String
  func operationArguments() -> String
  func fragments(with selections: GraphQLSelections) -> String
}

protocol GraphQLSelection: Hashable, CaseIterable {}
protocol GraphQLSelections {
  func declaration(for requestName: String, rootSelectionKeys: Set<String>) -> String
}

// MARK: - Enum

enum GraphQLRequestType: String, Codable {
  case query
  case mutation
  case subscription
}

// MARK: GraphQLRequest

struct GraphQLRequest<RequestParameters: GraphQLRequesting>: Encodable {
  let parameters: RequestParameters
  let selections: GraphQLSelections

  enum CodingKeys: String, CodingKey {
    case parameters = "variables"
    case query
  }

  init(parameters: RequestParameters, selections: GraphQLSelections) {
    self.parameters = parameters
    self.selections = selections
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    let requestTypeCode = parameters.requestType.rawValue
    let operationArguments = parameters.operationArguments()
    let operationArgumentCode = operationArguments.isEmpty
      ? ""
      : " (\(operationArguments))"

    let operationDefinition = """
    \(requestTypeCode)\(operationArgumentCode) {
      \(parameters.operationDefinition())
    }

    \(parameters.fragments(with: selections))
    """

    try container.encode(parameters, forKey: .parameters)
    try container.encode(operationDefinition, forKey: .query)
  }
}

// MARK: - GraphQLResponse

struct GraphQLResponse<ResponseData: Codable>: Codable {
  let data: ResponseData
}

enum GraphQLResponseError: Error, LocalizedError {
  case missingSelection(key: CodingKey, type: String)

  var errorDescription: String? {
    switch self {
    case let .missingSelection(key, type):
      return "\(Self.self): \(key.stringValue) is not selected for \(type) type in the GraphQL query"
    }
  }
}

// MARK: - GraphQLSelection+Declaration

extension Collection where Element: GraphQLSelection, Element: RawRepresentable {
  func declaration(requestName: String) -> String {
    if count == 0 {
      return Element.allCases.reduce(into: "") {
        let formatted = String(format: $1.rawValue as? String ?? "", requestName)

        $0 += "\n  \(formatted)"
      }
    } else {
      return reduce(into: "") {
        let formatted = String(format: $1.rawValue as? String ?? "", requestName)

        $0 += "\n  \(formatted)"
      }
    }
  }
}

extension Set where Element: GraphQLSelection {
  static var requiredFields: Set<Element> {
    []
  }

  static var allFields: Set<Element> {
    Set(Element.allCases)
  }
}

// MARK: - GraphQLSelections+Declaration

extension GraphQLSelections {
  func declaration(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
    var dictionary = [String: String]()
    dictionary[rootSelectionKey] = selectionDeclarationMap[rootSelectionKey]

    // Initialize queue with root selection
    var queue = Array(dictionary.values)

    // Remove root selection from SelectionDeclarationMap to prevent circular dependency
    var selectionDeclarationMap = selectionDeclarationMap
    selectionDeclarationMap.removeValue(forKey: rootSelectionKey)

    while !queue.isEmpty {
      let currentFragment = queue.removeFirst()

      for childSelectionKey in selectionDeclarationMap.keys {
        if currentFragment.contains("...\(childSelectionKey)") {
          let value = selectionDeclarationMap[childSelectionKey]!

          queue.append(value)
          dictionary[childSelectionKey] = value
          selectionDeclarationMap[childSelectionKey] = nil
        }
      }
    }

    return dictionary
  }
}
