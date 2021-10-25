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
  ) -> Single<CampaignsResponseModel?> {
    apiClient.campaigns(
      with: parameters,
      selections: .init()
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return responseModel
    }
  }
}
