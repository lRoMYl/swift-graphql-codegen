//
//  File.swift
//  
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation

public struct ConfigResponse: Decodable {
  public let apiHeaders: [String: String]?
  public let scalarMap: ScalarMapResponse?
  public let selectionMap: SelectionMapResponse?
  public let entityNameMap: EntityNameMapResponse?
}

public extension ConfigResponse {
  /// Use current value as default and @configResponse parameter to override current value if it exists
  func merging(configResponse: ConfigResponse) -> ConfigResponse {
    let mergedApiHeaders = apiHeaders?.merging(
      configResponse.apiHeaders ?? [:],
      uniquingKeysWith: { $1 }
    ) ?? configResponse.apiHeaders
    let mergedScalarMap = scalarMap?.merging(
      configResponse.scalarMap ?? [:],
      uniquingKeysWith: { $1 }
    ) ?? configResponse.scalarMap
    let mergedSelectionMap = selectionMap?.merging(
      configResponse.selectionMap ?? [:],
      uniquingKeysWith: {
        $0.merging(other: $1)
      }
    ) ?? configResponse.selectionMap
    let mergedEntityNameMap = entityNameMap?.merging(
      entityNameMapResponse: configResponse.entityNameMap ?? .init()
    ) ?? configResponse.entityNameMap

    return ConfigResponse(
      apiHeaders: mergedApiHeaders,
      scalarMap: mergedScalarMap,
      selectionMap: mergedSelectionMap,
      entityNameMap: mergedEntityNameMap
    )
  }
}
