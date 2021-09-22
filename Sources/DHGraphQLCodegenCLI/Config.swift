//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation
import GraphQLCodegen

struct Config: Decodable {
  let scalarMap: ScalarMap
  let selectionMap: SelectionMap?
}
