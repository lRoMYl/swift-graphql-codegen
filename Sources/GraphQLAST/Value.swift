//
//  Value.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

/// Represents a single GraphQL field.
public struct Field: Decodable, Equatable {
  public let name: String
  public let description: String?
  public let args: [InputValue]
  public let type: OutputTypeRef
  public let isDeprecated: Bool
  public let deprecationReason: String?

  public init(
    name: String,
    description: String?,
    args: [InputValue],
    type: OutputTypeRef,
    isDeprecated: Bool,
    deprecationReason: String?
  ) {
    self.name = name
    self.description = description
    self.args = args
    self.type = type
    self.isDeprecated = isDeprecated
    self.deprecationReason = deprecationReason
  }
}

/// Represents a GraphQL type that may be used as an input value.
public struct InputValue: Decodable, Equatable {
  public let name: String
  public let description: String?
  public let type: InputTypeRef
}

/// Represents a  GraphQL enumerator case.
public struct EnumValue: Codable, Equatable {
  public let name: String
  public let description: String?
  public let isDeprecated: Bool
  public let deprecationReason: String?
}
