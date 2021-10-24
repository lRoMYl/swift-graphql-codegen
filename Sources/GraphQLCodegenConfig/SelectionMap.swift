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
 - fields: Whitelist which fields to generate for the selection

 By default if no SelectionItemMap is provided, all fields for the Object in schema.json will be whitelisted
 */
public typealias SelectionMap = [String: Set<String>]

extension SelectionMap {
  init(response: SelectionMapResponse) {
    self = response
  }
}
