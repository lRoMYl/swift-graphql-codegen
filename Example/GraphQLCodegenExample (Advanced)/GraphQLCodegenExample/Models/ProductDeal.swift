//
//  ProductDeal.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/10/21.
//

import Foundation

struct ProductDeal {
  let productId: String

  init(from decoder: ProductDealSelectionDecoder) throws {
    productId = try decoder.productId()
  }
}
