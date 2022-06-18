//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST

struct HeaderGenerator: Generating {
  private let apiClientStrategy: ApiClientStrategy

  init(apiClientStrategy: ApiClientStrategy) {
    self.apiClientStrategy = apiClientStrategy
  }

  func code(schema _: Schema) throws -> String {
    var imports: [String] = [
      "import Foundation"
    ]

    switch apiClientStrategy {
    case .default:
      break
    case .rxSwift:
      imports.append("import RxSwift")
    }

    return """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    \(imports.lines)

    """
  }
}
