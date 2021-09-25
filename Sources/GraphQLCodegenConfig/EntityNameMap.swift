//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation

/// Shared antity name mapping convention across generators
public struct EntityNameMap: Decodable {
  public let request: String
  public let requestType: String
  public let requestParameter: String
  public let response: String
  public let selection: String
  public let selections: String

  enum CodingKeys: String, CodingKey {
    case request
    case requestType
    case requestParameter
    case response
    case selection
    case selections
  }

  public init(
    request: String,
    requestType: String,
    requestParameter: String,
    response: String,
    selection: String,
    selections: String
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.selection = selection
    self.selections = selections
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
      selections: "GraphQLSelections"
    )
  }()
}
