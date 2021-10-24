//
//  Deal.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation

struct Deal {
  let discountTag: String
  let triggerQuantity: Int

  init(from decoder: DealSelectionDecoder) throws {
    discountTag = try decoder.discountTag()
    triggerQuantity = try decoder.triggerQuantity()
  }
}
