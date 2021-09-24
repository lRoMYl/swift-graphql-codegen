//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLSwiftCodegen

struct Config: Decodable {
  let apiHeaders: [String: String]?
  let scalarMap: ScalarMap?
  let selectionMap: SelectionMap?
}
