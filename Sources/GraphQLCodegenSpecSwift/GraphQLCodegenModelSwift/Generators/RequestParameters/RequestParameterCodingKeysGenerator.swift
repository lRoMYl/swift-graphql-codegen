//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST

struct RequestParameterEncodableGenerator {
  func declaration(field: Field) throws -> String {
    field.args.isEmpty
      ? emptyEncoder()
      : try codingKeys(with: field)
  }
}

// MARK: - RequestParameterEncodableGenerator

private extension RequestParameterEncodableGenerator {
  func codingKeys(with field: Field) throws -> String {
    """
    private enum CodingKeys: String, CodingKey {
      \(try field.args.compactMap { try $0.codingKeysDeclaration() }.lines)
    }
    """
  }

  func emptyEncoder() -> String {
    "func encode(to _: Encoder) throws {}"
  }
}

// MARK: - InputValue

private extension InputValue {
  func codingKeysDeclaration() throws -> String {
    return """
    \(docs)
    case \(name.camelCase) = \"\(name)\"
    """
  }
}
