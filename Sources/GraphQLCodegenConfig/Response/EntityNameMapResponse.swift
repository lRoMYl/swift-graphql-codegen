//
//  File.swift
//
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation

public struct EntityNameMapResponse: Decodable {
  // MARK: - Custom GraphQL Entities

  public let request: String?
  public let requestType: String?
  public let requestParameter: String?

  public let response: String?
  public let responseError: String?
  public let responseErrorExtension: String?

  public let selection: String?
  public let selections: String?

  public let configuration: String?

  // MARK: - GraphQL Operation Type Entities

  public let query: String?
  public let mutation: String?
  public let subscription: String?

  // MARK: - GraphQL Primitive Type Entities

  public let object: String?
  public let inputObject: String?
  public let interface: String?
  public let union: String?
  public let `enum`: String?

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
    case configuration
    case query
    case mutation
    case subscription
    case object
    case inputObject
    case interface
    case union
    case `enum`
  }

  public init(
    request: String? = nil,
    requestType: String? = nil,
    requestParameter: String? = nil,
    response: String? = nil,
    responseError: String? = nil,
    responseErrorExtension: String? = nil,
    selection: String? = nil,
    selections: String? = nil,
    configuration: String? = nil,
    query: String? = nil,
    mutation: String? = nil,
    subscription: String? = nil,
    object: String? = nil,
    inputObject: String? = nil,
    interface: String? = nil,
    union: String? = nil,
    enum: String? = nil
  ) {
    self.request = request
    self.requestType = requestType
    self.requestParameter = requestParameter
    self.response = response
    self.responseError = responseError
    self.responseErrorExtension = responseErrorExtension
    self.selection = selection
    self.selections = selections
    self.configuration = configuration
    self.query = query
    self.mutation = mutation
    self.subscription = subscription
    self.object = object
    self.inputObject = inputObject
    self.interface = interface
    self.union = union
    self.enum = `enum`
  }
}

extension EntityNameMapResponse {
  // Merge @entityNameMapResponse with current value if it's nil
  func merging(entityNameMapResponse: EntityNameMapResponse) -> EntityNameMapResponse {
    EntityNameMapResponse(
      request: entityNameMapResponse.request ?? request,
      requestType: entityNameMapResponse.requestType ?? requestType,
      requestParameter: entityNameMapResponse.requestParameter ?? requestParameter,
      response: entityNameMapResponse.response ?? response,
      responseError: entityNameMapResponse.responseError ?? responseError,
      responseErrorExtension: entityNameMapResponse.responseErrorExtension ?? responseErrorExtension,
      selection: entityNameMapResponse.selection ?? selection,
      selections: entityNameMapResponse.selections ?? selections,
      configuration: entityNameMapResponse.configuration ?? configuration,
      query: entityNameMapResponse.query ?? query,
      mutation: entityNameMapResponse.mutation ?? mutation,
      subscription: entityNameMapResponse.subscription ?? subscription,
      object: entityNameMapResponse.object ?? object,
      inputObject: entityNameMapResponse.inputObject ?? inputObject,
      interface: entityNameMapResponse.interface ?? interface,
      union: entityNameMapResponse.union ?? union,
      enum: entityNameMapResponse.enum ?? `enum`
    )
  }
}
