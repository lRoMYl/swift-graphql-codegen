//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

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
  private let entityNameStrategy: EntityNamingStrategy

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
  }

  func code(field: Field, schema: Schema) throws -> String {
    let namedType = field.type.namedType
    let interfaceTypeMap = try schema.interfaceTypeMap(entityNameStrategy: entityNameStrategy)
    let objectTypeMap = try schema.objectTypeMap(entityNameStrategy: entityNameStrategy)

    switch namedType {
    case .object:
      return try objectDeclaration(
        field: field,
        schema: schema,
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap
      )
    case .enum, .scalar:
      return emptyDeclaration(field: field)
    case .interface:
      return try interfaceDeclaration(
        field: field,
        schema: schema,
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap
      )
    case .union:
      // TODO
      return emptyDeclaration(field: field)
    }
  }
}

// MARK: - RequestParameterSelectionsGenerator

extension RequestParameterSelectionsGenerator {
  func objectDeclaration(
    field: Field,
    schema: Schema,
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap
  ) throws -> String {
    guard
      let returnObjectType = schema.objects.first(where: { $0.name == field.type.namedType.name })
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No ObjectType type found for field \(field.name)")
    }

    let fieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [fieldScalarType: field]
    fieldMap.merge(try returnObjectType.nestedFields(objects: schema.objects, scalarMap: scalarMap)) { (_, new) in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objectTypeMap: schema.objectTypeMap(entityNameStrategy: entityNameStrategy),
      interfaceTypeMap: schema.interfaceTypeMap(entityNameStrategy: entityNameStrategy)
    )
  }

  func interfaceDeclaration(
    field: Field,
    schema: Schema,
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap
  ) throws -> String {
    guard
      let returnInterfaceType = schema.interfaces.first(where: { $0.name == field.type.namedType.name })
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No InterfaceType type found for field \(field.name)")
    }

    let fieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [fieldScalarType: field]
    fieldMap.merge(try returnInterfaceType.allNestedFields(objects: schema.objects, scalarMap: scalarMap)) { (_, new) in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objectTypeMap: schema.objectTypeMap(entityNameStrategy: entityNameStrategy),
      interfaceTypeMap: schema.interfaceTypeMap(entityNameStrategy: entityNameStrategy)
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
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap
  ) throws -> String {
    let operationFieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)

    let selectionDeclarations = try fieldMaps.selectionDeclarations(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameStrategy: entityNameStrategy
    )

    let selectionFragmentMap = try fieldMaps.selectionFragmentMap(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      entityNameStrategy: entityNameStrategy
    )
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
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws -> String {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    guard
      let returnType = try structure(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        entityNameStrategy: entityNameStrategy
      )
    else { return "" }

    let fields = returnType.selectableFields(selectionMap: selectionMap)
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
        // TODO
        return ""
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
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws -> String {
    try map {
      try $0.value.selectionDeclaration(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        scalarMap: scalarMap,
        selectionMap: selectionMap,
        entityNameMap: entityNameMap,
        entityNameStrategy: entityNameStrategy
      )
    }.lines
  }

  func selectionFragmentMap(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    entityNameStrategy: EntityNamingStrategy
  ) throws -> String {
    try map {
      let possibleObjectTypes = try $0.value.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        entityNameStrategy: entityNameStrategy
      )

      return """
      let \($0.key.camelCase)SelectionsDeclaration = \"\"\"
      fragment \($0.key.pascalCase)Fragment on \($0.key.pascalCase) {\\(\($0.key.camelCase)Selections.declaration)
        __typename
        \(
          possibleObjectTypes?.map {
            """
            ... on \($0.name) {
            \t\t\($0.fields.map { $0.name }.joined(separator: "\n\t\t") )
            \t}
            """
          }.joined(separator: "\n\t") ?? ""
        )
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
