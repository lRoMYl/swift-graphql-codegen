//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 27/9/21.
//

import Foundation

class GraphQLResourceParametersImplementation: GraphQLResourceParametersImplementing {
  func servicePath(with resourceParameter: GraphQLResourceParameters) -> String {
    "query"
  }

  func headers(with resourceParameter: GraphQLResourceParameters) -> [String: String]? {
    nil
  }

  func timeoutInterval(with resourceParameter: GraphQLResourceParameters) -> TimeInterval? {
    nil
  }

  func preventRetry(with resourceParameter: GraphQLResourceParameters) -> Bool {
    true
  }

  func preventAddingLanguageParameters(with resourceParameter: GraphQLResourceParameters) -> Bool {
    false
  }
}
