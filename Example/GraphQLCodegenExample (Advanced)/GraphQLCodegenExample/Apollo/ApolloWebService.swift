//
//  ApolloWebService.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 18/10/21.
//

import ApiClient

struct ApolloWebService: WebService {
  func baseServiceURL() -> String {
    return "https://apollo-fullstack-tutorial.herokuapp.com/"
  }

  func defaultHttpHeaders() -> [String: String]? {
    return [:]
  }
}
