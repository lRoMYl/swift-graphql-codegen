//
//  File.swift
//  
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLCodegenConfig

extension EntityNameMap {
  func resourceParametersName(repositoryPrefix: String) -> String {
    // Prefix cannot be empty due to name collision with ApiClient.ResourceParameters
    let prefix = repositoryPrefix.isEmpty ? "Default" : repositoryPrefix

    return "\(prefix)ResourceParameters"
  }

  func resourceParametersDIContainer(repositoryPrefix: String) -> String {
    let prefix = resourceParametersName(repositoryPrefix: repositoryPrefix)

    return "\(prefix)DIContainer"
  }

  func resourceParametersImplementing(repositoryPrefix: String) -> String {
    let prefix = resourceParametersName(repositoryPrefix: repositoryPrefix)

    return "\(prefix)Implementing"
  }

}
