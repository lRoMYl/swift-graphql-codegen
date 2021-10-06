//
//  File.swift
//
//
//  Created by Romy Cheah on 30/9/21.
//

import Foundation
import GraphQLCodegenUtil
import XCTest

final class StringCaseTests: XCTestCase {
  let texts = [
    "APIKey",
    "dateISO",
    "FirmwareNRFMetadata",
    "___a very peculiarNameIndeed__wouldNot.you.agree.AMAZING?____",
    "ENUM",
    "linkToURL",
    "grandfather_father.son grandson",
    "GRAndFATHER_Father.son"
  ]

  func testCamelCase() throws {
    let camelTexts = texts.map { $0.camelCase }
    let expectations = [
      "apiKey",
      "dateIso",
      "firmwareNrfMetadata",
      "aVeryPeculiarNameIndeedWouldNotYouAgreeAmazing",
      "enum",
      "linkToUrl",
      "grandfatherFatherSonGrandson",
      "grAndFatherFatherSon"
    ]

    XCTAssertEqual(camelTexts, expectations)
  }

  func testPascalCase() throws {
    let pascalTexts = texts.map { $0.pascalCase }
    let expectations = [
      "ApiKey",
      "DateIso",
      "FirmwareNrfMetadata",
      "AVeryPeculiarNameIndeedWouldNotYouAgreeAmazing",
      "Enum",
      "LinkToUrl",
      "GrandfatherFatherSonGrandson",
      "GrAndFatherFatherSon"
    ]

    XCTAssertEqual(pascalTexts, expectations)
  }
}
