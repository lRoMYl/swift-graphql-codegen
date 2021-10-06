//
//  File.swift
//
//
//  Created by Romy Cheah on 24/9/21.
//

import Foundation
import GraphQLAST

struct HeaderGenerator: Generating {
  init() {}

  func code(schema _: Schema) throws -> String {
    #"""
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import ApiClient
    import Foundation
    import RxSwift

    """#
  }
}
