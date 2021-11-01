//
//  File.swift
//  
//
//  Created by Romy Cheah on 14/10/21.
//

@testable import GraphQLCodegenConfig

extension EntityNameMap {
  static func mock(
    request: String? = nil,
    requestType: String? = nil,
    requestParameter: String? = nil,
    response: String? = nil,
    selection: String? = nil,
    selections: String? = nil,
    query: String? = nil,
    mutation: String? = nil,
    subscription: String? = nil,
    object: String? = nil,
    inputObject: String? = nil,
    interface: String? = nil,
    union: String? = nil,
    enum: String? = nil,
    apiClientPrefix: String? = nil
  ) -> Self {
    let defaultEntityNameMap = EntityNameMap.default

    return EntityNameMap(
      request: request ?? defaultEntityNameMap.request,
      requestType: requestType ?? defaultEntityNameMap.requestType,
      requestParameter: requestParameter ?? defaultEntityNameMap.requestParameter,
      response: response ?? defaultEntityNameMap.response,
      selection: selection ?? defaultEntityNameMap.selection,
      selections: selections ?? defaultEntityNameMap.selections,
      query: query ?? defaultEntityNameMap.query,
      mutation: mutation ?? defaultEntityNameMap.mutation,
      subscription: subscription ?? defaultEntityNameMap.subscription,
      object: object ?? defaultEntityNameMap.object,
      inputObject: inputObject ?? defaultEntityNameMap.inputObject,
      interface: interface ?? defaultEntityNameMap.interface,
      union: union ?? defaultEntityNameMap.union,
      enum: `enum` ?? defaultEntityNameMap.enum
    )
  }
}
