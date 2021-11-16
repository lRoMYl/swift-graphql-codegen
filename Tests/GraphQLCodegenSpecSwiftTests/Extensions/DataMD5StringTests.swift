//
//  File.swift
//  
//
//  Created by Romy Cheah on 16/11/21.
//

@testable import GraphQLCodegenSpecSwift
import XCTest

final class DataMD5StringTests: XCTestCase {
  func testMD5String() throws {
    let string = "test data to be encoded"
    let data = string.data(using: .utf8)
    let declaration = try data?.md5String()
    let expectedDeclaration = "123c81e0b3c10f5c6106f9befa018839"

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
