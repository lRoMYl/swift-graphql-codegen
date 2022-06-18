//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation
import GraphQLCodegenConfig

public struct GraphQLCodegenSpecSwiftConfig {
  public static var defaultConfigResponse: ConfigResponse {
    let entityNameMap = EntityNameMapResponse(
      request: "GraphQLRequest",
      requestParameter: "GraphQLRequestParameter",
      query: "QueryRequest",
      mutation: "MutationRequest",
      subscription: "SubscriptionRequest",
      object: "ResponseModel",
      inputObject: "RequestModel",
      interface: "InterfaceResponseModel",
      union: "UnionResponseModel",
      enum: "EnumResponseModel"
    )

    return ConfigResponse(
      schemaApiHeaders: nil,
      scalarMap: nil,
      selectionMap: nil,
      entityNameMap: entityNameMap
    )
  }
}
