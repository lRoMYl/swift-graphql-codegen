//
//  GroceriesRepository.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 28/9/21.
//

import Foundation
import RxSwift

typealias GroceriesRepositoryApi = GroceriesApi & GroceriesRxApi

enum GroceriesRepositoryError: Error {
  case missingData
}

// Define your own repository and decide how you wanted to return data to your app
// Example given belows demonstrate you can either
// - return Response Model as is
// - return a Domain Model by mapping the Response Model to it
// 
// Or you can simply not use a repository and just call the apiClient directly,
// so its entirely up to you to decide the pattern/architecture you prefer

protocol GroceriesRepositoring {
  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign>

  func shopDetails(
    with parameters: ShopDetailsQueryRequest
  ) -> Single<ShopDetailsResponseModel>

  func products(
    with parameters: ProductsQueryRequest
  ) -> Single<ProductFilterResultResponseModel>

  func query(
    campaignQueryRequest: CampaignsQueryRequest,
    shopDetailsQueryRequest: ShopDetailsQueryRequest
  ) -> Single<QueryResponseModel>
}

final class GroceriesRepository: GroceriesRepositoring {
  let apiClient: GroceriesRepositoryApi
  let campaignMapper: CampaignMapping

  init(
    apiClient: GroceriesRepositoryApi,
    campaignMapper: CampaignMapping
  ) {
    self.apiClient = apiClient
    self.campaignMapper = campaignMapper
  }

  func campaigns(
    with parameters: CampaignsQueryRequest
  ) -> Single<Campaign> {
    let selections = CampaignsQueryRequestSelections(
      campaignAttributeSelections: [.id, .name, .source, .benefits],
      campaignsSelections: .allFields
    )

    return apiClient.campaigns(
      with: parameters,
      selections: selections
    )
    .map {
      guard let responseModel = $0.data?.campaigns else {
        throw GroceriesRepositoryError.missingData
      }

      return try self.campaignMapper.map(response: responseModel)
    }
  }

  func shopDetails(
    with parameters: ShopDetailsQueryRequest
  ) -> Single<ShopDetailsResponseModel> {
    let selections = ShopDetailsQueryRequestSelections(
      shopDetailsSelections: .allFields,
      shopItemsListSelections: .allFields
    )

    return apiClient.shopDetails(
      with: parameters,
      selections: selections
    )
    .map {
      guard let responseModel = $0.data?.shopDetails else {
        throw GroceriesRepositoryError.missingData
      }

      return responseModel
    }
  }

  func products(
    with parameters: ProductsQueryRequest
  ) -> Single<ProductFilterResultResponseModel> {
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
      guard let responseModel = $0.data?.products else {
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
    )
    .map {
      guard let responseModel = $0.data else {
        throw GroceriesRepositoryError.missingData
      }

      return responseModel
    }
  }
}
