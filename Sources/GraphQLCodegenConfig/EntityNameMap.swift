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
  // MARK: - Custom GraphQL Entities

  public let request: String
  public let requestType: String
  public let requestParameter: String

  public let response: String

  public let selection: String
  public let selections: String

  // MARK: - GraphQL Operation Type Entities

  public let query: String
  public let mutation: String
  public let subscription: String

  // MARK: - GraphQL Primitive Type Entities

  public let object: String
  public let inputObject: String
  public let interface: String
  public let union: String
  public let `enum`: String

  // MARK: - API Client Entities

  public let apiClientPrefix: String

  // MARK: - CodingKeys

  enum CodingKeys: String, CodingKey {
    case request
    case requestType
    case requestParameter
    case response
    case selection
    case selections
    case query
    case mutation
    case subscription
    case object
    case inputObject
    case interface
    case union
    case `enum`
    case apiClientPrefix
  }

  // MARK: - Initializers

  public init(
    request: String,
    requestType: String,
    requestParameter: String,
    response: String,
//    responseData: String,
    selection: String,
    selections: String,
    query: String,
    mutation: String,
    subscription: String,
    object: String,
    inputObject: String,
    interface: String,
    union: String,
    enum: String,
    apiClientPrefix: String
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.selection = selection
    self.selections = selections
    self.query = query
    self.mutation = mutation
    self.subscription = subscription
    self.object = object
    self.inputObject = inputObject
    self.interface = interface
    self.union = union
    self.`enum` = `enum`
    self.apiClientPrefix = apiClientPrefix
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

    query = try container.decodeIfPresent(String.self, forKey: .query) ?? defaultValue.query
    mutation = try container.decodeIfPresent(String.self, forKey: .mutation) ?? defaultValue.mutation
    subscription = try container.decodeIfPresent(String.self, forKey: .subscription) ?? defaultValue.subscription

    object = try container.decodeIfPresent(String.self, forKey: .object) ?? defaultValue.object
    inputObject = try container.decodeIfPresent(String.self, forKey: .inputObject) ?? defaultValue.inputObject
    interface = try container.decodeIfPresent(String.self, forKey: .interface) ?? defaultValue.interface
    union = try container.decodeIfPresent(String.self, forKey: .union) ?? defaultValue.union
    `enum` = try container.decodeIfPresent(String.self, forKey: .`enum`) ?? defaultValue.`enum`

    apiClientPrefix = try container.decodeIfPresent(String.self, forKey: .apiClientPrefix) ?? defaultValue.apiClientPrefix
  }
}

// MARK: - Default

public extension EntityNameMap {
  static let `default`: EntityNameMap = {
    EntityNameMap(
      request: "GraphQLRequest",
      requestType: "GraphQLRequestType",
      requestParameter: "GraphQLRequestParameter",
      response: "GraphQLResponse",
      selection: "GraphQLSelection",
      selections: "GraphQLSelections",
      query: "GraphQLQuery",
      mutation: "GraphQLMutation",
      subscription: "GraphQLSubscription",
      object: "GraphQLObject",
      inputObject: "GraphQLInputObject",
      interface: "GraphQLInterfaceObject",
      union: "GraphQLUnionObject",
      enum: "GraphQLEnumObject",
      apiClientPrefix: "GraphQL"
    )
  }()
}

// MARK: - Validation

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
