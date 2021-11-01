//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

struct HeaderGenerator: Generating {
  init() {}

  func code(schema _: Schema) throws -> String {
    let primitiveMap = [
      "Bool": "false",
      "String": "\"\"",
      "Double": "0",
      "Int": "0"
    ]

    let primitiveCodes = primitiveMap.sorted(by: { $0.key < $1.key }).map {
      """
      private extension \($0.key) {
        static func selectionMock() -> Self { \($0.value) }
      }
      """
    }.joined(separator: "\n\n")

    return """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import ApiClient
    import Foundation
    import RxSwift

    // MARK: - Primitive Selection Mock

    \(primitiveCodes)

    // MARK: - Extensions

    private extension Optional {
      func unwrapOrFail(context: String = "") throws -> Wrapped {
        guard let value = self else {
          throw GroceriesMapperError.missingData(context: context)
        }

        return value
      }
    }

    """
  }
}
