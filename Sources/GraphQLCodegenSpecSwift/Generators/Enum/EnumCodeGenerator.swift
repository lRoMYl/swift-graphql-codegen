//
//  Enum.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct EnumCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameStrategy: EntityNamingStrategy) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
  }

  func code(schema: Schema) throws -> String {
    """
    // MARK: - \(entityNameMap.enums)

    \(
      try schema.enums.map {
        try $0.declaration(entityNameStrategy: entityNameStrategy)
      }.lines
    )
    """
  }
}

// MARK: - EnumType

private extension EnumType {
  /// Represents the enum structure.
  func declaration(entityNameStrategy: EntityNamingStrategy) throws -> String {
    """
    \(docs)
    enum \(try entityNameStrategy.name(for: self)): RawRepresentable, Codable {
      typealias RawValue = String

      \(valueDeclaration)

      \(initializerDeclaration)

      \(rawValueDeclaration)

      \(try equatableDeclaration(entityNamingStrategy: entityNameStrategy))
    }
    """
  }

  /// Represents possible enum cases.
  var valueDeclaration: String {
    """
    \(
      enumValues.map {
        $0.declaration
      }.joined(separator: "\n")
    )

    /// Auto generated constant for unknown enum values
    case _unknown(RawValue)
    """
  }

  var initializerDeclaration: String {
    """
    public init?(rawValue: RawValue) {
      switch rawValue {
        \(
          enumValues.map {
            "case \"\($0.name)\": self = .\($0.name.camelCase)"
          }.lines
        )
        default: self = ._unknown(rawValue)
      }
    }
    """
  }

  var rawValueDeclaration: String {
    """
    public var rawValue: RawValue {
      switch self {
      \(
        enumValues.map {
          "case .\($0.name.camelCase): return \"\($0.name)\""
        }.lines
      )
        case let ._unknown(value): return value
      }
    }
    """
  }

  func equatableDeclaration(entityNamingStrategy: EntityNamingStrategy) throws -> String {
    let enumTypeName = try entityNamingStrategy.name(for: self)

    return """
    static func == (lhs: \(enumTypeName), rhs: \(enumTypeName)) -> Bool {
      switch (lhs, rhs) {
        \(
          enumValues.map {
            "case (.\($0.name.camelCase), .\($0.name.camelCase)): return true"
          }.lines
        )
        case (let ._unknown(lhsValue), let ._unknown(rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }
    """
  }
}

// MARK: - EnumValue

private extension EnumValue {
  /// Returns an enum case definition.
  var declaration: String {
    """
    \(docs)
    \(availability)
    case \(name.camelCase.normalize)
    """
  }
}
