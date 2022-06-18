//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenApiClientSwift
import XCTest

final class DHApiClientHeaderGeneratorTests: XCTestCase {
  func testHeader() throws {
    let generator = HeaderGenerator(apiClientStrategy: .default)

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    import Foundation
    import RxSwift
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
