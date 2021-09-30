//
//  File.swift
//  
//
//  Created by Romy Cheah on 30/9/21.
//

import GraphQLCodegenUtil
import Foundation
import XCTest

final class StringCaseTests: XCTestCase {
  func testCamelCase() throws {
    let camelText = "APIKey".camelCase
    let expected = "apiKey"

    XCTAssertEqual(camelText, expected)
  }

  func testPascalCase() throws {
    let pascalText = "APIKey".pascalCase
    let expected = "ApiKey"

    XCTAssertEqual(pascalText, expected)
  }
}
