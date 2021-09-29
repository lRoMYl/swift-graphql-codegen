//
//  StarWarsWebService.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 29/9/21.
//

import ApiClient

struct StarWarsWebService: WebService {
  func baseServiceURL() -> String {
    return "https://swift-swapi.herokuapp.com/"
  }

  func defaultHttpHeaders() -> [String: String]? {
    return [:]
  }
}
