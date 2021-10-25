//
//  DIContainer.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import ApiClient
import Foundation

class DIContainer {
  static let shared = DIContainer()

  lazy var groceryBuilderGenerated: GroceriesBuilder = {
    GroceriesBuilder(
      apiClient: groceriesApiClient,
      campaignMapper: campaignSelectionsMapperGenerated
    )
  }()

  lazy var groceryBuilderManual: GroceriesBuilder = {
    GroceriesBuilder(
      apiClient: groceriesApiClient,
      campaignMapper: campaignSelectionsMapperGenerated
    )
  }()
}

// MARK: - ApiClient

extension DIContainer {
  var groceriesApiClient: GroceriesApiClient {
    let restClient = RestClientImpl(
      webService: GroceriesWebService(),
      authProvider: nil
    )

    return GroceriesApiClient(
      restClient: restClient
    )
  }
}

// MARK: - Mappers

extension DIContainer {
  var campaignSelectionsMapperGenerated: CampaignSelectionsMapping {
    CampaignSelectionsMapperGenerated()
  }

  var campaignSelectionsMapperManual: CampaignSelectionsMapping {
    CampaignSelectionsMapper()
  }
}
