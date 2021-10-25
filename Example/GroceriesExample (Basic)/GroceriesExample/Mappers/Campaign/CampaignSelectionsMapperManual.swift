//
//  CampaignMapper.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import Foundation

struct CampaignSelectionsMapper: CampaignSelectionsMapping {
  let selections: CampaignsQueryRequestSelections = {
    CampaignsQueryRequestSelections(
      benefitSelections: .allFields,
      campaignAttributeSelections: [.id, .name, .source],
      campaignsSelections: [.campaignAttributes, .productDeals],
      dealSelections: [.discountTag, .triggerQuantity],
      productDealSelections: [.deals, .productId]
    )
  }()

  func map(response: CampaignsResponseModel) throws -> Campaign {
    Campaign(
      attributes: response
        .campaignAttributes?
        .map {
          $0.compactMap { attribute in
            guard let attribute = attribute else { return nil }

            return CampaignAttribute(
              id: attribute.id ?? "",
              name: attribute.name ?? "",
              customVariableNotInResponse: "",
              source: attribute.source.map {
                CampaignAttribute.Source(with: $0)
              } ?? .unknown(""),
              responseSource: attribute.source ?? ._unknown("")
            )
          }
        },
      productDeals: response
        .productDeals?
        .map {
          $0.compactMap { productDeal in
            guard let productDeal = productDeal else { return nil }

            return ProductDeal(
              productId: productDeal.productId ?? "",
              deals: nil
            )
          }
        }
    )
  }
}
