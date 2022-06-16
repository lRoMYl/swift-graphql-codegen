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
  init(with campaign: CampaignsResponseModel) throws {
    self = Campaign(
      attributes: try campaign
        .campaignAttributes?
        .compactMap { attribute in
          return try CampaignAttribute(with: attribute)
        },
      productDeals: nil
//      productDeals: try campaign
//        .productDeals.safelyUnwrapped()?
//        .compactMap { productDeal in
//          return try productDeal.map { try ProductDeal(with: $0) }
//        }
    )
  }
}
