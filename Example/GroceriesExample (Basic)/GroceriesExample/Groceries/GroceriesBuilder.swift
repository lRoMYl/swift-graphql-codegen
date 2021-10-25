//
//  Builder.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

// Lets assume this module builder doesn't create a view
// but create a repository instead

struct GroceriesBuilder {
  let apiClient: GroceriesApiClientProtocol
  let campaignMapper: CampaignMapping

  init(
    apiClient: GroceriesApiClientProtocol,
    campaignMapper: CampaignMapping
  ) {
    self.apiClient = apiClient
    self.campaignMapper = campaignMapper
  }

  func repository() -> GroceriesRepositoring {
    GroceriesRepository(
      apiClient: apiClient,
      campaignMapper: campaignMapper
    )
  }
}
