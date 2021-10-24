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

public struct SelectionItemMapResponse: Decodable {
  public let fields: Set<String>

  enum CodingKeys: String, CodingKey {
    case fields
  }

  public init(
    fields: Set<String>
  ) {
    self.fields = fields
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    fields = try container.decodeIfPresent(Set<String>.self, forKey: .fields) ?? []
  }

  public func merging(other: SelectionItemMapResponse) -> SelectionItemMapResponse {
    SelectionItemMapResponse(
      fields: fields.union(other.fields)
    )
  }
}
