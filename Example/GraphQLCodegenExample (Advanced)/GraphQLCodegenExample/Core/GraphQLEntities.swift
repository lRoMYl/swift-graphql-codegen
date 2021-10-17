// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - Interfaces

protocol GraphQLRequesting: Encodable {
  var requestType: GraphQLRequestType { get }
  var rootSelectionKeys: Set<String> { get }
}

protocol GraphQLSelection: Hashable, CaseIterable {
  static var requiredDeclaration: String { get }
}

protocol GraphQLSelections {
  func declaration(with rootSelectionKeys: Set<String>) -> String
  func operationDefinition(with rootSelectionKeys: Set<String>) -> String
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
    case mutation
    case subscription
  }

  init(parameters: RequestParameters, selections: GraphQLSelections) {
    self.parameters = parameters
    self.selections = selections
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(parameters, forKey: .parameters)

    let operationDefinition = selections.operationDefinition(with: parameters.rootSelectionKeys)

    switch parameters.requestType {
    case .query:
      try container.encode(operationDefinition, forKey: .query)
    case .mutation:
      try container.encode(operationDefinition, forKey: .mutation)
    case .subscription:
      try container.encode(operationDefinition, forKey: .subscription)
    }
  }
}

// MARK: - GraphQLResponse

struct GraphQLResponse<ResponseData: Codable>: Codable {
  let data: ResponseData
}

// MARK: - GraphQLSelection+Declaration

extension Collection where Element: GraphQLSelection, Element: RawRepresentable {
  var declaration: String {
    if Element.requiredDeclaration.isEmpty, count == 0 {
      return Element.allCases.reduce(into: "") { $0 += "\n  \($1.rawValue)" }
    } else {
      return reduce(into: "") { $0 += "\n  \($1.rawValue)" }
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
        }
      }
    }

    return dictionary
  }
}
