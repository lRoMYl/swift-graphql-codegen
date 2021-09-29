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
  private let apiClient: GroceriesApiClientImplementing

  init(apiClient: GroceriesApiClientImplementing) {
    self.apiClient = apiClient
  }

  func campaigns(
    with parameters: CampaignsQueryRequestParameter
  ) -> Single<Result<CampaignsResponseObject?, GroceriesRepositoryError>> {
    apiClient.campaigns(with: parameters)
      .map {
        guard let data = $0.data else {
          return .failure(.missingData)
        }

        return .success(data)
      }
  }
}