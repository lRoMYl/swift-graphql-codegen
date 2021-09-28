//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation

public struct Config: Decodable {
  public let apiHeaders: [String: String]?
  public let scalarMap: ScalarMap?
  public let selectionMap: SelectionMap?
  public let entityNameMap: EntityNameMap?
}
