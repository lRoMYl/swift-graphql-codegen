//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GraphQLResourceParametersImplementation: GroceriesResourceParametersImplementing {
  func servicePath(with resourceParameter: GroceriesResourceParameters) -> String {
    ""
  }

  func headers(with resourceParameter: GroceriesResourceParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with resourceParameter: GroceriesResourceParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with resourceParameter: GroceriesResourceParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with resourceParameter: GroceriesResourceParameters) -> Bool {
    false
  }
}
