//
//  GroceriesRepository+Example.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 25/10/21.
//

import RxSwift

extension GroceriesRepository {
  func campaignsWithCustomMappingExample(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?> {
    let mapper = CampaignsQueryMapper { decoder in
      Campaign(
        attributes: try decoder.campaignAttributes(
          mapper: { decoder in
            CampaignAttribute(
              id: try decoder.id(),
              name: try decoder.name(),
              customVariableNotInResponse: "",
              source: try decoder.source(
                mapper: { CampaignAttribute.Source(with: $0) }
              ),
              responseSource: ._unknown("")
            )
          }
        )?.compactMap { $0 },
        productDeals: try decoder.productDeals(
          mapper: { decoder in
            ProductDeal(
              productId: try decoder.productId(),
              deals: try decoder.deals(
                mapper: { decoder in
                  Deal(
                    discountTag: try decoder.discountTag(),
                    triggerQuantity: try decoder.triggerQuantity()
                  )
                }
              )?.compactMap { $0 }
            )
          }
        )?.compactMap { $0 }
      )
    }

    return apiClient.campaigns(
      with: parameters,
      selections: mapper.selections
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return try mapper.map(response: responseModel)
    }
  }

  func campaignsWithoutUsingMapperExample(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?> {
    let mapper = { (responseModel: CampaignsResponseModel) -> Campaign in
      Campaign(
        attributes: responseModel
          .campaignAttributes??
          .compactMap { attribute in
            CampaignAttribute(
              id: attribute?.id ?? "",
              name: attribute?.name ?? "",
              customVariableNotInResponse: "",
              source: attribute?.source.map {
                CampaignAttribute.Source(with: $0)
              } ?? .unknown(""),
              responseSource: ._unknown("")
            )
          },
        productDeals: responseModel
          .productDeals??
          .compactMap { $0 }
          .map { productDeal in
            ProductDeal(
              productId: productDeal.productId ?? "",
              deals: productDeal.deals??.compactMap { deal in
                return Deal(
                  discountTag: deal?.discountTag ?? "",
                  triggerQuantity: deal?.triggerQuantity ?? 0
                )
              }
            )
          }
      )
    }

    return apiClient.campaigns(
      with: parameters,
      selections: CampaignsQueryRequestSelections(
        benefitSelections: .allFields,
        campaignAttributeSelections: [.id, .name, .source],
        campaignsSelections: [.campaignAttributes, .productDeals],
        dealSelections: [.discountTag, .triggerQuantity],
        productDealSelections: [.deals, .productId]
      )
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return mapper(responseModel)
    }
  }
}
