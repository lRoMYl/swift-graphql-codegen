//
//  CampaignMapping.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

protocol CampaignSelectionsMapping {
  var selections: CampaignsQueryRequestSelections { get }

  func map(response: CampaignsResponseModel) throws -> Campaign
}
