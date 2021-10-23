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
}
