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

  func code(field: Field, schema: Schema) throws -> String {
    let namedType = field.type.namedType
    let interfaceTypeMap = InterfaceTypeMap(schema: schema)
    let objectTypeMap = ObjectTypeMap(schema: schema)
    let unionTypeMap = UnionTypeMap(schema: schema)

    switch namedType {
    case .object:
      return try objectDeclaration(
        field: field,
        schema: schema,
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap
      )
    case .enum, .scalar:
      return emptyDeclaration(field: field)
    case .interface:
      return try interfaceDeclaration(
        field: field,
        schema: schema,
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap
      )
    case .union:
      return try unionDeclaration(
        field: field,
        schema: schema,
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap
      )
    }
  }
}

// MARK: - RequestParameterSelectionsGenerator

extension RequestParameterSelectionsGenerator {
  func objectDeclaration(
    field: Field,
    schema: Schema,
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap
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
      objectTypeMap: ObjectTypeMap(schema: schema),
      interfaceTypeMap: InterfaceTypeMap(schema: schema),
      unionTypeMap: unionTypeMap
    )
  }

  func interfaceDeclaration(
    field: Field,
    schema: Schema,
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap
  ) throws -> String {
    guard
      let returnInterfaceType = try interfaceTypeMap.value(from: field.type.namedType),
			let possibleObjectTypes = try field.possibleObjectTypes(
				objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
				entityNameProvider: entityNameProvider
			)
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No InterfaceType type found for field \(field.name)")
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

			fieldMap.merge(try $0.nestedFields(objects: schema.objects, scalarMap: scalarMap)) { _, new in new }
		}

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objectTypeMap: ObjectTypeMap(schema: schema),
      interfaceTypeMap: InterfaceTypeMap(schema: schema),
      unionTypeMap: unionTypeMap
    )
  }

  func unionDeclaration(
    field: Field,
    schema: Schema,
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap
  ) throws -> String {
    guard
      let returnUnionType = try unionTypeMap.value(from: field.type.namedType),
      let possibleObjectTypes = try field.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
        entityNameProvider: entityNameProvider
      )
    else {
      throw RequestParameterSelectionsError.missingReturnType(context: "No UnionType type found for field \(field.name)")
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

      fieldMap.merge(try $0.nestedFields(objects: schema.objects, scalarMap: scalarMap)) { _, new in new }
    }

    // Sort field map to ensure the generated code sequence is always consistent
    let sortedFieldMap = fieldMap.sorted(by: { $0.key < $1.key })

    return try structureDeclaration(
      field: field,
      fieldMaps: sortedFieldMap,
      objectTypeMap: ObjectTypeMap(schema: schema),
      interfaceTypeMap: InterfaceTypeMap(schema: schema),
      unionTypeMap: UnionTypeMap(schema: schema)
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
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap
  ) throws -> String {
    let operationFieldScalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)

    let selectionDeclarations = try fieldMaps.selectionDeclarations(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      unionTypeMap: unionTypeMap,
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )

    let selectionFragmentMap = try fieldMaps.selectionFragmentMap(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      unionTypeMap: unionTypeMap,
      entityNameProvider: entityNameProvider,
			selectionMap: selectionMap
    )
    let selectionDeclarationMap = fieldMaps.selectionDeclarationMap
    let memberwiseInitializerDeclaration = try fieldMaps.memberwiseInitializerDeclaration(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      unionTypeMap: unionTypeMap,
      entityNameProvider: entityNameProvider,
      selectionMap: selectionMap
    )

    let code = """
    // MARK: - Selections

    let selections: Selections

    struct Selections: \(entityNameMap.selections) {
      \(selectionDeclarations)

      \(memberwiseInitializerDeclaration)

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

fileprivate extension Field {
  func returnTypeSelectableFields(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    entityNameProvider: EntityNameProviding,
    selectionMap: SelectionMap?
  ) throws -> [Field] {
    guard
      let returnType = try structure(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap
      )
    else { return [] }

    return returnType.selectableFields(selectionMap: selectionMap)
  }

  func selectionDeclaration(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) throws -> String {
    let returnName = try type.namedType.scalarType(scalarMap: scalarMap)

    let fields = try returnTypeSelectableFields(
      objectTypeMap: objectTypeMap,
      interfaceTypeMap: interfaceTypeMap,
      unionTypeMap: unionTypeMap,
      entityNameProvider: entityNameProvider,
      selectionMap: selectionMap
    )

    if fields.isEmpty {
      return ""
    }

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
    unionTypeMap: UnionTypeMap,
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameProvider: EntityNameProviding
  ) throws -> String {
    try map {
      try $0.value.selectionDeclaration(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
        scalarMap: scalarMap,
        selectionMap: selectionMap,
        entityNameMap: entityNameMap,
        entityNameProvider: entityNameProvider
      )
    }.lines
  }

  func selectionFragmentMap(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    entityNameProvider: EntityNameProviding,
		selectionMap: SelectionMap?
  ) throws -> String {
    try map {
      let interfaceFragmentCode: String

			let structure = try $0.value.structure(
				objectTypeMap: objectTypeMap,
				interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap
			)

			let requiredFields = structure?
        .requiredFields(selectionMap: selectionMap)
        .enumerated()
        .map {
          // Add newline if its the first element
          let prefix = $0.offset == 0 ? "\n\t" : "\t"
          return prefix + $0.element.name
        }
        .lines ?? ""

      let returnTypeSelectableFields = try $0.value.returnTypeSelectableFields(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
        entityNameProvider: entityNameProvider,
        selectionMap: selectionMap
      )

      if let possibleObjectTypes = try $0.value.possibleObjectTypes(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
        entityNameProvider: entityNameProvider
      ) {
        interfaceFragmentCode = """
        \n\t__typename\n\t\(
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

      return """
      let \($0.key.camelCase)SelectionsDeclaration = \"\"\"
      fragment \($0.key.pascalCase)Fragment on \($0.key.pascalCase) {\(requiredFields)
      \(selectionDeclaration)\(interfaceFragmentCode)
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

  func memberwiseInitializerDeclaration(
    objectTypeMap: ObjectTypeMap,
    interfaceTypeMap: InterfaceTypeMap,
    unionTypeMap: UnionTypeMap,
    entityNameProvider: EntityNameProviding,
    selectionMap: SelectionMap?
  ) throws -> String {
    let filteredElements = try compactMap { element -> FieldMap.Element? in
      let fields = try element.value.returnTypeSelectableFields(
        objectTypeMap: objectTypeMap,
        interfaceTypeMap: interfaceTypeMap,
        unionTypeMap: unionTypeMap,
        entityNameProvider: entityNameProvider,
        selectionMap: selectionMap
      )

      guard !fields.isEmpty else { return nil }

      return element
    }

    guard !filteredElements.isEmpty else {
      return "init() {}"
    }

    let arguments = filteredElements.map {
      "\($0.key.camelCase)Selections: Set<\($0.value.type.namedType.name)Selection> = []"
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
}
