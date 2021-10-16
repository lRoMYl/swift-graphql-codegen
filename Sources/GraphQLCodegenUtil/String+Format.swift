//
//  String+Format.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation
import SwiftFormat

public extension String {
  /// Formats the given Swift source code.
  func format() throws -> String {
    let trimmed = trimmingCharacters(
      in: CharacterSet.newlines.union(.whitespaces)
    )

    // TODO: Read configurtion from .swiftformat
    var formatOptions = FormatOptions.default
    formatOptions.indent = "  "
    formatOptions.trailingCommas = false
    formatOptions.shortOptionals = .exceptProperties

    let formatted = try SwiftFormat.format(trimmed, options: formatOptions)
    return formatted
  }
}
