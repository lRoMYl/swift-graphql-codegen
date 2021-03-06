//
//  File.swift
//
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

struct FieldCodeGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func internalVariableDeclaration(object: Structure, field: Field) throws -> String? {
    if object.isOperation {
      // If structure is operation, all fields are generated with optional
      let type: String = try entityNameProvider.name(for: field.type)

      return "let \(field.name.camelCase): Optional<\(type)>"
    } else {
      // Else infer optionality from SelectionMap or Schema
      let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

      if isSelectable {
        let type: String = try entityNameProvider.name(for: field.type)
        let innerVariableName = try entityNameProvider.responseInternalVariableName(with: field)
        return """
        private let \(innerVariableName): Optional<\(type)>
        """
      } else {
        return nil
      }
    }
  }

  func publicVariableDeclaration(
    object: Structure,
    field: Field,
    isThrowableGetterEnabled: Bool
  ) throws -> String? {
    guard !object.isOperation else { return nil }

    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isSelectable {
      let type: String = try entityNameProvider.name(for: field.type)
      let variableName = field.name.camelCase
      let innerVariableName = try entityNameProvider.responseInternalVariableName(with: field)
      let declaration: String

      if !isThrowableGetterEnabled {
        declaration = """
        func \(variableName)() throws -> \(type) {
          try value(for: \\Self.\(innerVariableName), codingKey: CodingKeys.\(innerVariableName))
        }
        """
      } else {
        declaration = """
        var \(variableName): \(type) {
          get throws { try value(for: \\Self.\(innerVariableName), codingKey: CodingKeys.\(innerVariableName)) }
        }
        """
      }

      let texts: [String] = [
        field.docs,
        field.availability,
        declaration
      ]

      return texts.filter { !$0.isEmpty }.lines
    } else {
      return nil
    }
  }

  func codingKeyDeclaration(object: Structure, field: Field) throws -> String? {
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isSelectable {
      if object.isOperation {
        return "case \(field.name.camelCase)"
      } else {
        return "case \(try entityNameProvider.responseInternalVariableName(with: field)) = \"\(field.name)\""
      }
    } else {
      return nil
    }
  }

  func initializerDeclaration(with objectType: ObjectType, fields: [Field]) throws -> String {
    guard !objectType.isOperation else { return "" }

    return """
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      \(
        try fields.map { field in
          let variable = try entityNameProvider.responseInternalVariableName(with: field)
          let type: String = try entityNameProvider.name(for: field.type)
          return "\(variable) = try container.decodeOptionalIfPresent(\(type).self, forKey: .\(variable))"
        }.lines
      )
    }
    """
  }
}
