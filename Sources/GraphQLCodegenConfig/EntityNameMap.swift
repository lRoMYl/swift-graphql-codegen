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

  public let queryRequestParameter: String
  public let mutationRequestParameter: String
  public let subscriptionRequestParameter: String

  public let repositoryPrefix: String

  enum CodingKeys: String, CodingKey {
    case request
    case requestType
    case requestParameter
    case response
    case selection
    case selections
    case queryRequestParameter
    case mutationRequestParameter
    case subscriptionRequestParameter
    case repositoryPrefix
  }

  public init(
    request: String,
    requestType: String,
    requestParameter: String,
    response: String,
    selection: String,
    selections: String,
    queryRequestParameter: String,
    mutationRequestParameter: String,
    subscriptionRequestParameter: String,
    repositoryPrefix: String
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.selection = selection
    self.selections = selections
    self.queryRequestParameter = queryRequestParameter
    self.mutationRequestParameter = mutationRequestParameter
    self.subscriptionRequestParameter = subscriptionRequestParameter
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

    queryRequestParameter = try container.decodeIfPresent(String.self, forKey: .queryRequestParameter) ?? defaultValue.queryRequestParameter
    mutationRequestParameter = try container.decodeIfPresent(String.self, forKey: .mutationRequestParameter) ?? defaultValue.mutationRequestParameter
    subscriptionRequestParameter = try container.decodeIfPresent(String.self, forKey: .subscriptionRequestParameter) ?? defaultValue.subscriptionRequestParameter

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
      queryRequestParameter: "QueryRequestParameter",
      mutationRequestParameter: "MutationRequestParameter",
      subscriptionRequestParameter: "SubscriptionRequestParameter",
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
