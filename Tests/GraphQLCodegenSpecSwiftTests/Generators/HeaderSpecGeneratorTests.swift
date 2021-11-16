//
//  File.swift
//  
//
//  Created by Romy Cheah on 16/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenSpecSwift
import XCTest

final class HeaderSpecGeneratorTests: XCTestCase {
  func testHeader() throws {
    let generator = HeaderCodeGenerator(entityNameMap: .default)

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")

    let declaration = try generator.code(schema: starWarsSchema).format()
    let expectedDeclaration = try """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    import Foundation
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
