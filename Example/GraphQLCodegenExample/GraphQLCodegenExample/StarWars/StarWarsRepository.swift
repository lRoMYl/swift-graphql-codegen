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
  private let apiClient: StarWarsApiClientProtocol

  init(apiClient: StarWarsApiClientProtocol) {
    self.apiClient = apiClient
  }

  func characters(
    with parameters: CharactersStarWarsQuery
  ) -> Single<[CharacterStarWarsInterface]> {
    apiClient.characters(with: parameters)
      .map {
        guard let data = $0.data?.characters else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }
}
