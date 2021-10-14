//
//  File.swift
//
//
//  Created by Romy Cheah on 20/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

struct SelectionsOperationDefinitionGenerator {
  private let scalarMap: ScalarMap
  private let variablesGenerator: RequestVariablesGenerator

  init(scalarMap: ScalarMap, variablesGenerator: RequestVariablesGenerator) {
    self.scalarMap = scalarMap
    self.variablesGenerator = variablesGenerator
  }

  func declaration(operation: GraphQLAST.Operation, field: Field) throws -> String {
    let operationName = operation.type.name.lowercased()
    let selection = field.isFragment
      ? " {\n\t\t...\(try field.type.namedType.scalarType(scalarMap: scalarMap))Fragment\n\t}"
      : ""

    let operationVariables = variablesGenerator.operationVariablesDeclaration(with: field)
    let operationVariablesDeclaration = operationVariables.isEmpty
      ? ""
      : "(\n\(operationVariables)\n)"

    let operationArguments = variablesGenerator.operationArgumentsDeclaration(with: field)
    let operationArgumentsDeclaration = operationArguments.isEmpty
      ? ""
      : "(\n\(operationArguments)\n\t)"

    return """
    // MARK: - Operation Definition

    private let operationDefinitionFormat: String = \"\"\"
    \(operationName)\(operationVariablesDeclaration) {
    \t\("\(field.name)\(operationArgumentsDeclaration)\(selection)")
    }

    %1$@
    \"\"\"

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        declaration()
      )
    }
    """
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
