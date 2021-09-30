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
  let texts = [
    "APIKey",
    "dateISO",
    "FirmwareNRFMetadata"
  ]

  func testCamelCase() throws {
    let camelTexts = texts.map { $0.camelCase }
    let expectations = [
      "apiKey",
      "dateIso",
      "firmwareNrfMetadata"
    ]

    XCTAssertEqual(camelTexts, expectations)
  }

  func testPascalCase() throws {
    let pascalTexts = texts.map { $0.pascalCase }
    let expectations = [
      "ApiKey",
      "DateIso",
      "FirmwareNrfMetadata"
    ]

    XCTAssertEqual(pascalTexts, expectations)
  }
}
