//
//  File.swift
//
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation

public typealias SelectionMapResponse = [String: Set<String>]

public extension SelectionMapResponse {
  func merging(other: SelectionMapResponse) -> SelectionMapResponse {
    merging(
      other,
      uniquingKeysWith: {
        $0.union($1)
      }
    )
  }
}
