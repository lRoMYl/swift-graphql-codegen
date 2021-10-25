//
//  GroceriesRepository.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 28/9/21.
//

import Foundation
import RxSwift

enum GroceriesRepositoryError: Error {
  case missingData
}

protocol GroceriesRepositoring {
  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?>
}

final class GroceriesRepository: GroceriesRepositoring {
  let apiClient: GroceriesApiClientProtocol
  let campaignMapper: CampaignMapping

  init(
    apiClient: GroceriesApiClientProtocol,
    campaignMapper: CampaignMapping
  ) {
    self.apiClient = apiClient
    self.campaignMapper = campaignMapper
  }

  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?> {
    apiClient.campaigns(
      with: parameters,
      selections: CampaignsQueryRequestSelections(
        benefitSelections: .allFields,
        campaignAttributeSelections: [.id],
        campaignsSelections: .allFields,
        dealSelections: [.discountTag, .triggerQuantity],
        productDealSelections: [.deals, .productId]
      )
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return try self.campaignMapper.map(response: responseModel)
    }
  }
}
