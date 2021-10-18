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

    return "\(prefix)ResourceParametersProvider"
  }

  func resourceParametersConfiguratingName(apiClientPrefix: String) -> String {
    let prefix = resourceParametersPrefix(apiClientPrefix: apiClientPrefix)

    return "\(prefix)ResourceParametersConfigurating"
  }

  func resourceParametersConfiguratorVariableName() -> String {
    "resourceParametersConfigurator"
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

  func apiClientErrorName(apiClientPrefix: String) -> String {
    apiClientName(apiClientPrefix: apiClientPrefix) + "Error"
  }
}

private extension EntityNameMap {
  func resourceParametersPrefix(apiClientPrefix: String) -> String {
    apiClientPrefix.isEmpty ? "Default" : apiClientPrefix
  }
}
