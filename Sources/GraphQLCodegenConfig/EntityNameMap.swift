//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation

public enum EntityNameMapError: Error, LocalizedError {
  case missingValue(context: String)
  case emptyValue(context: String)

  public var errorDescription: String? {
    switch self {
    case let .missingValue(context),
         let .emptyValue(context):
      return  "\(Self.self): \(context)"
    }
  }
}

/// Shared antity name mapping convention across generators
public struct EntityNameMap: Decodable {
  public let request: String
  public let requestType: String
  public let requestParameter: String

  public let response: String

  public let selection: String
  public let selections: String

  public let queries: String
  public let mutations: String
  public let subscriptions: String

  public let repositoryPrefix: String

  enum CodingKeys: String, CodingKey {
    case request
    case requestType
    case requestParameter
    case response
    case selection
    case selections
    case queries
    case mutations
    case subscriptions
    case repositoryPrefix
  }

  public init(
    request: String,
    requestType: String,
    requestParameter: String,
    response: String,
    selection: String,
    selections: String,
    queries: String,
    mutations: String,
    subscriptions: String,
    repositoryPrefix: String
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.selection = selection
    self.selections = selections
    self.queries = queries
    self.mutations = mutations
    self.subscriptions = subscriptions
    self.repositoryPrefix = repositoryPrefix
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let defaultValue = Self.default

    request = try container.decodeIfPresent(String.self, forKey: .request) ?? defaultValue.request
    requestType = try container.decodeIfPresent(String.self, forKey: .requestType) ?? defaultValue.requestType
    requestParameter = try container.decodeIfPresent(String.self, forKey: .requestParameter) ?? defaultValue.requestParameter

    response = try container.decodeIfPresent(String.self, forKey: .response) ?? defaultValue.response

    selection = try container.decodeIfPresent(String.self, forKey: .selection) ?? defaultValue.selection
    selections = try container.decodeIfPresent(String.self, forKey: .selections) ?? defaultValue.selections

    queries = try container.decodeIfPresent(String.self, forKey: .queries) ?? defaultValue.queries
    mutations = try container.decodeIfPresent(String.self, forKey: .mutations) ?? defaultValue.mutations
    subscriptions = try container.decodeIfPresent(String.self, forKey: .subscriptions) ?? defaultValue.subscriptions

    repositoryPrefix = try container.decodeIfPresent(String.self, forKey: .repositoryPrefix) ?? defaultValue.repositoryPrefix
  }
}

public extension EntityNameMap {
  static let `default`: EntityNameMap = {
    EntityNameMap(
      request: "GraphQLRequest",
      requestType: "GraphQLRequestType",
      requestParameter: "GraphQLRequestParameter",
      response: "GraphQLResponse",
      selection: "GraphQLSelection",
      selections: "GraphQLSelections",
      queries: "GraphQLQueries",
      mutations: "GraphQLMutations",
      subscriptions: "GraphQLSubscriptions",
      repositoryPrefix: "GraphQL"
    )
  }()
}

public extension EntityNameMap {
  func validate() throws {
    let mirror = Mirror(reflecting: self)

    for child in mirror.children {
      let label = child.label ?? ""

      guard let stringValue = child.value as? String else {
        throw EntityNameMapError.missingValue(context: "value for \(label) must be String")
      }

      if stringValue.isEmpty {
        throw EntityNameMapError.emptyValue(context: "value for \(label) cannot be empty")
      }
    }
  }
}
