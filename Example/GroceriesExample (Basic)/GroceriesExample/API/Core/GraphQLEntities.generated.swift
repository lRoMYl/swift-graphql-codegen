// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation

// MARK: - Interfaces

protocol GraphQLRequesting: Encodable {
  var requestType: GraphQLRequestType { get }
  var requestName: String { get }
  var rootSelectionKeys: Set<String> { get }

  var requestQuery: String { get }
  var requestArguments: String { get }
  func requestFragments(with selections: GraphQLSelections) -> String
}

protocol GraphQLSelection: Hashable, CaseIterable {}
protocol GraphQLSelections {
  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String
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
    let requestArguments = parameters.requestArguments
    let requestArgumentsCode = requestArguments.isEmpty
      ? ""
      : " (\(requestArguments))"

    let requestQuery = """
    \(requestTypeCode)\(requestArgumentsCode) {
      \(parameters.requestQuery)
    }

    \(parameters.requestFragments(with: selections))
    """

    try container.encode(parameters, forKey: .parameters)
    try container.encode(requestQuery, forKey: .query)
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

// MARK: - GraphQLSelection+Fragments

extension Collection where Element: GraphQLSelection & RawRepresentable, Element.RawValue == String {
  func requestFragments(requestName: String) -> String {
    let values = count == 0
      ? Element.allCases.map { $0 as Element }
      : map { $0 as Element }

    let variablePrefix = "$\(requestName.prefix(1).lowercased() + requestName.dropFirst())"

    return values.reduce(into: "") {
      let formatted = String(
        format: $1.rawValue.replacingOccurrences(of: "$%@", with: variablePrefix),
        requestName
      )

      $0 += "\n  \(formatted)"
    }
  }
}

extension Set where Element: GraphQLSelection {
  static var allFields: Set<Element> {
    Set(Element.allCases)
  }
}

// MARK: - GraphQLSelections+fragments

extension GraphQLSelections {
  func requestFragments(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
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

extension KeyedDecodingContainer {
  func decodeOptionalIfPresent<T>(
    _ type: T.Type,
    forKey key: KeyedDecodingContainer<K>.Key
  ) throws -> T? where T: Decodable {
    guard contains(key) else {
      return nil
    }

    return Optional(try decode(type, forKey: key))
  }
}

extension Decodable {
  func value<Model, Value>(for keyPath: KeyPath<Model, Value?>, codingKey: CodingKey) throws -> Value {
    guard
      let model = self as? Model,
      let value = model[keyPath: keyPath]
    else {
      throw GraphQLResponseError.missingSelection(key: codingKey, type: String(describing: Model.self))
    }

    return value
  }
}