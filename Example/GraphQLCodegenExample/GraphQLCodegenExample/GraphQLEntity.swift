// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - Interfaces

protocol GraphQLRequesting: Encodable {
  associatedtype Selections: GraphQLSelections

  var requestType: GraphQLRequestType { get }
  var selections: Selections { get }
  var operationDefinition: String { get }
}

protocol GraphQLSelection: RawRepresentable, Hashable, CaseIterable where RawValue == String {}
protocol GraphQLSelections {
  func declaration() -> String
}

// MARK: - Enum

enum GraphQLRequestType {
  case query
  case mutation
  case subscription
}

// MARK: GraphQLRequestCodableWrapper

struct GraphQLRequestCodableWrapper<RequestParameters: GraphQLRequesting>: Encodable {
  let parameters: RequestParameters

  enum CodingKeys: String, CodingKey {
    case parameters = "variables"
    case query
    case mutation
    case subscription
  }

  init(parameters: RequestParameters) {
    self.parameters = parameters
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(parameters, forKey: .parameters)

    let operationDefinition = parameters.operationDefinition

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

struct GraphQLResponse<ResponseData: GraphQLResponseData, ReturnType: Codable>: Codable {
  let data: ResponseData

  enum CodingKeys: String, CodingKey {
    case data
  }

  var wrappedValue: ReturnType? {
    data.wrappedValue as? ReturnType
  }
}

// MARK: - GraphQLResponseData

protocol GraphQLResponseData: Codable {
  associatedtype T: Decodable

  var wrappedValue: T { get }
}

// MARK: - GraphQLSelection+Declaration

extension Collection where Element: GraphQLSelection {
  var declaration: String {
    if count == 0 {
      return Element.allCases.reduce(into: "") { $0 += "\n  \($1.rawValue)" }
    } else {
      return reduce(into: "") { $0 += "\n  \($1.rawValue)" }
    }
  }
}

// MARK: - GraphQLSelections+Declaration

extension GraphQLSelections {
  func declaration(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> String {
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

    return dictionary.values.joined(separator: "\n")
  }
}
