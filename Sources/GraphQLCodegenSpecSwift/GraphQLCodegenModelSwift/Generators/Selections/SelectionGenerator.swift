//
//  File.swift
//
//
//  Created by Romy Cheah on 5/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum SelectionGeneratorError: Error, LocalizedError {
  case missingFragmentName(context: String)

  var errorDescription: String? {
    switch self {
    default:
      return "\(Self.self).\(self)"
    }
  }
}

struct SelectionGenerator: GraphQLCodeGenerating {
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

  func code(schema: Schema) throws -> String {
    let schemaMap = try SchemaMap(schema: schema)
    let objectTypeMap = ObjectTypeMap(schema: schema)

    // Extract all fields that can be selected from root-level operations
    let fields: [Field] = try schema.operations.map {
      let selectableFields = $0.type.selectableFields(selectionMap: selectionMap)

      return try selectableFields.map {
        try $0.nestedTypeFields(
          schema: schema,
          excluded: [],
          scalarMap: scalarMap,
          selectionMap: selectionMap,
          objectTypeMap: objectTypeMap
        )
      }.reduce([], +)
    }.reduce([], +)

    // Extract all nested fields from the fields
    let nestedTypeFields: [Field] = try fields.map {
      try $0.nestedTypeFields(
        schema: schema,
        excluded: [],
        scalarMap: scalarMap,
        selectionMap: selectionMap,
        objectTypeMap: objectTypeMap
      )
    }
      .reduce([], +)
      .unique(by: { $0.type.namedType.name })
      .sorted(by: .namedType)

    // Generate selection code from the nested fields
    let code = try nestedTypeFields
      .compactMap {
        guard
          let returnObjectType = try $0.returnObjectType(schemaMap: schemaMap)
        else { return nil }

        return try selectionDeclaration(objectType: returnObjectType, schemaMap: schemaMap)
      }
      .filter { !$0.isEmpty }
      .lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.selection)

    \(code)
    """
  }
}

extension SelectionGenerator {
  func selectionDeclaration(objectType: ObjectType, schemaMap _: SchemaMap) throws -> String {
    let selectionName = try entityNameProvider.selectionName(for: objectType)
    let selectableFields = objectType.selectableFields(selectionMap: selectionMap)
      .sorted(by: { $0.name < $1.name })
    let fieldsIsEmpty = selectableFields.isEmpty

    guard !objectType.isOperation, !fieldsIsEmpty else {
      return ""
    }

    let enumCasesCode = try selectableFields.map {
      try enumCaseDeclaration(name: $0.name, arguments: $0.args, outputRef: $0.type, scalarMap: scalarMap)
    }.lines

    let rawRepresentableCode = enumCasesCode.isEmpty
      ? " "
      : "String, "

    return try """
    enum \(selectionName):\(rawRepresentableCode)\(entityNameMap.selection) {
      \(enumCasesCode)
    }
    """.format()
  }

  func enumCaseDeclaration(
    name: String,
    arguments: [InputValue],
    outputRef: OutputTypeRef,
    scalarMap: ScalarMap
  ) throws -> String {
    switch outputRef {
    case let .list(outputRef), let .nonNull(outputRef):
      return try enumCaseDeclaration(name: name, arguments: arguments, outputRef: outputRef, scalarMap: scalarMap)
    case let .named(objectRef):
      let funcDeclaration = arguments.isEmpty
        ? ""
        :"""
        (
          \(
            arguments.map {
              "\($0.name): $%@\(name.pascalCase + $0.name.pascalCase)"
            }.lines
          )
        )
        """

      switch objectRef {
      case .scalar, .enum:
        if funcDeclaration.isEmpty {
          return "case \(name.camelCase) = \"\(name)\""
        } else {
          return """
          case \(name.camelCase) = \"\"\"
          \(name)\(funcDeclaration)
          \"\"\"
          """
        }
      case .object, .interface, .union:
        guard let fragmentName = try entityNameProvider.fragmentName(for: objectRef) else {
          throw SelectionGeneratorError.missingFragmentName(
            context: "Expecting fragment name from \(objectRef.name)"
          )
        }

        return """
        case \(name.camelCase) = \"\"\"
        \(name)\(funcDeclaration) {
          ...%@\(fragmentName)
        }
        \"\"\"
        """
      }
    }
  }
}
