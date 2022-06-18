//
//  DIContainer.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

class DIContainer {
  static let shared = DIContainer()

  lazy var groceryBuilder: GroceriesBuilder = {
    GroceriesBuilder(
      apiClient: groceriesApiClient,
      campaignMapper: campaignSelectionsMapper
    )
  }()
}

// MARK: - ApiClient

extension DIContainer {
  var groceriesApiClient: GroceriesApiClient {
    GroceriesApiClient(
      baseURL: URL(string: "https://sg-st.fd-api.com/groceries-product-service/query")!
    )
  }
}

// MARK: - Mappers

extension DIContainer {
  var campaignSelectionsMapper: CampaignMapping {
    CampaignSelectionsMapper()
  }
}
