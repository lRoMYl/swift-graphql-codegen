//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import Foundation
import GraphQLAST

private typealias FieldMap = [String: Field]

enum RequestParameterSelectionsError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct RequestParameterSelectionsGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
  }

  func declaration(operationField: Field, objects: [ObjectType]) throws -> String {
    let namedType = operationField.type.namedType

    switch namedType {
    case .object:
      return try objectDeclaration(operationField: operationField, objects: objects)
    case .enum, .scalar:
      return emptyDeclaration(operationField: operationField)
    case .interface, .union:
      throw RequestParameterSelectionsError.notImplemented(
        context: "\(namedType) for field \(operationField.name)"
      )
    }
  }
}

extension RequestParameterSelectionsGenerator {
  func objectDeclaration(operationField: Field, objects: [ObjectType]) throws -> String {
    guard
      let returnObjectType = objects.first(where: { $0.name == operationField.type.namedType.name })
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No ObjectType type found for field \(operationField.name)")
    }

    let operationFieldScalarType = try operationField.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [operationFieldScalarType: operationField]
    fieldMap.merge(try returnObjectType.allNestedObjectField(objects: objects, scalarMap: scalarMap)) { (_, new) in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = Array(fieldMap).sorted(by: { $0.key < $1.key })

    let selectionDeclarations = try sortedFieldMap.selectionDeclarations(
      objects: objects,
      scalarMap: scalarMap,
      selectionMap: selectionMap
    )
    let selectionFragmentMap = sortedFieldMap.selectionFragmentMap
    let selectionDeclarationMap = sortedFieldMap.selectionDeclarationMap

    let code = """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      \(selectionDeclarations)

      func declaration() -> String {
        \(selectionFragmentMap)

        \(selectionDeclarationMap)

        return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "\(operationFieldScalarType.pascalCase)Fragment")
      }
    }
    """
    let formattedCode = try code.format()

    return formattedCode
  }

  func emptyDeclaration(operationField: Field) -> String {
    """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
      func declaration() -> String {
        \"\"
      }
    }
    """
  }
}

private extension Field {
  func allNestedObjectField(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    guard
      let returnObjectType = objects.first(where: { $0.name == type.namedType.name })
    else {
      return [:]
    }

    var fieldMap = FieldMap()

    switch returnObjectType.kind {
    case .object:
      let scalarType = try self.type.namedType.scalarType(scalarMap: scalarMap)
      fieldMap[scalarType] = self
    case .enumeration, .inputObject, .interface, .scalar, .union:
      break
    }

    try returnObjectType.allFields(objects: objects).forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object:
          let scalarType = try outputRef.scalarType(scalarMap: scalarMap)
          fieldMap[scalarType] = $0
        case .enum, .interface, .scalar, .union:
          break
        }
      case .list, .nonNull:
        fieldMap.merge(try $0.allNestedObjectField(objects: objects, scalarMap: scalarMap)) { (_, new) in new }
      }
    }

    return fieldMap
  }

  func selectionDeclaration(objects: [ObjectType], scalarMap: ScalarMap, selectionMap: SelectionMap?) throws -> String {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    guard
      let returnObjectType = objects.first(where: { $0.name == returnName })
    else {
      return ""
    }

    let allFields = returnObjectType.allSelectableFields(objects: objects, selectionMap: selectionMap)
    let fieldsEnum = try allFields.map {
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

    enum \(selectionEnumName): String, GraphQLSelection {
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
      case .object:
        return """
        case \(name) = \"\"\"
        \(name) {
          ...\(try objectRef.scalarType(scalarMap: scalarMap))Fragment
        }
        \"\"\"
        """
      case .union, .interface:
        throw RequestParameterSelectionsError.notImplemented(context: "Union and Interface are not implemented yet")
      }
    }
  }
}

private extension ObjectType {
  func allNestedObjectField(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    let allFields = self.allFields(objects: objects)
    let fieldMaps = try allFields.map { try $0.allNestedObjectField(objects: objects, scalarMap: scalarMap) }
    let result = fieldMaps.reduce(into: FieldMap()) { result, fieldMap in
      result.merge(fieldMap) { (_, new) in new }
    }

    return result
  }
}

private extension Collection where Element == FieldMap.Element {
  func selectionDeclarations(objects: [ObjectType], scalarMap: ScalarMap, selectionMap: SelectionMap?) throws -> String {
    try map {
      try $0.value.selectionDeclaration(objects: objects, scalarMap: scalarMap, selectionMap: selectionMap)
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
}
