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
 */
public typealias SelectionMap = [String: SelectionItemMap]

/// SelectionItemMap is only applicable to graphql kind "OBJECT"
public struct SelectionItemMap: Decodable {
  let required: [String]
  let selectable: [String]
}
