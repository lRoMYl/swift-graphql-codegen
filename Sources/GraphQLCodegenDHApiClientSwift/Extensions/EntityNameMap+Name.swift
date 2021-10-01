//
//  File.swift
//  
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLCodegenConfig

extension EntityNameMap {
  func resourceParametersName(apiClientPrefix: String) -> String {
    // Prefix cannot be empty due to name collision with ApiClient.ResourceParameters
    let prefix = apiClientPrefix.isEmpty ? "Default" : apiClientPrefix

    return "\(prefix)ResourceParameters"
  }

  func resourceBodyParametersName(apiClientPrefix: String?) -> String {
    // Prefix cannot be empty due to name collision with ApiClient.ResourceParameters
    let prefix: String

    if let apiClientPrefix = apiClientPrefix {
      prefix = resourceParametersName(apiClientPrefix: apiClientPrefix) + "."
    } else {
      prefix = ""
    }

    return "\(prefix)BodyParameters"
  }

  func resourceParametersProviding(apiClientPrefix: String) -> String {
    let prefix = resourceParametersName(apiClientPrefix: apiClientPrefix)

    return "\(prefix)Providing"
  }

  func apiClientProtocolName(apiClientPrefix: String) -> String {
    apiClientPrefix + "ApiClientProtocol"
  }

  func apiClientName(apiClientPrefix: String) -> String {
    apiClientPrefix + "ApiClient"
  }
}
