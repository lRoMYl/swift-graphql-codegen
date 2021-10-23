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
    let mapper = CampaignQueryRequestMapper<Campaign> { decoder -> Campaign in
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

      let result = try mapper.map(response: responseModel)

      return result
    }
  }
}

protocol SelectionMock {
  static func selectionMock() -> Self
}

extension Bool: SelectionMock {
  static func selectionMock() -> Self { false }
}

extension String: SelectionMock {
  static func selectionMock() -> Self { "" }
}

extension Double: SelectionMock {
  static func selectionMock() -> Self { 0 }
}

extension Int: SelectionMock {
  static func selectionMock() -> Self { 0 }
}

struct CampaignQueryRequestMapper<T> {
  typealias MapperBlock = (CampaignsQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CampaignsQueryRequestSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let selectionsDecoder = CampaignsQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)
    do {
      _ = try block(selectionsDecoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    self.selections = CampaignsQueryRequestSelections(
      benefitSelections: selectionsDecoder.benefitSelections,
      campaignAttributeSelections: selectionsDecoder.campaignAttributeSelections,
      campaignsSelections: selectionsDecoder.campaignsSelections,
      dealSelections: selectionsDecoder.dealSelections,
      productDealSelections: selectionsDecoder.productDealSelections
    )
  }

  func map(response: CampaignsResponseModel) throws -> T {
    try block(CampaignsQueryResponseSelectionDecoder(response: response))
  }
}
