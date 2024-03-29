//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class EnumSpecGeneratorTests: XCTestCase {
  func testCustomEntityNameMapGeneratedCode() throws {
    let discountEnumType = EnumType(
      name: "DiscountType",
      description: "Djini discount type",
      enumValues: [
        .init(
          name: "FREE",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        ),
        .init(
          name: "ABSOLUTE",
          description: "Absolute price discount",
          isDeprecated: true,
          deprecationReason: "Deprecated"
        )
      ]
    )

    let campainSourceEnumType = EnumType(
      name: "CampaignSource",
      description: nil,
      enumValues: [
        .init(
          name: "DJINI",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        )
      ]
    )

    let schema = Schema(
      types: [
        NamedType.enum(discountEnumType),
        NamedType.enum(campainSourceEnumType)
      ],
      query: "Query"
    )

    let entityNameMap = EntityNameMap.mock(enum: "Enum")

    let entityNameProvider = EntityNameProvider(scalarMap: .default, entityNameMap: entityNameMap)

    let generator = EnumCodeGenerator(scalarMap: [:], entityNameMap: entityNameMap, entityNameProvider: entityNameProvider)
    let declaration = try generator.code(schema: schema).format()

    let expected = try """
    // MARK: - Enum

    /// Djini discount type
    enum DiscountTypeEnum: RawRepresentable, Codable {
      typealias RawValue = String

      case free
      /// Absolute price discount
      @available(*, deprecated, message: "Deprecated")
      case absolute

      /// Auto generated constant for unknown enum values
      case _unknown(RawValue)

      public init?(rawValue: RawValue) {
        switch rawValue {
        case "FREE": self = .free
        case "ABSOLUTE": self = .absolute
        default: self = ._unknown(rawValue)
        }
      }

      public var rawValue: RawValue {
        switch self {
        case .free: return "FREE"
        case .absolute: return "ABSOLUTE"
        case let ._unknown(value): return value
        }
      }

      static func == (lhs: DiscountTypeEnum, rhs: DiscountTypeEnum) -> Bool {
        switch (lhs, rhs) {
        case (.free, .free): return true
        case (.absolute, .absolute): return true
        case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
        default: return false
        }
      }
    }

    /// CampaignSource
    enum CampaignSourceEnum: RawRepresentable, Codable {
      typealias RawValue = String

      case djini

      /// Auto generated constant for unknown enum values
      case _unknown(RawValue)

      public init?(rawValue: RawValue) {
        switch rawValue {
        case "DJINI": self = .djini
        default: self = ._unknown(rawValue)
        }
      }

      public var rawValue: RawValue {
        switch self {
        case .djini: return "DJINI"
        case let ._unknown(value): return value
        }
      }

      static func == (lhs: CampaignSourceEnum, rhs: CampaignSourceEnum) -> Bool {
        switch (lhs, rhs) {
        case (.djini, .djini): return true
        case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
        default: return false
        }
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }

  func testDefaultEntityNameMapGeneratedCode() throws {
    let discountEnumType = EnumType(
      name: "DiscountType",
      description: "Djini discount type",
      enumValues: [
        .init(
          name: "FREE",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        ),
        .init(
          name: "ABSOLUTE",
          description: "Absolute price discount",
          isDeprecated: true,
          deprecationReason: "Deprecated"
        )
      ]
    )

    let campainSourceEnumType = EnumType(
      name: "CampaignSource",
      description: nil,
      enumValues: [
        .init(
          name: "DJINI",
          description: nil,
          isDeprecated: false,
          deprecationReason: nil
        )
      ]
    )

    let schema = Schema(
      types: [
        NamedType.enum(discountEnumType),
        NamedType.enum(campainSourceEnumType)
      ],
      query: "Query"
    )

    let entityNameProvider = EntityNameProvider(scalarMap: .default, entityNameMap: .default)

    let generator = EnumCodeGenerator(scalarMap: [:], entityNameMap: .default, entityNameProvider: entityNameProvider)
    let declaration = try generator.code(schema: schema).format()

    let expected = try """
    // MARK: - GraphQLEnumObject

    /// Djini discount type
    enum DiscountTypeGraphQLEnumObject: RawRepresentable, Codable {
      typealias RawValue = String

      case free
      /// Absolute price discount
      @available(*, deprecated, message: "Deprecated")
      case absolute

      /// Auto generated constant for unknown enum values
      case _unknown(RawValue)

      public init?(rawValue: RawValue) {
        switch rawValue {
        case "FREE": self = .free
        case "ABSOLUTE": self = .absolute
        default: self = ._unknown(rawValue)
        }
      }

      public var rawValue: RawValue {
        switch self {
        case .free: return "FREE"
        case .absolute: return "ABSOLUTE"
        case let ._unknown(value): return value
        }
      }

      static func == (lhs: DiscountTypeGraphQLEnumObject, rhs: DiscountTypeGraphQLEnumObject) -> Bool {
        switch (lhs, rhs) {
        case (.free, .free): return true
        case (.absolute, .absolute): return true
        case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
        default: return false
        }
      }
    }

    /// CampaignSource
    enum CampaignSourceGraphQLEnumObject: RawRepresentable, Codable {
      typealias RawValue = String

      case djini

      /// Auto generated constant for unknown enum values
      case _unknown(RawValue)

      public init?(rawValue: RawValue) {
        switch rawValue {
        case "DJINI": self = .djini
        default: self = ._unknown(rawValue)
        }
      }

      public var rawValue: RawValue {
        switch self {
        case .djini: return "DJINI"
        case let ._unknown(value): return value
        }
      }

      static func == (lhs: CampaignSourceGraphQLEnumObject, rhs: CampaignSourceGraphQLEnumObject) -> Bool {
        switch (lhs, rhs) {
        case (.djini, .djini): return true
        case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
        default: return false
        }
      }
    }
    """.format()

    XCTAssertEqual(declaration, expected)
  }
}
