//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GroceriesResourceParametersProvider: GroceriesResourceParametersProviding {
  func servicePath(with bodyParameters: GroceriesResourceParameters.BodyParameters) -> String {
    ""
  }

  func headers(with bodyParameters: GroceriesResourceParameters.BodyParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with bodyParameters: GroceriesResourceParameters.BodyParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with bodyParameters: GroceriesResourceParameters.BodyParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with bodyParameters: GroceriesResourceParameters.BodyParameters) -> Bool {
    false
  }
}
