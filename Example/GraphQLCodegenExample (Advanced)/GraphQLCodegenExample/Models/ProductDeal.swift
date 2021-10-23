//
//  ProductDeal.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/10/21.
//

import Foundation

struct ProductDeal {
  let productId: String
  let deals: [Deal]?

  init(from decoder: ProductDealSelectionDecoder) throws {
    productId = try decoder.productId()
    deals = nil
    // Uncomment this to fetch deals automatically
//    deals = try decoder
//      .deals(mapper: { try Deal(from: $0) })?
//      .compactMap { $0 }
  }
}
