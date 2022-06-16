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
      return "\(Self.self): \(context)"
    }
  }
}

/// Shared antity name mapping convention across generators
public struct EntityNameMap {
  // MARK: - Custom GraphQL Entities

  public let request: String
  public let requestType: String
  public let requestParameter: String

  public let response: String
  public let responseError: String
  // Optional, provide this with your own Swift type to decode error extension
  public let responseErrorExtension: String?

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

  // MARK: - CodingKeys

  enum CodingKeys: String, CodingKey {
    case request
    case requestType
    case requestParameter
    case response
    case responseError
    case responseErrorExtension
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
  }

  // MARK: - Initializers

  public init(
    request: String,
    requestType: String,
    requestParameter: String,
    response: String,
    responseError: String,
    responseErrorExtension: String?,
    selection: String,
    selections: String,
    query: String,
    mutation: String,
    subscription: String,
    object: String,
    inputObject: String,
    interface: String,
    union: String,
    enum: String
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.responseError = responseError
    self.responseErrorExtension = responseErrorExtension
    self.selection = selection
    self.selections = selections
    self.query = query
    self.mutation = mutation
    self.subscription = subscription
    self.object = object
    self.inputObject = inputObject
    self.interface = interface
    self.union = union
    self.enum = `enum`
  }

  public init(response: EntityNameMapResponse) {
    let defaultValue = Self.default

    self.init(
      request: response.request ?? defaultValue.request,
      requestType: response.requestType ?? defaultValue.requestType,
      requestParameter: response.requestParameter ?? defaultValue.requestParameter,
      response: response.response ?? defaultValue.response,
      responseError: response.responseError ?? defaultValue.responseError,
      responseErrorExtension: response.responseErrorExtension ?? defaultValue.responseErrorExtension,
      selection: response.selection ?? defaultValue.selection,
      selections: response.selections ?? defaultValue.selections,
      query: response.query ?? defaultValue.query,
      mutation: response.mutation ?? defaultValue.mutation,
      subscription: response.subscription ?? defaultValue.subscription,
      object: response.object ?? defaultValue.object,
      inputObject: response.inputObject ?? defaultValue.inputObject,
      interface: response.interface ?? defaultValue.interface,
      union: response.union ?? defaultValue.union,
      enum: response.enum ?? defaultValue.enum
    )
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
      responseError: "GraphQLResponseError",
      responseErrorExtension: nil,
      selection: "GraphQLSelection",
      selections: "GraphQLSelections",
      query: "GraphQLQuery",
      mutation: "GraphQLMutation",
      subscription: "GraphQLSubscription",
      object: "GraphQLObject",
      inputObject: "GraphQLInputObject",
      interface: "GraphQLInterfaceObject",
      union: "GraphQLUnionObject",
      enum: "GraphQLEnumObject"
    )
  }()

  static let excludeValidation = [
    EntityNameMap.CodingKeys.responseErrorExtension.rawValue
  ]
}

// MARK: - Validation

public extension EntityNameMap {
  func validate() throws {
    let mirror = Mirror(reflecting: self)

    for child in mirror.children {
      let label = child.label ?? ""

      guard let stringValue = child.value as? String else {
        guard !Self.excludeValidation.contains(label) else { continue }
        throw EntityNameMapError.missingValue(context: "value for \(label) must be String")
      }

      if stringValue.isEmpty {
        throw EntityNameMapError.emptyValue(context: "value for \(label) cannot be empty")
      }
    }
  }
}
