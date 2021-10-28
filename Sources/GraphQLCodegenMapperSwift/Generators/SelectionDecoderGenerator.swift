//
//  SelectionDecoderGenerator.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum SelectionDecoderGeneratorError: Error, LocalizedError {
  case missingImplementation(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingImplementation(context):
      return "\(Self.self): \(context)"
    }
  }
}

struct SelectionDecoderGenerator: Generating {
  private let entityNameProvider: EntityNameProviding
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let selectionMap: SelectionMap?

  private let genericIdentifier = "T"
  private let mapperErrorName: String

  private enum Variables {
    static let populateSelections = "populateSelections"
  }

  init(
    entityNameProvider: EntityNameProviding,
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?
  ) {
    self.entityNameProvider = entityNameProvider
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap

    self.mapperErrorName = entityNameProvider.mapperErrorName(apiClientPrefix: entityNameMap.apiClientPrefix)
  }

  func code(schema: Schema) throws -> String {
    let schemaMap = try SchemaMap(schema: schema)

    let operationCode = try schema.operations.compactMap { operation in
      try operation.type.fields.compactMap { field in
        guard
          let fieldStructure = try field.structure(schemaMap: schemaMap),
          let selectionDecoderName = try entityNameProvider.selectionDecoderName(
            field: field,
            operation: operation,
            schemaMap: schemaMap
          )
        else { return nil }

        let responseName = try entityNameProvider.name(for: field.type.namedType)

        let nestedFields: [Field] = (
          try field.nestedTypeFields(
            objects: schema.objects,
            scalarMap: scalarMap,
            excluded: [],
            selectionMap: selectionMap,
            sortType: .namedType
          )
        )

        return try code(
          selectionDecoderName: selectionDecoderName,
          responseName: responseName,
          nestedFields: nestedFields,
          structure: fieldStructure,
          schemaMap: schemaMap
        )
      }.lines
    }.lines

    let objectCode = try schema.objects.compactMap { objectType in
      guard
        !objectType.isOperation,
        let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: objectType)
      else { return nil }

      let responseName = try entityNameProvider.name(for: objectType)

      let nestedFields: [Field] = (
        try objectType.nestedFields(
          objects: schema.objects,
          scalarMap: scalarMap,
          selectionMap: selectionMap,
          sortType: .namedType
        )
      )

      return try code(
        selectionDecoderName: selectionDecoderName,
        responseName: responseName,
        nestedFields: nestedFields,
        structure: objectType,
        schemaMap: schemaMap
      )
    }.lines

    let interfaceCode = try schema.interfaces.compactMap { interfaceType in
      guard
        let selectionDecoderName = try entityNameProvider.selectionDecoderName(
          type: interfaceType
        )
      else { return nil }

      let responseName = try entityNameProvider.name(for: interfaceType)

      let possibleObjectTypes = try interfaceType.possibleTypes.compactMap {
        try $0.objectType(objectTypeMap: schemaMap.objectTypeMap)
      }
      .unique(by: { $0.name })

      let nestedFields: [Field] = try possibleObjectTypes.reduce(into: []) { result, objectType in
        result.append(Field(with: objectType))
        result.append(
          contentsOf: try objectType.nestedFields(
            objects: schema.objects,
            scalarMap: scalarMap,
            selectionMap: selectionMap
          )
        )
      }
      .unique(by: { $0.type.namedType.name })
      .sorted(by: .namedType)

      return try code(
        selectionDecoderName: selectionDecoderName,
        responseName: responseName,
        nestedFields: nestedFields,
        structure: interfaceType,
        schemaMap: schemaMap
      )
    }.lines

    let unionCode = try schema.unions.compactMap { unionType in
      guard
        let selectionDecoderName = try entityNameProvider.selectionDecoderName(
          type: unionType
        )
      else { return nil }

      let responseName = try entityNameProvider.name(for: unionType)

      let possibleObjectTypes = try unionType.possibleTypes.compactMap {
        try $0.objectType(objectTypeMap: schemaMap.objectTypeMap)
      }
      .unique(by: { $0.name })

      let nestedFields: [Field] = try possibleObjectTypes.reduce(into: []) { result, objectType in
        result.append(Field(with: objectType))
        result.append(
          contentsOf: try objectType.nestedFields(
            objects: schema.objects,
            scalarMap: scalarMap,
            selectionMap: selectionMap
          )
        )
      }
      .unique(by: { $0.type.namedType.name })
      .sorted(by: .namedType)

      return try code(
        selectionDecoderName: selectionDecoderName,
        responseName: responseName,
        nestedFields: nestedFields,
        structure: unionType,
        schemaMap: schemaMap
      )
    }.lines

    guard !(operationCode.isEmpty && objectCode.isEmpty && unionCode.isEmpty && interfaceCode.isEmpty) else {
      return ""
    }

    return [
      "// MARK: - SelectionDecoder",
      operationCode,
      objectCode,
      unionCode,
      interfaceCode
    ].lines
  }
}

private extension SelectionDecoderGenerator {
  func code(
    selectionDecoderName: String,
    responseName: String,
    nestedFields: [Field],
    structure: Structure,
    schemaMap: SchemaMap
  ) throws -> String {
    let selectionDeclaration = try self.selectionDeclaration(structure: structure, nestedFields: nestedFields)
    let fieldDeclaration = try self.fieldDeclaration(structure: structure, schemaMap: schemaMap)

    if fieldDeclaration.isEmpty {
      throw SelectionDecoderGeneratorError.missingImplementation(
        context: "Missing implementation to populate fieldCodes for \(structure.name)"
      )
    }

    let insertSelectionsDeclaration: String

    if let objectType = structure as? ObjectType {
      insertSelectionsDeclaration = """
      private func insert(selection: \(try entityNameProvider.selectionName(for: objectType))) {
        if \(Variables.populateSelections) {
          \(try entityNameProvider.selectionsVariableName(for: objectType)).insert(selection)
        }
      }
      """
    } else {
      insertSelectionsDeclaration = ""
    }

    return """
    class \(selectionDecoderName) {
      \(selectionDeclaration)
      private let response: \(responseName)
      private let \(Variables.populateSelections): Bool

      init(response: \(responseName), \(Variables.populateSelections): Bool = false) {
        self.response = response
        self.\(Variables.populateSelections) = \(Variables.populateSelections)
      }

      \(fieldDeclaration)

      \(insertSelectionsDeclaration)
    }
    """
  }

  func valueName(outputTypeRef: OutputTypeRef) -> String {
    switch outputTypeRef {
    case .named:
      return "value"
    case .list:
      return "values"
    case let .nonNull(outputRef):
      return valueName(outputTypeRef: outputRef)
    }
  }

  func unwrapFieldDeclaration(field: Field) -> String {
    let valueName = self.valueName(outputTypeRef: field.type)

    let name = field.name.camelCase
    let encodingKey = field.name

    let result = """
    let \(valueName) = try response.\(name).unwrapOrFail(context: "\(encodingKey) not found")
    """

    return result
  }

  func mapperVariableName(type: ObjectType) -> String {
    "\(type.name.camelCase)Mapper"
  }
}

// MARK: - Generate GraphQLSelection(s) code from Structure

extension SelectionDecoderGenerator {
  func selectionDeclaration(structure: Structure, nestedFields: [Field]) throws -> String {
    if structure.isCompositeType {
      return try structure.possibleTypes.compactMap { possibleTypeRef in
        let selectionName = try entityNameProvider.selectionName(for: possibleTypeRef)
        let selectionsVariableName = try entityNameProvider.selectionsVariableName(
          for: possibleTypeRef
        )

        return """
        private(set) var \(selectionsVariableName) = Set<\(selectionName)>()
        """
      }.lines
    } else {
      return try nestedFields.compactMap {
        guard
          let selectionName = try entityNameProvider.selectionName(for: $0),
          let selectionsVariableName = try entityNameProvider.selectionsVariableName(
            for: $0.type.namedType,
            entityNameProvider: entityNameProvider
          )
        else { return nil }

        return """
      private(set) var \(selectionsVariableName) = Set<\(selectionName)>()
      """
      }.lines
    }
  }
}

// MARK: - Generate code from Struture

extension SelectionDecoderGenerator {
  func fieldDeclaration(structure: Structure, schemaMap: SchemaMap) throws -> String {
    if structure.isCompositeType {
      switch structure {
      case let unionType as UnionType:
        let field = Field(with: unionType)
        return try fieldDeclaration(structure: structure, field: field, schemaMap: schemaMap)
      case let interfaceType as InterfaceType:
        let field = Field(with: interfaceType)
        return try fieldDeclaration(structure: structure, field: field, schemaMap: schemaMap)
      default:
        throw SelectionDecoderGeneratorError.missingImplementation(
          context: "Missing \(#function) implementation to handle structure type for \(structure.name)"
        )
      }
    } else {
      return try structure.selectableFields(selectionMap: selectionMap)
        .compactMap { field in
          try fieldDeclaration(structure: structure, field: field, schemaMap: schemaMap)
        }
        .joined(separator: "\n\n")
    }
  }

  func fieldDeclaration(structure: Structure, field: Field, schemaMap: SchemaMap) throws -> String {
    switch structure {
    case let objectType as ObjectType:
      return try fieldDeclaration(objectType: objectType, field: field, schemaMap: schemaMap)
    case let interfaceType as InterfaceType:
      return try fieldDeclaration(interfaceType: interfaceType, field: field, schemaMap: schemaMap)
    case let unionType as UnionType:
      return try fieldDeclaration(unionType: unionType, field: field, schemaMap: schemaMap)
    default:
      throw SelectionDecoderGeneratorError.missingImplementation(
        context: "Missing \(#function) implementation to handle structure type for \(structure.name)"
      )
    }
  }

  func fieldDeclaration(objectType: ObjectType, field: Field, schemaMap: SchemaMap) throws -> String {
    let name = field.name.camelCase

    let funcDeclaration = try self.funcDeclaration(field: field, schemaMap: schemaMap)
    let selectionsVariableName = """
    insert(selection: .\(name))
    """
    let unwrapFieldDeclaration = self.unwrapFieldDeclaration(field: field)
    let returnDeclaration = try self.returnDeclaration(
      field: field,
      outputTypeRef: field.type,
      schemaMap: schemaMap
    )

    let codes = [
      selectionsVariableName,
      unwrapFieldDeclaration,
      returnDeclaration
    ]
    .compactMap { $0 }
    .joined(separator: "\n\n")

    return """
    \(funcDeclaration) {
      \(codes)
    }
    """
  }

  func fieldDeclaration(interfaceType: InterfaceType, field: Field, schemaMap: SchemaMap) throws -> String {
    let functionDeclaration = try self.funcDeclaration(field: field, schemaMap: schemaMap)
    let returnDeclaration = try compositeReturnDeclaration(field: field, schemaMap: schemaMap)

    return """
    \(functionDeclaration) {
      \(returnDeclaration)
    }
    """
  }

  func fieldDeclaration(unionType: UnionType, field: Field, schemaMap: SchemaMap) throws -> String {
    let functionDeclaration = try self.funcDeclaration(field: field, schemaMap: schemaMap)
    let returnDeclaration = try compositeReturnDeclaration(field: field, schemaMap: schemaMap)

    return """
    \(functionDeclaration) {
      \(returnDeclaration)
    }
    """
  }
}

// MARK: - Generate code to decode and return the response

private extension SelectionDecoderGenerator {
  func returnDeclaration(
    field: Field,
    outputTypeRef: OutputTypeRef,
    schemaMap: SchemaMap
  ) throws -> String {
    return try returnDeclaration(
      field: field,
      invertedOutputTypeRef: outputTypeRef.inverted,
      schemaMap: schemaMap
    )
  }

  func returnDeclaration(field: Field, invertedOutputTypeRef: InvertedOutputTypeRef, schemaMap: SchemaMap) throws -> String {
    switch invertedOutputTypeRef {
    case .named:
      return try returnDeclaration(field: field, schemaMap: schemaMap)
    case let .list(invertedOutputTypeRef):
      let valueName = self.valueName(outputTypeRef: invertedOutputTypeRef.inverted)
      return """
      return try values.compactMap { \(valueName) in
        \(try returnDeclaration(field: field, invertedOutputTypeRef: invertedOutputTypeRef, schemaMap: schemaMap))
      }
      """
    case let .nullable(invertedOutputTypeRef):
      let valueName = self.valueName(outputTypeRef: invertedOutputTypeRef.inverted)
      return """
      if let \(valueName) = \(valueName) {
        \(try returnDeclaration(field: field, invertedOutputTypeRef: invertedOutputTypeRef, schemaMap: schemaMap))
      } else {
        return nil
      }
      """
    }
  }

  func returnDeclaration(
    field: Field,
    schemaMap: SchemaMap
  ) throws -> String {
    let outputRef = field.type.namedType
    let isPrimitive = try outputRef.isPrimitive(scalarMap: scalarMap)

    if isPrimitive {
      return "return value"
    } else {
      if
        let selectionDecoderName = try entityNameProvider.selectionDecoderName(outputRef: outputRef)
      {
        let nestedFields = try field.nestedTypeFields(
          objects: schemaMap.schema.objects,
          scalarMap: scalarMap,
          excluded: [],
          selectionMap: selectionMap
        )

        let selectionsDeclarations = try nestedFields.compactMap { field in
          guard
            let selectionsVariableName = try entityNameProvider.selectionsVariableName(
              for: field.type.namedType,
              entityNameProvider: entityNameProvider
            )
          else {
            return nil
          }

          return """
          \(selectionsVariableName) = decoder.\(selectionsVariableName)
          """
        }.joined(separator: "\n")

        return """
        let decoder = \(selectionDecoderName)(
          response: value,
          \(Variables.populateSelections): \(Variables.populateSelections)
        )
        let result = try mapper(decoder)

        \(selectionsDeclarations)

        return result
        """
      } else {
        return "return try mapper(value)"
      }
    }
  }

  func compositeReturnDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    guard let possibleObjects = try field.possibleObjectTypes(schemaMap: schemaMap) else {
      throw SelectionDecoderGeneratorError.missingImplementation(
        context: "\(#function) expecting possibleObject for composite type"
      )
    }

    let sortedPossibleObjects = possibleObjects.sorted()

    let decoderCode = try sortedPossibleObjects.compactMap {
      guard let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: $0) else {
        throw SelectionDecoderGeneratorError.missingImplementation(
          context: "\(#function) expecting decoderName for objectType \($0.name)"
        )
      }

      let enumName = $0.name.camelCase

      return """
        case let .\(enumName)(\(enumName)):
          let decoder = \(selectionDecoderName)(response: \(enumName))
          return try \(mapperVariableName(type: $0))(decoder)
        """
    }.joined(separator: "\n")

    return """
    switch response {
      \(decoderCode)
    }
    """
  }
}

// MARK: - Func declaration

extension SelectionDecoderGenerator {
  func funcDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    let isPrimitive = try field.type.inverted.isPrimitive(scalarMap: scalarMap)
    let isComposite = field.type.inverted.isComposite

    if isPrimitive {
      return try primitiveFuncDeclaration(field: field)
    } else {
      return isComposite
        ? try compositeFuncDeclaration(field: field, schemaMap: schemaMap)
        : try genericFuncDeclaration(field: field, schemaMap: schemaMap)
    }
  }

  func primitiveFuncDeclaration(field: Field) throws -> String {
    let name = field.name.camelCase
    let returnType = try entityNameProvider.name(for: field.type)

    return """
    func \(name)() throws -> \(returnType)
    """
  }

  func compositeFuncDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    guard let possibleTypes = try field.possibleObjectTypes(schemaMap: schemaMap), !possibleTypes.isEmpty else {
      throw SelectionDecoderGeneratorError.missingImplementation(
        context: "\(#function) expecting objectTypes for composite field"
      )
    }

    let sortedPossibleTypes = possibleTypes.sorted()
    let name = field.name.camelCase
    let returnType = try entityNameProvider.genericName(for: field.type, identifier: genericIdentifier)

    let mapperCode = try sortedPossibleTypes.compactMap {
      guard let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: $0) else {
        throw SelectionDecoderGeneratorError.missingImplementation(
          context: "\(#function) expecting decoderName for objectType \($0.name)"
        )
      }

      return "\(mapperVariableName(type: $0)): (\(selectionDecoderName)) throws -> \(genericIdentifier)"
    }.joined(separator: ",\n")

    return """
    func \(name)<\(genericIdentifier)>(
      \(mapperCode)
    ) throws -> \(returnType)
    """
  }

  func genericFuncDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    let name = field.name.camelCase
    let returnType = try entityNameProvider.genericName(for: field.type, identifier: genericIdentifier)
    let mapperCode: String

    if let returnObjectType = try field.returnObjectType(schemaMap: schemaMap) {
      guard let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: returnObjectType) else {
        throw SelectionDecoderGeneratorError.missingImplementation(
          context: "Missing decoder name implemantation at \(#function)"
        )
      }

      mapperCode = selectionDecoderName
    } else {
      mapperCode = try entityNameProvider.name(for: field.type.namedType)
    }

    return "func \(name)<\(genericIdentifier)>(mapper: (\(mapperCode)) throws -> \(genericIdentifier)) throws -> \(returnType)"
  }
}
