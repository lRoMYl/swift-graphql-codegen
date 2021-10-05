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
  ) -> Single<[CharacterStarWarsInterfaceModel]> {
    apiClient.characters(with: parameters)
      .map {
        guard let data = $0.data?.characters else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }

  func character(
    with parameters: CharacterStarWarsQuery
  ) -> Single<CharacterUnionStarWarsUnionModel?> {
    apiClient.character(with: parameters)
      .map {
        guard let data = $0.data?.character else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }

  func time(
    with parameters: TimeStarWarsQuery
  ) -> Single<DateTimeInterval> {
    apiClient.time(with: parameters)
      .map {
        guard let data = $0.data?.time else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }
}
