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

final class GroceriesRepository {
  private let apiClient: GroceriesApiClientProtocol

  init(apiClient: GroceriesApiClientProtocol) {
    self.apiClient = apiClient
  }

  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?> {
    let mapper = CampaignsQueryMapper { decoder in
      try Campaign(from: decoder)
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

  func campaignsWithCustomMappingExample(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?> {
    let mapper = CampaignsQueryMapper { decoder in
      Campaign(
        attributes: try decoder.campaignAttributes(
          mapper: { decoder in
            CampaignAttribute(
              id: try decoder.id(),
              name: "",
              customVariableNotInResponse: "",
              source: try decoder.source(mapper: { CampaignAttribute.Source(with: $0) }),
              responseSource: ._unknown("")
            )
          }
        )?.compactMap { $0 },
        productDeals: nil
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
    return apiClient.campaigns(
      with: parameters,
      selections: CampaignsQueryRequestSelections()
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return Campaign(
        attributes: responseModel.campaignAttributes??.compactMap { attribute in
          guard let attribute = attribute else { return nil }

          return CampaignAttribute(with: attribute)
        },
        productDeals: responseModel.productDeals??.compactMap { _ in return nil }
      )
    }
  }
}