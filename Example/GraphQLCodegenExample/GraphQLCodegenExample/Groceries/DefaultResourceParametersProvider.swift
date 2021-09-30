//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GraphQLResourceParametersProvider: GroceriesResourceParametersProviding {
  func servicePath(with resourceParameter: GroceriesResourceBodyParameters) -> String {
    ""
  }

  func headers(with resourceParameter: GroceriesResourceBodyParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with resourceParameter: GroceriesResourceBodyParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with resourceParameter: GroceriesResourceBodyParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with resourceParameter: GroceriesResourceBodyParameters) -> Bool {
    false
  }
}
