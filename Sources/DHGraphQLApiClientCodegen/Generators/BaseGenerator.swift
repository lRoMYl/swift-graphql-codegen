//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST

struct BaseGenerator: Generating {
  init() {
  }

  func code(schema: Schema) throws -> String {
    #"""
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import ApiClient
    import Foundation

    // MARK: - GraphQLRequest+BodyParameters

    extension GraphQLRequest: BodyParameters {
      func bodyParameters() -> [String: Any] {
        guard
          let data = try? JSONEncoder().encode(self)
        else { return [:] }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
          .flatMap {
            $0 as? [String: Any]
          } ?? [:]
      }
    }
    """#
  }
}
