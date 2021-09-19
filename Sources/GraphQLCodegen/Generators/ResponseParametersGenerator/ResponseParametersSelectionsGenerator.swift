//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST

private typealias FieldMap = [String: Field]

struct ResponseParametersSelectionsGenerator {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func declaration(operationField: Field, objects: [ObjectType]) throws -> String {
    guard
      let returnObjectType = objects.first(where: { $0.name == operationField.type.namedType.name })
    else {
      throw ResponseParametersError.missingReturnType(context: "No ObjectType type found for field \(operationField.name)")
    }

    var dictionary = [operationField.name: operationField]
    dictionary.merge(try returnObjectType.allNestedObjectField(objects: objects)) { (_, new) in new }

    let sortedDictionary = Array(dictionary).sorted(by: { $0.key < $1.key })

    let code = """
    // MARK: - Selections

    let selections: Selections

    struct Selections: GraphQLSelections {
    \(try sortedDictionary.map { try $0.value.selectionDeclaration(objects: objects) }.lines )

      func declaration() -> String {
        \"\"\"
        \(
          sortedDictionary.map {
            """
            fragment \($0.key.pascalCase)Fragment on \($0.key.pascalCase) {\\(\($0.key.camelCase)Selections.reduce(into: "") { $0 += "\\n  \\($1.rawValue)" })
            }\n
            """
          }.lines
        )
        \"\"\"
      }
    }
    """
    let formattedCode = try code.format()

    return formattedCode
  }
}

private extension Field {
  func allNestedObjectField(objects: [ObjectType]) throws -> FieldMap {
    guard
      let returnObjectType = objects.first(where: { $0.name == type.namedType.name })
    else {
      return [:]
    }

    var fieldMap = FieldMap()

    switch returnObjectType.kind {
    case .object:
      fieldMap[name] = self
    case .enumeration, .inputObject, .interface, .scalar, .union:
      break
    }

    try returnObjectType.allFields(objects: objects).forEach {
      switch $0.type {
      case let .named(outputRef):
        switch outputRef {
        case .object:
          fieldMap[$0.name] = $0
        case .enum, .interface, .scalar, .union:
          break
        }
      case .list, .nonNull:
        fieldMap.merge(try $0.allNestedObjectField(objects: objects)) { (_, new) in new }
      }
    }

    return fieldMap
  }

  func selectionDeclaration(objects: [ObjectType]) throws -> String {
    let returnName = type.namedType.name

    guard
      let returnObjectType = objects.first(where: { $0.name == returnName })
    else {
      return ""
    }

    let allFields = returnObjectType.allFields(objects: objects)
    let fieldsEnum = try allFields.map { try $0.enumCaseDeclaration(name: $0.name, type: $0.type) }.lines

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

  func enumCaseDeclaration(name: String, type: OutputTypeRef) throws -> String {
    switch type {
    case let .list(outputRef):
      return try enumCaseDeclaration(name: name, type: outputRef)
    case let .named(objectRef):
      switch objectRef {
      case .scalar, .enum:
        return "case \(name) = \"\(name)\""
      case .object:
        return "case \(name) = \"...\(name.pascalCase)Fragment\""
      case .union, .interface:
        throw ResponseParametersError.notImplemented(context: "Union and Interface are not implemented yet")
      }
    case let .nonNull(outputRef):
      return try enumCaseDeclaration(name: name, type: outputRef)
    }
  }
}

private extension ObjectType {
  func allNestedObjectField(objects: [ObjectType]) throws -> FieldMap {
    let allFields = self.allFields(objects: objects)
    let fieldMaps = try allFields.map { try $0.allNestedObjectField(objects: objects) }
    let result = fieldMaps.reduce(into: FieldMap()) { result, fieldMap in
      result.merge(fieldMap) { (_, new) in new }
    }

    return result
  }
}
