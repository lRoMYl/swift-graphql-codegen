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
    let prefix = resourceParametersPrefix(apiClientPrefix: apiClientPrefix)

    return "\(prefix)ResourceParameters"
  }

  func resourceParametersProvidingName(apiClientPrefix: String) -> String {
    let prefix = resourceParametersPrefix(apiClientPrefix: apiClientPrefix)

    return "\(prefix)ResourceParametersProviding"
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

  func apiClientProtocolName(apiClientPrefix: String) -> String {
    apiClientPrefix + "ApiClientProtocol"
  }

  func apiClientName(apiClientPrefix: String) -> String {
    apiClientPrefix + "ApiClient"
  }
}

private extension EntityNameMap {
  func resourceParametersPrefix(apiClientPrefix: String) -> String {
    apiClientPrefix.isEmpty ? "Default" : apiClientPrefix
  }
}
