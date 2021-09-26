//
//  File.swift
//  
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLCodegenConfig

extension EntityNameMap {
  func resourceParametersName(namespace: String) -> String {
    // Prefix cannot be empty due to name collision with ApiClient.ResourceParameters
    let prefix = namespace.isEmpty ? "Default" : namespace

    return "\(prefix)ResourceParameters"
  }
}
