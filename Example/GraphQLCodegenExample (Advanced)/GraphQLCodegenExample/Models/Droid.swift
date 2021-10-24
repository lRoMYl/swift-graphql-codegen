//
//  Droid.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation

struct Droid {
  let id: String
  let name: String

  init(from decoder: DroidSelectionDecoder) throws {
    id = try decoder.id()
    name = try decoder.name()
  }
}
