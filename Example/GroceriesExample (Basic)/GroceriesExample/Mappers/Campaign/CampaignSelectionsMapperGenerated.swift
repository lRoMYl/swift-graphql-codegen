//
//  CampaignQueryMapper+CampaignMapping.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

struct CampaignSelectionsMapperGenerated: CampaignSelectionsMapping {
  let selections: CampaignsQueryRequestSelections
  private let mapper: CampaignsQueryMapper<Campaign>

  init() {
    mapper = CampaignsQueryMapper { responseModel in
      Campaign(
        attributes: try responseModel
          .campaignAttributes(
            mapper: { attribute in
              CampaignAttribute(
                id: try attribute.id(),
                name: try attribute.name(),
                customVariableNotInResponse: "",
                source: try attribute.source(
                  mapper: { CampaignAttribute.Source(with: $0) }
                ),
                responseSource: ._unknown("")
              )
            }
          )?.compactMap { $0 },
        productDeals: try responseModel.productDeals(
          mapper: { productDeal in
            ProductDeal(
              productId: try productDeal.productId(),
              deals: nil
            )
          }
        )?.compactMap { $0 }
      )
    }

    selections = mapper.selections
  }

  func map(response: CampaignsResponseModel) throws -> Campaign {
    try mapper.map(response: response)
  }
}
