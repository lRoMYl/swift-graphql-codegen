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

enum SelectionMapError: Error, LocalizedError {
  case duplicateKey(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

/// SelectionItemMap is only applicable to graphql kind "OBJECT"
public struct SelectionItemMap: Decodable {
  let required: Set<String>
  let selectable: Set<String>
}

extension SelectionMap {
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
