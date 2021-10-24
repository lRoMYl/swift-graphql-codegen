//
//  File.swift
//
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation

public struct ConfigResponse: Decodable {
  public let schemaApiHeaders: [String: String]?
  public let scalarMap: ScalarMapResponse?
  public let selectionMap: SelectionMapResponse?
  public let entityNameMap: EntityNameMapResponse?
}

public extension ConfigResponse {
  /// Use current value as default and @configResponse parameter to override current value if it exists
  func merging(configResponse: ConfigResponse) -> ConfigResponse {
    let mergedSchemaApiHeaders = schemaApiHeaders?.merging(
      configResponse.schemaApiHeaders ?? [:],
      uniquingKeysWith: { $1 }
    ) ?? configResponse.schemaApiHeaders
    let mergedScalarMap = scalarMap?.merging(
      configResponse.scalarMap ?? [:],
      uniquingKeysWith: { $1 }
    ) ?? configResponse.scalarMap
    let mergedSelectionMap = selectionMap?.merging(
      configResponse.selectionMap ?? [:],
      uniquingKeysWith: {
        $0.union($1)
      }
    ) ?? configResponse.selectionMap
    let mergedEntityNameMap = entityNameMap?.merging(
      entityNameMapResponse: configResponse.entityNameMap ?? .init()
    ) ?? configResponse.entityNameMap

    return ConfigResponse(
      schemaApiHeaders: mergedSchemaApiHeaders,
      scalarMap: mergedScalarMap,
      selectionMap: mergedSelectionMap,
      entityNameMap: mergedEntityNameMap
    )
  }
}
