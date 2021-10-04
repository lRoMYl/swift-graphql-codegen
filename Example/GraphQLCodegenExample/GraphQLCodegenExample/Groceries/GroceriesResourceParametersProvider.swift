//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GroceriesResourceParametersProvider: GroceriesResourceParametersProviding {
  func servicePath(with resourceParameter: GroceriesResourceParameters.BodyParameters) -> String {
    ""
  }

  func headers(with resourceParameter: GroceriesResourceParameters.BodyParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with resourceParameter: GroceriesResourceParameters.BodyParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with resourceParameter: GroceriesResourceParameters.BodyParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with resourceParameter: GroceriesResourceParameters.BodyParameters) -> Bool {
    false
  }
}
