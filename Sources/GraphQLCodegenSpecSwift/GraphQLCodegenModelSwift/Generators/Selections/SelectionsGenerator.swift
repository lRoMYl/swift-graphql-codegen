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

enum SelectionsGeneratorError: Error, LocalizedError {
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

struct SelectionsGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let operationDefinitionGenerator: SelectionsOperationDefinitionGenerator

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

    let requestParameterVariablesGenerator = RequestVariablesGenerator(
      scalarMap: scalarMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )

    operationDefinitionGenerator = SelectionsOperationDefinitionGenerator(
      scalarMap: scalarMap,
      variablesGenerator: requestParameterVariablesGenerator
    )
  }

  func code(schema: Schema) throws -> String {
    try schema.operations.map { operation in
      try operation.type.fields.map { field in
        try code(operation: operation, field: field, schema: schema)
      }.lines
    }.lines
  }

  func code(operation: GraphQLAST.Operation, field: Field, schema: Schema) throws -> String {
    let namedType = field.type.namedType
    let schemaMap = try SchemaMap(schema: schema)

    switch namedType {
    case .object:
      return try objectDeclaration(
        operation: operation,
        field: field,
        schemaMap: schemaMap
      )
    case .enum, .scalar:
      return try emptyDeclaration(operation: operation, field: field)
    case .interface:
      return try interfaceDeclaration(
        operation: operation,
        field: field,
        schemaMap: schemaMap
      )
    case .union:
      return try unionDeclaration(
        operation: operation,
        field: field,
        schemaMap: schemaMap
      )
    }
  }
}

// MARK: - RequestParameterSelectionsGenerator

extension SelectionsGenerator {
  func objectDeclaration(
    operation: GraphQLAST.Operation,
    field: Field,
    schemaMap: SchemaMap
  ) throws -> String {
    guard let returnObjectType = try field.returnObjectType(schemaMap: schemaMap) else {
      throw SelectionsGeneratorError.missingReturnType(context: "No ObjectType type found for field \(field.name)")
    }

    let fieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
    var fieldMap: FieldMap = [fieldScalarType: field]
    fieldMap.merge(try returnObjectType.nestedFields(objects: schemaMap.schema.objects, scalarMap: scalarMap)) { _, new in new }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: sortedFieldMap,
      schemaMap: schemaMap
    )
  }

  func interfaceDeclaration(
    operation: GraphQLAST.Operation,
    field: Field,
    schemaMap: SchemaMap
  ) throws -> String {
    guard
      let returnInterfaceType = try schemaMap.interfaceTypeMap.value(from: field.type.namedType),
      let possibleObjectTypes = try field.possibleObjectTypes(
        schemaMap: schemaMap
      )
    else {
      throw SelectionsGeneratorError.missingReturnType(context: "No InterfaceType type found for field \(field.name)")
    }

    var fieldMap = FieldMap()

    fieldMap[returnInterfaceType.name] = Field(
      name: returnInterfaceType.name,
      description: returnInterfaceType.description,
      args: [],
      type: .named(.interface(returnInterfaceType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )

    try possibleObjectTypes.forEach {
      fieldMap[$0.name] = Field(
        name: $0.name,
        description: $0.description,
        args: [],
        type: .named(.object($0.name)),
        isDeprecated: false,
        deprecationReason: nil
      )

      fieldMap.merge(try $0.nestedFields(objects: schemaMap.schema.objects, scalarMap: scalarMap)) { _, new in new }
    }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: sortedFieldMap,
      schemaMap: schemaMap
    )
  }

  func unionDeclaration(
    operation: GraphQLAST.Operation,
    field: Field,
    schemaMap: SchemaMap
  ) throws -> String {
    guard
      let returnUnionType = try schemaMap.unionTypeMap.value(from: field.type.namedType),
      let possibleObjectTypes = try field.possibleObjectTypes(
        schemaMap: schemaMap
      )
    else {
      throw SelectionsGeneratorError.missingReturnType(context: "No UnionType type found for field \(field.name)")
    }

    var fieldMap = FieldMap()

    fieldMap[returnUnionType.name] = Field(
      name: returnUnionType.name,
      description: returnUnionType.description,
      args: [],
      type: .named(.union(returnUnionType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )

    try possibleObjectTypes.forEach {
      fieldMap[$0.name] = Field(
        name: $0.name,
        description: $0.description,
        args: [],
        type: .named(.object($0.name)),
        isDeprecated: false,
        deprecationReason: nil
      )

      fieldMap.merge(try $0.nestedFields(objects: schemaMap.schema.objects, scalarMap: scalarMap)) { _, new in new }
    }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: sortedFieldMap,
      schemaMap: schemaMap
    )
  }

  func emptyDeclaration(operation: GraphQLAST.Operation, field: Field) throws -> String {
    let operationDefinition = try operationDefinitionGenerator.declaration(
      operation: operation,
      field: field
    )
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)

    return """
    // MARK: - Selections

    struct \(selectionsName): \(entityNameMap.selections) {
      \(operationDefinition)

      func declaration() -> String {
        \"\"
      }
    }
    """
  }

  func structureDeclaration(
    operation: GraphQLAST.Operation,
    field: Field,
    fieldMaps: [FieldMap.Element],
    schemaMap: SchemaMap
  ) throws -> String {
    let operationFieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)

    let operationDefinition = try operationDefinitionGenerator.declaration(
      operation: operation,
      field: field
    )
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)
    let selectionDeclarations = try self.selectionDeclarations(fieldMaps: fieldMaps, schemaMap: schemaMap)
    let selectionFragmentMap = try self.selectionFragmentMap(fieldMaps: fieldMaps, schemaMap: schemaMap)
    let selectionDeclarationMap = self.selectionDeclarationMap(fieldMaps: fieldMaps)
    let memberwiseInitializerDeclaration = try self.memberwiseInitializerDeclaration(
      fieldMaps: fieldMaps,
      operation: operation,
      schemaMap: schemaMap
    )

    let code = """
    // MARK: - Selections

    struct \(selectionsName): \(entityNameMap.selections) {
      \(operationDefinition)

      \(selectionDeclarations)

      \(memberwiseInitializerDeclaration)

      func declaration() -> String {
        \(selectionFragmentMap)

        \(selectionDeclarationMap)

        return declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: "\(operationFieldScalarType.pascalCase)Fragment"
        )
      }
    }
    """
    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw SelectionsGeneratorError
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

// MARK: - ObjectType

private extension ObjectType {
  func nestedFields(objects: [ObjectType], scalarMap: ScalarMap) throws -> FieldMap {
    let fieldMap = try fields.flatMap {
      try $0.nestedFields(objects: objects, scalarMap: scalarMap, excluded: [])
    }.toDictionary(with: { (try? $0.type.namedType.scalarType(scalarMap: scalarMap)) ?? $0.name })

    return fieldMap
  }
}

// MARK: - Fields

extension SelectionsGenerator {
  func selectionDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    let fields = try field.returnTypeSelectableFields(
      schemaMap: schemaMap,
      selectionMap: selectionMap
    )

    if fields.isEmpty {
      return ""
    }

    let selectionVariableName = try variableName(for: field)
    let selectionEnumName = try entityNameProvider.selectionName(for: field)

    let result = """
    let \(selectionVariableName): Set<\(selectionEnumName)>
    """

    return result
  }
}

// MARK: - [FieldMap.Element]

extension SelectionsGenerator {
  func selectionDeclarations(
    fieldMaps: [FieldMap.Element],
    schemaMap: SchemaMap
  ) throws -> String {
    try fieldMaps.map {
      try selectionDeclaration(field: $0.value, schemaMap: schemaMap)
    }.lines
  }

  func selectionFragmentMap(
    fieldMaps: [FieldMap.Element],
    schemaMap: SchemaMap
  ) throws -> String {
    try fieldMaps.map {
      let interfaceFragmentCode: String
      let requiredFields = "\t\\(\(try entityNameProvider.selectionName(for: $0.value)).requiredDeclaration)"

      let returnTypeSelectableFields = try $0.value.returnTypeSelectableFields(
        schemaMap: schemaMap,
        selectionMap: selectionMap
      )

      if let possibleObjectTypes = try $0.value.possibleObjectTypes(
        schemaMap: schemaMap
      ) {
        interfaceFragmentCode = """
        \t__typename\n\t\(
          possibleObjectTypes.map {
            """
            ...\($0.name)Fragment
            """
          }.joined(separator: "\n\t")
        )
        """
      } else {
        interfaceFragmentCode = ""
      }

      let selectionDeclaration = returnTypeSelectableFields.isEmpty
        ? ""
        : "\t\\(\($0.key.camelCase)Selections.declaration)"

      let fragmentContent: [String] = [
        requiredFields,
        selectionDeclaration,
        interfaceFragmentCode
      ].filter { !$0.isEmpty }

      let fragmentContentCode = fragmentContent.compactMap { $0 }.lines

      return """
      let \($0.key.camelCase)SelectionsDeclaration = \"\"\"
      fragment \($0.key.pascalCase)Fragment on \($0.key.pascalCase) {
      \(fragmentContentCode)
      }
      \"\"\"\n
      """
    }.lines
  }

  func memberwiseInitializerDeclaration(
    fieldMaps: [FieldMap.Element],
    operation: GraphQLAST.Operation,
    schemaMap: SchemaMap
  ) throws -> String {
    let filteredElements = try fieldMaps.compactMap { element -> FieldMap.Element? in
      let fields = try element.value.returnTypeSelectableFields(
        schemaMap: schemaMap,
        selectionMap: selectionMap
      )

      guard !fields.isEmpty else { return nil }

      return element
    }

    guard !filteredElements.isEmpty else {
      return "init() {}"
    }

    let arguments = try filteredElements.map {
      let selectionName = try entityNameProvider.selectionName(for: $0.value)
      let variableName = try self.variableName(for: $0.value)
      return "\(variableName): Set<\(selectionName)> = .allFields"
    }.joined(separator: ",\n")
    let assignments = filteredElements.map {
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

  func selectionDeclarationMap(fieldMaps: [FieldMap.Element]) -> String {
    let selectionDeclarationMapValues = fieldMaps.enumerated().map { (index, element) -> String in
      var text = "\"\(element.key.pascalCase)Fragment\": \(element.key.camelCase)SelectionsDeclaration"

      if index < fieldMaps.count - 1 {
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

// MARK: - Naming

private extension SelectionsGenerator {
  func variableName(for field: Field) throws -> String {
    let returnName = try field.type.namedType.scalarType(scalarMap: scalarMap)

    return "\(returnName.camelCase)Selections"
  }
}
