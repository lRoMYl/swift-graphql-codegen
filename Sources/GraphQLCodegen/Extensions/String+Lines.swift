//
//  String+Lines.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

extension Collection where Element == String {
  /// Returns a collection of strings, each string in new line.
  var lines: String {
    joined(separator: "\n")
  }
}
