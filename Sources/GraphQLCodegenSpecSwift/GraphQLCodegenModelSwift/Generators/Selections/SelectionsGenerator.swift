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

  private let operationDefinitionGenerator: RequestQueryCodeGenerator

  private enum Variables {
    static let requestName = "requestName"
    static let capitalizedRequestName = "requestName"
    static let typeName = "typeName"
    static let selectionDeclarationMap = "selectionDeclarationMap"
    static let rootSelectionKeys = "rootSelectionKeys"
  }

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

    operationDefinitionGenerator = RequestQueryCodeGenerator(
      variablesGenerator: requestParameterVariablesGenerator,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    let codes: [String] = try schema.operations.map { operation in
      let fields = operation.type.selectableFields(selectionMap: selectionMap)
      var selections = try fields.map { field in
        try code(operation: operation, field: field, schema: schema)
      }

      selections.insert(try code(operation: operation, schema: schema), at: 0)

      return selections.lines
    }

    return """
    // MARK: - Selections

    \(codes.lines)
    """
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
    }
    .reduce([], +)
    .unique(by: { $0.type.namedType.name })
    .sorted(by: .namedType)

    let selectionDeclarations = try self.selectionDeclarations(fieldMaps: fields, schemaMap: schemaMap)
    let memberwiseInitializerDeclaration = try self.memberwiseInitializerDeclaration(
      fieldMaps: fields,
      operation: operation,
      schemaMap: schemaMap
    )
    let selectionFragmentMap = try self.selectionFragmentMap(fieldMaps: fields, schemaMap: schemaMap)

    return """
    struct \(try entityNameProvider.selectionsName(with: operation)): \(entityNameMap.selections) {
      \(selectionDeclarations)

      \(memberwiseInitializerDeclaration)

      \(selectionsFuncDeclaration()) {
        \(capitalizedRequestNameDeclaration())

        \(selectionFragmentMap)

        \(fragmentMapDeclaration())
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
      .nestedFields(
        schema: schemaMap.schema,
        scalarMap: scalarMap,
        selectionMap: selectionMap
      )

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
          schema: schemaMap.schema,
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
          schema: schemaMap.schema,
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
    struct \(selectionsName): \(entityNameMap.selections) {
      \(selectionsFuncDeclaration()) {
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
    let memberwiseInitializerDeclaration = try self.memberwiseInitializerDeclaration(
      fieldMaps: fieldMaps,
      operation: operation,
      schemaMap: schemaMap
    )

    let code = """
    struct \(selectionsName): \(entityNameMap.selections) {
      \(selectionDeclarations)

      \(memberwiseInitializerDeclaration)

      \(selectionsFuncDeclaration()) {
        \(capitalizedRequestNameDeclaration())

        \(selectionFragmentMap)

        \(fragmentMapDeclaration())
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

    guard let selectionEnumName = try entityNameProvider.selectionName(for: field) else {
      return ""
    }

    let result = """
    let \(selectionEnumName.camelCase)s: Set<\(selectionEnumName)>
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
    let test = try fieldMaps.map {
      let returnTypeSelectableFields = try $0.returnTypeSelectableFields(
        schemaMap: schemaMap,
        selectionMap: selectionMap
      )
      let fieldTypeName = $0.type.namedType.name

      if let possibleObjectTypes = try $0.possibleObjectTypes(
        schemaMap: schemaMap
      ) {
        return """
        \(entityNameProvider.requestFragmentName)(
          \(Variables.requestName): \(Variables.capitalizedRequestName),
          \(Variables.typeName): "\(fieldTypeName)",
          possibleTypeNames: [
            \t\(
              possibleObjectTypes.compactMap {
                return """
                "\($0.name)"
                """
              }.joined(separator: ",\n\t")
            )
          ]
        )
        """
      } else {
        if $0.type.namedType.isCompositeType, returnTypeSelectableFields.isEmpty {
          return ""
        } else {
          let funcDeclaration = "\(fieldTypeName.camelCase)Selections.\(entityNameProvider.requestFragmentName)"
          let requestNameDeclaration = "\(Variables.requestName): \(Variables.capitalizedRequestName)"
          let typeNameDeclaration = "\(Variables.typeName): \"\(fieldTypeName)\""

          return "\(funcDeclaration)(\(requestNameDeclaration), \(typeNameDeclaration))"
        }
      }
    }.joined(separator: ",\n")

    return try """
    let \(Variables.selectionDeclarationMap) = Dictionary(
      uniqueKeysWithValues: [
        \(test)
      ].map { ($0.key, $0.value) }
    )
    """.format()
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
      return "\(selectionName.camelCase)s: Set<\(selectionName)> = .allFields"
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

  func selectionsFuncDeclaration() -> String {
    "func requestFragments(for \(Variables.requestName): String, \(Variables.rootSelectionKeys): Set<String>) -> String"
  }

  func capitalizedRequestNameDeclaration() -> String {
    "let \(Variables.capitalizedRequestName) = \(Variables.requestName).prefix(1).uppercased() + \(Variables.requestName).dropFirst()"
  }

  func fragmentMapDeclaration() -> String {
    """
    let fragments = \(entityNameProvider.nestedRequestFragmentsName)(
      \(Variables.selectionDeclarationMap): \(Variables.selectionDeclarationMap),
      \(Variables.rootSelectionKeys): \(Variables.rootSelectionKeys)
    )
    
    return fragments.joined(separator: "\\n\\n")
    """
  }
}
