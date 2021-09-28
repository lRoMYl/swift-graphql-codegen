//
//  Enum.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct EnumCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  func code(schema: Schema) throws -> String {
    """
    // MARK: - \(entityNameMap.enums)

    enum \(entityNameMap.enums) {}

    extension \(entityNameMap.enums) {
      \(schema.enums.map { $0.declaration }.lines)
    }
    """
  }
}

// MARK: - EnumType

private extension EnumType {
  /// Represents the enum structure.
  var declaration: String {
    """
    \(docs)
    enum \(name.pascalCase): RawRepresentable, Codable {
      typealias RawValue = String

      \(valueDeclaration)

      \(initializerDeclaration)

      \(rawValueDeclaration)

      \(equatableDeclaration)

      \(allCasesDeclaration)
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

  var equatableDeclaration: String {
    """
    static func == (lhs: \(name.pascalCase), rhs: \(name.pascalCase)) -> Bool {
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

  var allCasesDeclaration: String {
    """
    static var allCases: [\(name.pascalCase)] {
      return [
        \(
          enumValues.map {
            ".\($0.name.camelCase)"
          }.joined(separator: ",\n")
        )
      ]
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
