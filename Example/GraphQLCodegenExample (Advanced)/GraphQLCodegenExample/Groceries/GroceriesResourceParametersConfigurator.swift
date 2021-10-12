//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GroceriesResourceParametersConfigurator: GroceriesResourceParametersConfigurating {
  func servicePath(with _: GroceriesResourceParametersProvider.BodyParameters) -> String {
    ""
  }

  func headers(with _: GroceriesResourceParametersProvider.BodyParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with _: GroceriesResourceParametersProvider.BodyParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with _: GroceriesResourceParametersProvider.BodyParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with _: GroceriesResourceParametersProvider.BodyParameters) -> Bool {
    false
  }
}
