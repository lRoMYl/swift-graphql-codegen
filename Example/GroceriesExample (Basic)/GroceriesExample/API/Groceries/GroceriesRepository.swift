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

  func query(
    with parameters: CampaignsQueryRequest
  ) -> Single<QueryResponseModel>
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
    let request = CampaignsQueryRequest(
      globalEntityId: "FP_SG",
      locale: "en_SG",
      vendorId: "x1yy"
    )

    let selections = CampaignsQueryRequestSelections(
      campaignAttributeSelections: [.id, .benefits],
      campaignsSelections: .allFields
    )

    return apiClient.campaigns(
      with: request,
      selections: selections
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return try self.campaignMapper.map(response: responseModel)
    }
  }

  func query(
    with parameters: CampaignsQueryRequest
  ) -> Single<QueryResponseModel> {
    apiClient.query(
      with: QueryRequest(
        campaigns: parameters
      ),
      selections: QueryRequestSelections()
    ).map {
      guard let responseModel = $0.data else {
        throw GroceriesRepositoryError.missingData
      }

      return responseModel
    }
  }
}
