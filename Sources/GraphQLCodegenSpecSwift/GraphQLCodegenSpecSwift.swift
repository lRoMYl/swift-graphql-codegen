//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation

public struct GraphQLCodegenSpecSwiftConfig {
  public static var defaultConfigPath: String? {
    return Bundle.module.path(forResource: "default-config", ofType: "json")
  }
}
