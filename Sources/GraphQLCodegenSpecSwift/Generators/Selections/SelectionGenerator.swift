//
//  File.swift
//  
//
//  Created by Romy Cheah on 5/10/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

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
  func selectionDeclaration(objectType: ObjectType, schemaMap: SchemaMap) throws -> String {
    let fields = objectType.selectableFields(selectionMap: selectionMap)

    guard !objectType.isOperation, !fields.isEmpty else {
      return ""
    }

    let enumCasesCode = try fields.map {
      try enumCaseDeclaration(name: $0.name, outputRef: $0.type, scalarMap: scalarMap)
    }.lines

    return """
    enum \(objectType.name.pascalCase)Selection: String, \(entityNameMap.selection) {
      \(enumCasesCode)
    }
    """
  }

  func enumCaseDeclaration(name: String, outputRef: OutputTypeRef, scalarMap: ScalarMap) throws -> String {
    switch outputRef {
    case let .list(outputRef), let .nonNull(outputRef):
      return try enumCaseDeclaration(name: name, outputRef: outputRef, scalarMap: scalarMap)
    case let .named(objectRef):
      switch objectRef {
      case .scalar, .enum:
        return "case \(name) = \"\(name)\""
      case .object, .interface:
        return """
        case \(name) = \"\"\"
        \(name) {
          ...\(try objectRef.scalarType(scalarMap: scalarMap))Fragment
        }
        \"\"\"
        """
      case .union:
        // TODO
        return ""
      }
    }
  }
}
