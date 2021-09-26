//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

private typealias FieldMap = [String: Field]

enum RequestParameterSelectionsError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)
  case formatError(context: String)

  var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self).formatError: \(context)"
    default:
      return "\(Self.self).\(self)"
    }
  }
}

struct RequestParameterSelectionsGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
  }

  func declaration(field: Field, objects: [ObjectType], interfaces: [InterfaceType]) throws -> String {
    let namedType = field.type.namedType

    switch namedType {
    case .object:
      return try objectDeclaration(field: field, objects: objects, interfaces: interfaces)
    case .enum, .scalar:
      return emptyDeclaration(field: field)
    case .interface:
      return try interfaceDeclaration(field: field, objects: objects, interfaces: interfaces)
    case .union:
      throw RequestParameterSelectionsError.notImplemented(
        context: "\(namedType) for field \(field.name)"
      )
    }
  }
}

// MARK: - RequestParameterSelectionsGenerator

extension RequestParameterSelectionsGenerator {
  func objectDeclaration(field: Field, objects: [ObjectType], interfaces: [InterfaceType]) throws -> String {
    guard
      let returnObjectType = objects.first(where: { $0.name == field.type.namedType.name })
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No ObjectType type found for field \(field.name)")
    }

    let fieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [fieldScalarType: field]
    fieldMap.merge(try returnObjectType.nestedFields(objects: objects, scalarMap: scalarMap)) { (_, new) in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objects: objects,
      interfaces: interfaces
    )
  }

  func interfaceDeclaration(field: Field, objects: [ObjectType], interfaces: [InterfaceType]) throws -> String {
    guard
      let returnInterfaceType = interfaces.first(where: { $0.name == field.type.namedType.name })
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No InterfaceType type found for field \(field.name)")
    }

    let fieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [fieldScalarType: field]
    fieldMap.merge(try returnInterfaceType.allNestedFields(objects: objects, scalarMap: scalarMap)) { (_, new) in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objects: objects,
      interfaces: interfaces
    )
  }

  func emptyDeclaration(field: Field) -> String {
    """
    // MARK: - Selections

    let selections: Selections

    struct Selections: \(entityNameMap.selections) {
      func declaration() -> String {
        \"\"
      }
    }
    """
  }

  private func structureDeclaration(
    field: Field,
    fieldMaps: [FieldMap.Element],
    objects: [ObjectType],
    interfaces: [InterfaceType]
  ) throws -> String {
    let operationFieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)

    let selectionDeclarations = try fieldMaps.selectionDeclarations(
      objects: objects,
      interfaces: interfaces,
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap
    )

    let selectionFragmentMap = fieldMaps.selectionFragmentMap
    let selectionDeclarationMap = fieldMaps.selectionDeclarationMap

    let code = """
    // MARK: - Selections

    let selections: Selections

    struct Selections: \(entityNameMap.selections) {
      \(selectionDeclarations)

      \(try fieldMaps.memberwiseInitializerDeclaration())

      func declaration() -> String {
        \(selectionFragmentMap)

        \(selectionDeclarationMap)

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "\(operationFieldScalarType.pascalCase)Fragment")
      }
    }
    """
    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw RequestParameterSelectionsError
        .formatError(
          context: """
            \(error)
            Raw text:
            \(code)
            """
        )
    }

    return formattedCode
  }
}

// MARK: - Field

private extension Field {
  func selectionDeclaration(
    objects: [ObjectType],
    interfaces: [InterfaceType],
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap
  ) throws -> String {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    guard
      let returnType = try structure(objects: objects, interfaces: interfaces, scalarMap: scalarMap)
    else { return "" }

    let fields = returnType.selectableFields(objects: objects, selectionMap: selectionMap)
    let fieldsEnum = try fields.map {
      try $0.enumCaseDeclaration(
        name: $0.name,
        type: $0.type,
        scalarMap: scalarMap
      )
    }.lines

    let selectionVariableName = "\(returnName.camelCase)Selections"
    let selectionEnumName = "\(returnName.pascalCase)Selection"

    let result = """
    let \(selectionVariableName): Set<\(selectionEnumName)>

    enum \(selectionEnumName): String, \(entityNameMap.selection) {
      \(fieldsEnum)
    }
    """

    return result
  }

  func enumCaseDeclaration(name: String, type: OutputTypeRef, scalarMap: ScalarMap) throws -> String {
    switch type {
    case let .list(outputRef), let .nonNull(outputRef):
      return try enumCaseDeclaration(name: name, type: outputRef, scalarMap: scalarMap)
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
        throw RequestParameterSelectionsError.notImplemented(context: "Union is not implemented yet")
      }
    }
  }
}

// MARK: - ObjectType

private extension ObjectType {
  func nestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    let fieldMap = try self.fields.flatMap {
      try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: [])
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.name })

    return fieldMap
  }
}

// MARK: - InterfaceType

private extension InterfaceType {
  func allNestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    let fieldMap = try self.fields.flatMap {
      try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: [])
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.name })

    return fieldMap
  }
}

// MARK: - Collection

private extension Collection where Element == FieldMap.Element {
  func selectionDeclarations(
    objects: [ObjectType],
    interfaces: [InterfaceType],
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap
  ) throws -> String {
    try map {
      try $0.value.selectionDeclaration(
        objects: objects,
        interfaces: interfaces,
        scalarMap: scalarMap,
        selectionMap: selectionMap,
        entityNameMap: entityNameMap
      )
    }.lines
  }

  var selectionFragmentMap: String {
    map {
      """
      let \($0.key.camelCase)SelectionsDeclaration = \"\"\"
      fragment \($0.key.pascalCase)Fragment on \($0.key.pascalCase) {\\(\($0.key.camelCase)Selections.declaration)
      }
      \"\"\"\n
      """
    }.lines
  }

  var selectionDeclarationMap: String {
    let selectionDeclarationMapValues = enumerated().map { (index, element) -> String in
      var text = "\"\(element.key.pascalCase)Fragment\": \(element.key.camelCase)SelectionsDeclaration"

      if index < count - 1 {
        text.append(",")
      }

      return text
    }.lines

    return """
    let selectionDeclarationMap = [
      \(selectionDeclarationMapValues)
    ]
    """
  }

  func memberwiseInitializerDeclaration() throws -> String {
    let arguments = map {
      "\($0.key.camelCase)Selections: Set<\($0.value.type.namedType.name)Selection> = []"
    }.joined(separator: ",\n")
    let assignments = map {
      let argumentName = $0.key.camelCase
      return "self.\(argumentName)Selections = \(argumentName)Selections"
    }.lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }
}
