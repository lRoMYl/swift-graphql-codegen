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

    let code = try schema.objects.map {
      try selectionDeclaration(objectType: $0, schemaMap: schemaMap)
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
    let requiredFields = objectType.requiredFields(selectionMap: selectionMap)
    let fieldsIsEmpty = selectableFields.isEmpty && requiredFields.isEmpty

    guard !objectType.isOperation, !fieldsIsEmpty else {
      return ""
    }

    let enumCasesCode = try (requiredFields + selectableFields).map {
      try enumCaseDeclaration(name: $0.name, outputRef: $0.type, scalarMap: scalarMap)
    }.lines

    let rawRepresentableCode = enumCasesCode.isEmpty
      ? " "
      : "String, "
    let requiredDeclarationCode = requiredFields.isEmpty
      ? ""
      : "\n\(requiredFields.map { $0.name }.lines)"

    return try """
    enum \(selectionName):\(rawRepresentableCode)\(entityNameMap.selection) {
      static let requiredDeclaration = \"\"\"\(requiredDeclarationCode)
      \"\"\"

      \(enumCasesCode)
    }
    """.format()
  }

  func enumCaseDeclaration(name: String, outputRef: OutputTypeRef, scalarMap: ScalarMap) throws -> String {
    switch outputRef {
    case let .list(outputRef), let .nonNull(outputRef):
      return try enumCaseDeclaration(name: name, outputRef: outputRef, scalarMap: scalarMap)
    case let .named(objectRef):
      switch objectRef {
      case .scalar, .enum:
        return "case \(name) = \"\(name)\""
      case .object, .interface, .union:
        guard let fragmentName = try entityNameProvider.fragmentName(for: objectRef) else {
          throw SelectionGeneratorError.missingFragmentName(
            context: "Expecting fragment name from \(objectRef.name)"
          )
        }

        return """
        case \(name) = \"\"\"
        \(name) {
          ...\(fragmentName)
        }
        \"\"\"
        """
      }
    }
  }
}
