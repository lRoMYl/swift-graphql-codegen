//
//  String+Format.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import SwiftFormat
import Foundation

public extension String {
  /// Formats the given Swift source code.
  func format() throws -> String {
    let trimmed = trimmingCharacters(
      in: CharacterSet.newlines.union(.whitespaces)
    )

    // Todo: Read configurtion from .swiftformat
    var formatOptions = FormatOptions.default
    formatOptions.indent = "  "
    formatOptions.trailingCommas = false

    let formatted = try SwiftFormat.format(trimmed, options: formatOptions)
    return formatted
  }
}
