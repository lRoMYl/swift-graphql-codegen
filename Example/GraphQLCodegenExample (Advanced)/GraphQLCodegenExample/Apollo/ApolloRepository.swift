//
//  ApolloRepository.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 18/10/21.
//

import Foundation
import RxSwift

enum ApolloRepositoryError: Error {
  case missingData
}

final class ApolloRepository {
  private let apiClient: ApolloApiClientProtocol

  init(apiClient: ApolloApiClientProtocol) {
    self.apiClient = apiClient
  }

  func update(
    with parameters: ApolloMutation
  ) -> Single<MutationApolloModel> {
    apiClient.update(
      with: parameters,
      selections: ApolloMutationSelections(
        mission: [.missionPatch, .name]
      )
    )
    .map {
      guard let data = $0.data else {
        throw StarWarsRepositoryError.missingData
      }

      return data
    }
  }

  func cancelTrip(
    with parameters: CancelTripApolloMutation
  ) -> Single<CancelTripMutationResponse> {
    apiClient.cancelTrip(
      with: parameters,
      selections: CancelTripApolloMutationSelections()
    )
    .map {
      guard let data = $0.data else {
        throw StarWarsRepositoryError.missingData
      }

      return data
    }
  }
}
