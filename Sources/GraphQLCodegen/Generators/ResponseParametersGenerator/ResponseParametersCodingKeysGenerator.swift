//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST

struct ResponseParametersCodingKeysGenerator {
  func declaration(field: Field) throws -> String {
    """
    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
      \(try field.args.compactMap { try $0.codingKeysDeclaration() }.lines)
    }
    """
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
