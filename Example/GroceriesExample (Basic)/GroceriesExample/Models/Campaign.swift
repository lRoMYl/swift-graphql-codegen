//
//  Campaign.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/10/21.
//

import Foundation

struct Campaign {
  let attributes: [CampaignAttribute]?
  let productDeals: [ProductDeal]?
}

extension Campaign {
  init(
    from decoder: CampaignsQuerySelectionDecoder
  ) throws {
    self.attributes = try decoder.campaignAttributes(
      mapper: { try CampaignAttribute(from: $0) }
    )?.compactMap { $0 }
    self.productDeals = try decoder.productDeals(
      mapper: { try ProductDeal(from: $0) }
    )?.compactMap { $0 }
  }
}
