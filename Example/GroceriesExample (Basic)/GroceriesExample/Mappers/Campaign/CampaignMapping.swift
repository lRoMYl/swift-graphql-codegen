//
//  CampaignMapping.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

protocol CampaignMapping {
  func map(response: CampaignsResponseModel) throws -> Campaign
}
