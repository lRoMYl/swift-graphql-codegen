//
//  CampaignMapper.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

struct CampaignSelectionsMapper: CampaignMapping {
  func map(response: CampaignsResponseModel) throws -> Campaign {
    try Campaign(with: response)
  }
}
