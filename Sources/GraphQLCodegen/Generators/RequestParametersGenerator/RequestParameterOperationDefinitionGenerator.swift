//
//  File.swift
//  
//
//  Created by Romy Cheah on 20/9/21.
//

import Foundation
import GraphQLAST

struct RequestParameterOperationDefinitionGenerator {
  private let scalarMap: ScalarMap
  private let variablesGenerator: RequestParameterVariablesGenerator

  init(scalarMap: ScalarMap, variablesGenerator: RequestParameterVariablesGenerator) {
    self.scalarMap = scalarMap
    self.variablesGenerator = variablesGenerator
  }

  func declaration(operationTypeName: String, field: Field) throws -> String {
    let selection = field.isFragment
      ? " {\n...\(try field.type.namedType.scalarType(scalarMap: scalarMap))Fragment\n}"
      : ""

    let operationVariables = variablesGenerator.operationVariablesDeclaration(with: field)
    let operationVariablesDeclaration = operationVariables.isEmpty
      ? ""
      : " (\n\(operationVariables)\n)"

    let operationArguments = variablesGenerator.operationArgumentsDeclaration(with: field)
    let operationArgumentsDeclaration = operationArguments.isEmpty
      ? ""
      : "(\n\(operationArguments)\n)"

    return """
    // MARK: - Operation Defintion

    private let operationDefinitionFormat: String = \"\"\"
    \(operationTypeName)\(operationVariablesDeclaration) {
      \(
        """
        \(field.name)\(operationArgumentsDeclaration)\(selection)
        """
      )
    }

    %1$@
    \"\"\"

    var operationDefinition: String {
      String(
        format: operationDefinitionFormat,
        selections.declaration()
      )
    }
    """
  }
}

private extension Field {
  var isFragment: Bool {
    switch self.type.namedType {
    case .enum, .scalar:
      return false
    case .object:
      return true
    case .interface:
      return true
    case .union:
      print("\(Self.self) Interface/Union not implemented")
      return false
    }
  }
}
