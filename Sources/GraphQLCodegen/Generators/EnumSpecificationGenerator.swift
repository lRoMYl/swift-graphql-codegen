//
//  Enum.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

struct EnumSpecificationGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - Enums

    \(schema.enums.map { $0.declaration }.lines)
    """
  }
}

// MARK: - EnumType

private extension EnumType {
  /// Represents the enum structure.
  var declaration: String {
    """
    \(docs)
    enum \(name.pascalCase): String, CaseIterable, Codable {
    \(values)
    }
    """
  }

  /// Represents possible enum cases.
  var values: String {
    enumValues.map { $0.declaration }.joined(separator: "\n")
  }
}

// MARK: - EnumValue

private extension EnumValue {
  /// Returns an enum case definition.
  var declaration: String {
    """
    \(docs)
    \(availability)
    case \(name.camelCase.normalize) = "\(name)"
    """
  }
}
