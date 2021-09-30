//
//  StarWarsRepository.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 29/9/21.
//

import Foundation
import RxSwift

enum StarWarsRepositoryError: Error {
  case missingData
}

final class StarWarsRepository {
  private let apiClient: StarWarsApiClientImplementing

  init(apiClient: StarWarsApiClientImplementing) {
    self.apiClient = apiClient
  }

  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<Result<[CharacterStarWarsInterface], StarWarsRepositoryError>> {
    apiClient.characters(with: parameters)
      .map {
        guard let data = $0.data else {
          return .failure(.missingData)
        }

        return .success(data)
      }
  }
}
