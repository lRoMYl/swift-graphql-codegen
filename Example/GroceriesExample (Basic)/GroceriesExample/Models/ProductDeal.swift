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
}

extension ProductDeal {
  init(with productDeal: ProductDealResponseModel) throws {
    self = ProductDeal(
      productId: try productDeal.productId,
      deals: nil
    )
  }
}
