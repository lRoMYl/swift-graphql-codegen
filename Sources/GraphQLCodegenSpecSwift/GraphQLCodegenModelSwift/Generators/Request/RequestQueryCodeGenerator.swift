//
//  File.swift
//
//
//  Created by Romy Cheah on 20/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum RequestOperationDefinitionError: Error, LocalizedError {
  case missingFragment(context: String)

  var errorDescription: String? {
    switch self {
    default:
      return "\(Self.self).\(self)"
    }
  }
}

struct RequestQueryCodeGenerator {
  private let variablesGenerator: RequestVariablesGenerator
  private let entityNameProvider: EntityNameProviding

  init(variablesGenerator: RequestVariablesGenerator, entityNameProvider: EntityNameProviding) {
    self.variablesGenerator = variablesGenerator
    self.entityNameProvider = entityNameProvider
  }

  func declaration(operation: GraphQLAST.Operation, field: Field, schema: Schema) throws -> String {
    let selection: String

    if field.isFragment {
      guard let fragmentName = try entityNameProvider.fragmentName(for: field.type.namedType) else {
        throw RequestOperationDefinitionError.missingFragment(
          context: "Expecting fragment name from \(field.type.namedType.name)"
        )
      }

      selection = " {\n     ...\(field.name.uppercasedFirstLetter())\(fragmentName)\n}"
    } else {
      selection = ""
    }

    let operationArguments = try variablesGenerator.operationArgumentsDeclaration(with: field)
      .joined(separator: "\n    ")
    let operationArgumentsDeclaration = operationArguments.isEmpty
      ? ""
      : "(\n    \(operationArguments)\n)"

    return try """
    let \(entityNameProvider.requestQueryName): String = {
      \"\"\"
      \("\(field.name)\(operationArgumentsDeclaration)\(selection)")
      \"\"\"
    }()
    """.format()
  }
}

// MARK: - Field

private extension Field {
  var isFragment: Bool {
    switch type.namedType {
    case .enum, .scalar:
      return false
    case .object:
      return true
    case .interface:
      return true
    case .union:
      return true
    }
  }
}
