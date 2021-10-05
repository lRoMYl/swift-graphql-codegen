//
//  File.swift
//  
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation

public typealias SelectionMapResponse = [String: SelectionItemMapResponse]

public extension SelectionMapResponse {
  func merging(other: SelectionMapResponse) -> SelectionMapResponse {
    merging(
      other,
      uniquingKeysWith: { $0.merging(other: $1) }
    )
  }
}

public struct SelectionItemMapResponse: Decodable {
  public let required: Set<String>
  public let selectable: Set<String>

  enum CodingKeys: String, CodingKey {
    case required
    case selectable
  }

  public init(
    required: Set<String>,
    selectable: Set<String>
  ) {
    self.required = required
    self.selectable = selectable
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    required = try container.decodeIfPresent(Set<String>.self, forKey: .required) ?? []
    selectable = try container.decodeIfPresent(Set<String>.self, forKey: .selectable) ?? []
  }

  public func merging(other: SelectionItemMapResponse) -> SelectionItemMapResponse {
    SelectionItemMapResponse(
      required: required.union(other.required),
      selectable: selectable.union(other.selectable)
    )
  }
}
