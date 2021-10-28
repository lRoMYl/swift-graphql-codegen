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
import GraphQLCodegenUtil

enum SelectionsGeneratorError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)
  case formatError(context: String)
  case missingFragment(context: String)

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

  private let operationDefinitionGenerator: RequestOperationDefinitionGenerator

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
      selectionMap: selectionMap,
      entityNameProvider: entityNameProvider
    )

    operationDefinitionGenerator = RequestOperationDefinitionGenerator(
      variablesGenerator: requestParameterVariablesGenerator,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    try schema.operations.map { operation in
      let fields = operation.type.fields
      var selections = try fields.map { field in
        try code(operation: operation, field: field, schema: schema)
      }

      selections.insert(try code(operation: operation, schema: schema), at: 0)

      return selections.lines
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

  func code(operation: GraphQLAST.Operation, schema: Schema) throws -> String {
    let objectTypeMap = ObjectTypeMap(schema: schema)
    let objects = schema.objects.filter { !$0.isOperation }.sorted()

    let arguments = try objects.compactMap {
      let selectionName = try entityNameProvider.selectionName(for: $0)

      return "\($0.name.camelCase): Set<\(selectionName)> = .allFields"
    }.joined(separator: ",\n")

    let assignments = objects.map {
      "self.\($0.name.camelCase) = \($0.name.camelCase)"
    }.lines

    let structures = schema.objects.filter { !$0.isOperation } as [Structure]
      + schema.interfaces as [Structure]
      + schema.unions as [Structure]

    let selectionFragmentMap = try structures.map {
      let possibleTypes = $0.possibleTypes
      let selectableDeclaration = $0.isCompositeType || $0.selectableFields(selectionMap: selectionMap).isEmpty
        ? ""
        : "\t\\(\($0.name.camelCase).declaration)"
      let fragmentDeclaration: String

      if possibleTypes.count > 1 {
        fragmentDeclaration = """
        \t__typename
        \(
          try possibleTypes.map { possibleType in
            let objectType = try possibleType.objectType(objectTypeMap: objectTypeMap)
            return "\t...\(try entityNameProvider.fragmentName(for: objectType))"
          }.lines
        )
        """
      } else {
        fragmentDeclaration = ""
      }

      let fragmentContent: [String] = [
        selectableDeclaration,
        fragmentDeclaration
      ].filter { !$0.isEmpty }

      return try """
      let \($0.name.camelCase)Declaration = \"\"\"
      fragment \(try entityNameProvider.fragmentName(for: $0)) on \($0.name) {
      \(fragmentContent.lines)
      }
      \"\"\"
      """.format()
    }.lines

    let selectionDeclarationMap = """
    let selectionDeclarationMap = [
      \(
        try structures.map {
          "\"\(try entityNameProvider.fragmentName(for: $0))\": \($0.name.camelCase)Declaration"
        }.joined(separator: ",\n")
      )
    ]
    """

    return """
    struct \(try entityNameProvider.selectionsName(with: operation)): \(entityNameMap.selections) {
      \(
        try objects.compactMap {
          let selectionName = try entityNameProvider.selectionName(for: $0)

          return """
          let \($0.name.camelCase): Set<\(selectionName)>
          """
        }.lines
      )

      private let operationDefinitionFormat: String = "%@"

      func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
        String(
          format: operationDefinitionFormat,
          declaration(with: rootSelectionKeys)
        )
      }

      init(
        \(arguments)
      ) {
        \(assignments)
      }

      func declaration(with rootSelectionKeys: Set<String>) -> String {
        \(selectionFragmentMap)

        \(selectionDeclarationMap)

        let fragmentMaps = rootSelectionKeys
          .map {
            declaration(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }

        return fragmentMaps.values.joined(separator: "\\n")
      }
    }
    """
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

    let nestedFields = try returnObjectType
      .nestedFields(objects: schemaMap.schema.objects, scalarMap: scalarMap, selectionMap: selectionMap)

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: nestedFields,
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

    var nestedFields = [Field(with: returnInterfaceType)]
    try possibleObjectTypes.forEach {
      nestedFields.append(
        contentsOf: try $0.nestedFields(
          objects: schemaMap.schema.objects,
          scalarMap: scalarMap,
          selectionMap: selectionMap
        )
      )
    }
    nestedFields = nestedFields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: .namedType)

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: nestedFields,
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

    var nestedFields = [Field(with: returnUnionType)]
    try possibleObjectTypes.forEach {
      nestedFields.append(
        contentsOf: try $0.nestedFields(
          objects: schemaMap.schema.objects,
          scalarMap: scalarMap,
          selectionMap: selectionMap
        )
      )
    }
    nestedFields = nestedFields
      .unique(by: { $0.type.namedType.name })
      .sorted(by: .namedType)

    return try structureDeclaration(
      operation: operation,
      field: field,
      fieldMaps: nestedFields,
      schemaMap: schemaMap
    )
  }

  func emptyDeclaration(operation: GraphQLAST.Operation, field: Field) throws -> String {
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)

    return """
    // MARK: - Selections

    struct \(selectionsName): \(entityNameMap.selections) {
      func declaration(with _: Set<String>) -> String {
        \"\"
      }
    }
    """
  }

  func structureDeclaration(
    operation: GraphQLAST.Operation,
    field: Field,
    fieldMaps: [Field],
    schemaMap: SchemaMap
  ) throws -> String {
    let fieldMaps = fieldMaps.sorted(by: { $0.type.namedType.name < $1.type.namedType.name })
    let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)
    let selectionDeclarations = try self.selectionDeclarations(fieldMaps: fieldMaps, schemaMap: schemaMap)
    let selectionFragmentMap = try self.selectionFragmentMap(fieldMaps: fieldMaps, schemaMap: schemaMap)
    let selectionDeclarationMap = try self.selectionDeclarationMap(fieldMaps: fieldMaps)
    let memberwiseInitializerDeclaration = try self.memberwiseInitializerDeclaration(
      fieldMaps: fieldMaps,
      operation: operation,
      schemaMap: schemaMap
    )

    let code = """
    // MARK: - Selections

    struct \(selectionsName): \(entityNameMap.selections) {
      \(selectionDeclarations)

      \(memberwiseInitializerDeclaration)

      func declaration(with rootSelectionKeys: Set<String>) -> String {
        \(selectionFragmentMap)

        \(selectionDeclarationMap)

        let fragmentMaps = rootSelectionKeys
          .map {
            declaration(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }

        return fragmentMaps.values.joined(separator: "\\n")
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
    guard let selectionEnumName = try entityNameProvider.selectionName(for: field) else {
      return ""
    }

    let result = """
    let \(selectionVariableName): Set<\(selectionEnumName)>
    """

    return result
  }
}

// MARK: - [FieldMap.Element]

extension SelectionsGenerator {
  func selectionDeclarations(
    fieldMaps: [Field],
    schemaMap: SchemaMap
  ) throws -> String {
    try fieldMaps.map {
      try selectionDeclaration(field: $0, schemaMap: schemaMap)
    }.lines
  }

  func selectionFragmentMap(
    fieldMaps: [Field],
    schemaMap: SchemaMap
  ) throws -> String {
    try fieldMaps.map {
      let interfaceFragmentCode: String

      let returnTypeSelectableFields = try $0.returnTypeSelectableFields(
        schemaMap: schemaMap,
        selectionMap: selectionMap
      )

      if let possibleObjectTypes = try $0.possibleObjectTypes(
        schemaMap: schemaMap
      ) {
        interfaceFragmentCode = """
        \t__typename\n\t\(
          try possibleObjectTypes.compactMap {
            let fragmentName = try entityNameProvider.fragmentName(for: $0)

            return """
            ...\(fragmentName)
            """
          }.joined(separator: "\n\t")
        )
        """
      } else {
        interfaceFragmentCode = ""
      }

      let fieldTypeName = $0.type.namedType.name
      let selectionDeclaration = $0.type.namedType.isCompositeType || returnTypeSelectableFields.isEmpty
        ? ""
        : "\t\\(\(fieldTypeName.camelCase)Selections.declaration)"

      let fragmentContent: [String] = [
        selectionDeclaration,
        interfaceFragmentCode
      ].filter { !$0.isEmpty }

      let fragmentContentCode = fragmentContent.compactMap { $0 }.lines

      return try """
      let \(fieldTypeName.camelCase)SelectionsDeclaration = \"\"\"
      fragment \(fieldTypeName.pascalCase)Fragment on \(fieldTypeName) {
      \(fragmentContentCode)
      }
      \"\"\"\n
      """.format()
    }.lines
  }

  func memberwiseInitializerDeclaration(
    fieldMaps: [Field],
    operation: GraphQLAST.Operation,
    schemaMap: SchemaMap
  ) throws -> String {
    let filteredElements = try fieldMaps
      .compactMap { element -> Field? in
        guard (try element.possibleObjectTypes(schemaMap: schemaMap)?.count ?? 1) <= 1 else {
          return nil
        }

        let fields = try element.returnTypeSelectableFields(
          schemaMap: schemaMap,
          selectionMap: selectionMap
        )

        guard !fields.isEmpty else { return nil }

        return element
      }

    guard !filteredElements.isEmpty else {
      return "init() {}"
    }

    let arguments = try filteredElements.compactMap {
      guard let selectionName = try entityNameProvider.selectionName(for: $0) else { return nil }
      let variableName = try self.variableName(for: $0)
      return "\(variableName): Set<\(selectionName)> = .allFields"
    }.joined(separator: ",\n")
    let assignments = try filteredElements.compactMap {
      guard
        let argumentName = try entityNameProvider.selectionsVariableName(
          for: $0.type.namedType,
          entityNameProvider: entityNameProvider
        )
      else { return nil }
      return "self.\(argumentName) = \(argumentName)"
    }.lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }

  func selectionDeclarationMap(fieldMaps: [Field]) throws -> String {
    let selectionDeclarationMapValues = try fieldMaps.compactMap { element in
      guard let fragmentName = try entityNameProvider.fragmentName(for: element.type.namedType) else { return nil }
      let selectionsDeclarationName = "\(element.type.namedType.name.camelCase)SelectionsDeclaration"
      return "\"\(fragmentName)\": \(selectionsDeclarationName)"
    }.joined(separator: ",\n")

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
