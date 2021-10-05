//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation

public struct Config {
  public let apiHeaders: [String: String]?
  public let scalarMap: ScalarMap?
  public let selectionMap: SelectionMap?
  public let entityNameMap: EntityNameMap?

  public init(
    apiHeaders: [String: String]?,
    scalarMap: ScalarMap?,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap?
  ) {
    self.apiHeaders = apiHeaders
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
  }

  public init(
    response: ConfigResponse
  ) {
    let apiHeaders = response.apiHeaders
    let scalarMap: ScalarMap?
    let selectionMap: SelectionMap?
    let entityNameMap: EntityNameMap?

    if let scalarMapResponse = response.scalarMap {
      scalarMap = scalarMapResponse
    } else {
      scalarMap = .default
    }

    if let selectionMapResponse = response.selectionMap {
      selectionMap = SelectionMap(response: selectionMapResponse)
    } else {
      selectionMap = nil
    }

    if let entityNameMapResponse = response.entityNameMap {
      entityNameMap = EntityNameMap(response: entityNameMapResponse)
    } else {
      entityNameMap = .default
    }

    self.init(
      apiHeaders: apiHeaders,
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap
    )
  }
}
