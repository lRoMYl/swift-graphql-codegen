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
  private let entityNameProvider: EntityNameProviding

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let code = try schema.enums.sorted(by: { $0.name > $1.name }).map {
      try $0.declaration(entityNameProvider: entityNameProvider)
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.enum)

    \(code)
    """
  }
}

// MARK: - EnumType

private extension EnumType {
  /// Represents the enum structure.
  func declaration(entityNameProvider: EntityNameProviding) throws -> String {
    """
    \(docs)
    enum \(try entityNameProvider.name(for: self)): RawRepresentable, Codable {
      typealias RawValue = String

      \(valueDeclaration)

      \(initializerDeclaration)

      \(rawValueDeclaration)

      \(try equatableDeclaration(entityNamingStrategy: entityNameProvider))
    }
    """
  }

  /// Represents possible enum cases.
  var valueDeclaration: String {
    """
    \(
      enumValues.map {
        $0.declaration
      }.joined(separator: "\n\n")
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

  func equatableDeclaration(entityNamingStrategy: EntityNameProviding) throws -> String {
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
    let texts: [String] = [
      docs,
      availability,
      "case \(name.camelCase.normalize)"
    ]

    return texts.filter { !$0.isEmpty }.lines
  }
}
