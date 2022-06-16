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

struct GraphQLResponseErrorExtension: Decodable {
  let selectionSet: String?
}

protocol GroceriesRepositoring {
  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign?>

  func shopDetails(
    with parameters: ShopDetailsQueryRequest
  ) -> Single<ShopDetailsResponseModel?>

  func products(
    with parameters: ProductsQueryRequest
  ) -> Single<ProductFilterResultResponseModel?>

  func query(
    campaignQueryRequest: CampaignsQueryRequest,
    shopDetailsQueryRequest: ShopDetailsQueryRequest
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
    let selections = CampaignsQueryRequestSelections(
      campaignAttributeSelections: [.id, .name, .source, .benefits],
      campaignsSelections: .allFields
    )

    return apiClient.campaigns(
      with: parameters,
      selections: selections
    )
      .map {
        guard let responseModel = $0.data?.data?.campaigns else {
          throw GroceriesRepositoryError.missingData
        }

        return try self.campaignMapper.map(response: responseModel)
      }
  }

  func shopDetails(
    with parameters: ShopDetailsQueryRequest
  ) -> Single<ShopDetailsResponseModel?> {
    let selections = ShopDetailsQueryRequestSelections(
      shopDetailsSelections: .allFields,
      shopItemsListSelections: .allFields
    )

    return apiClient.shopDetails(
      with: parameters,
      selections: selections
    )
      .map {
        guard let responseModel = $0.data?.data?.shopDetails else {
          throw GroceriesRepositoryError.missingData
        }

        return responseModel
      }
  }

  func products(
    with parameters: ProductsQueryRequest
  ) -> Single<ProductFilterResultResponseModel?> {
    let selections = ProductsQueryRequestSelections(
      pageInfoSelections: .allFields,
      productSelections: .allFields,
      productFilterResultSelections: .allFields
    )

    return apiClient.products(
      with: parameters,
      selections: selections
    )
      .map {
        guard let responseModel = $0.data?.data?.products else {
          throw GroceriesRepositoryError.missingData
        }

        return responseModel
      }
  }

  func query(
    campaignQueryRequest: CampaignsQueryRequest,
    shopDetailsQueryRequest: ShopDetailsQueryRequest
  ) -> Single<QueryResponseModel> {
    apiClient.query(
      with: QueryRequest(
        campaigns: campaignQueryRequest,
        shopDetails: shopDetailsQueryRequest
      ),
      selections: QueryRequestSelections()
    ).map {
      guard let responseModel = $0.data?.data else {
        throw GroceriesRepositoryError.missingData
      }

      return responseModel
    }
  }
}
