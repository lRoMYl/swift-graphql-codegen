//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation

/**
 Custom selection map, this allows custom whitelisting of fields from the schema.json.
 The primary purpose of custom whitelisting is to help reduce the amount of fields to be used from the schema.json as
 the codegeneration is processing all the fields in the schema which might not be relevant to the client.
 - required: This field is required from the codegen selection, the optionality of the field depends on the nullability defined in the schema.json
 - selectable: This field is marked as optional irregardless of the nullability defined in the schema.json

 By default if no SelectionItemMap is provided, all fields for the Object in schema.json will be whitelisted
 */
public typealias SelectionMap = [String: SelectionItemMap]

extension SelectionMap {
  init(response: SelectionMapResponse) {
    self = response.mapValues {
      SelectionItemMap(required: $0.required, selectable: $0.selectable)
    }
  }
}

public enum SelectionMapError: Error, LocalizedError {
  case duplicateKey(context: String)

  public var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

/// SelectionItemMap is only applicable to graphql kind "OBJECT"
public struct SelectionItemMap: Decodable {
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
}

public extension SelectionMap {
  func validate() throws {
    for (key, value) in self {
      let intersectedKeys = value.required.intersection(value.selectable)
      if !intersectedKeys.isEmpty {
        throw SelectionMapError.duplicateKey(
          context: "Duplicate [\(intersectedKeys.joined(separator: ", "))] key(s) found in [\(key)] SelectionItemMap"
        )
      }
    }
  }
}
