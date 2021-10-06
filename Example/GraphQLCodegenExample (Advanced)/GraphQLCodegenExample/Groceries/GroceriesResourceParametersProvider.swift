//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GroceriesResourceParametersProvider: GroceriesResourceParametersProviding {
  func servicePath(with _: GroceriesResourceParameters.BodyParameters) -> String {
    ""
  }

  func headers(with _: GroceriesResourceParameters.BodyParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with _: GroceriesResourceParameters.BodyParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with _: GroceriesResourceParameters.BodyParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with _: GroceriesResourceParameters.BodyParameters) -> Bool {
    false
  }
}
