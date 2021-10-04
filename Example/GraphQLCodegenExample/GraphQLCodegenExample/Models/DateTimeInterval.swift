//
//  DateTIme.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 4/10/21.
//

import Foundation

/// Example implementation of the Date scalar using TimeInterval
struct DateTimeInterval: Codable {
  var rawValue: Date

  // MARK: - Decoder
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawIntValue = try container.decode(Int.self)

    // Starwars endpoint is returning result in 13 digits instead of 10 digits required by Swift/Unix
    // Manually truncate the result to 10 digits
    let adjustedRawValue = floor(Double(rawIntValue)/1000.0)

    rawValue = Date(timeIntervalSince1970: TimeInterval(adjustedRawValue))
  }

  // MARK: - Encoder
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(Int(rawValue.timeIntervalSince1970))
  }
}

