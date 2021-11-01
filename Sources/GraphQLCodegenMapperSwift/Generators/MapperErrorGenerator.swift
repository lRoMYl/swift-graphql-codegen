//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct MapperErrorGenerator: Generating {
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  init(entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let mapperErrorName = entityNameProvider.mapperErrorName(apiClientPrefix: "")

    return """
    // MARK: - MapperError

    enum \(mapperErrorName): Error, LocalizedError {
      case missingData(context: String)

      var errorDescription: String? {
        switch self {
        case let .missingData(context):
          return "\\(Self.self): \\(context)"
        }
      }
    }
    """
  }
}
