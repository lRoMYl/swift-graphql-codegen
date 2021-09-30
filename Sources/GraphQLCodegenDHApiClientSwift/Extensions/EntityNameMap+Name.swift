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

  func resourceBodyParametersName(apiClientPrefix: String) -> String {
    // Prefix cannot be empty due to name collision with ApiClient.ResourceParameters
    let prefix = apiClientPrefix.isEmpty ? "Default" : apiClientPrefix

    return "\(prefix)ResourceBodyParameters"
  }

  func resourceParametersProviding(apiClientPrefix: String) -> String {
    let prefix = resourceParametersName(apiClientPrefix: apiClientPrefix)

    return "\(prefix)Providing"
  }

}
