//
//  GroceriesRestClient.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/9/21.
//

import ApiClient

struct GroceriesWebService: WebService {
  func baseServiceURL() -> String {
    return "https://sg-st.fd-api.com/groceries-product-service"
  }

  func defaultHttpHeaders() -> [String: String]? {
    return [:]
  }
}
