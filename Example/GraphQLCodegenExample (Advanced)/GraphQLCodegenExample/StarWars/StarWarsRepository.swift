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
    apiClient.characters(with: parameters, selections: .init())
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
    let mapper = CharacterQueryMapper { decoder in
      try CharacterUnion(from: decoder)
    }

    return apiClient.character(with: parameters, selections: mapper.selections)
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
    apiClient.time(with: parameters, selections: .init())
      .map {
        guard let data = $0.data?.time else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }

  func query(
    with parameters: StarWarsQuery
  ) -> Single<QueryStarWarsModel> {
    apiClient.query( with: parameters, selections: .init())
      .map {
        guard let data = $0.data else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }

  func mutate(
    with parameters: MutateStarWarsMutation
  ) -> Single<MutateMutationResponse> {
    apiClient.mutate(with: parameters, selections: .init())
      .map {
        guard let data = $0.data else {
          throw StarWarsRepositoryError.missingData
        }

        return data
      }
  }
}
