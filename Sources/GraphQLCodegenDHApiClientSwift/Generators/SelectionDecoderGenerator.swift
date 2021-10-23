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

enum SelectionDecoderGeneratorError: Error {
}

struct SelectionDecoderGenerator: Generating {
  private let entityNameProvider: EntityNameProviding
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  private let genericIdentifier = "T"
  private let apiClientErrorName: String

  private enum Variables {
    static let populateSelections = "populateSelections"
  }

  init(
    entityNameProvider: EntityNameProviding,
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap
  ) {
    self.entityNameProvider = entityNameProvider
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap

    self.apiClientErrorName = entityNameMap.apiClientErrorName(apiClientPrefix: entityNameMap.apiClientPrefix)
  }

  func code(schema: Schema) throws -> String {
    let schemaMap = try SchemaMap(schema: schema)

    let operationCode = try schema.operations.compactMap { operation in
      try operation.type.fields.compactMap { field in
        guard
          let selectionDecoderName = try entityNameProvider.selectionDecoderName(
            field: field,
            operation: operation,
            schemaMap: schemaMap
          )
        else { return nil }
        let responseName = try entityNameProvider.name(for: field.type.namedType)

        let nestedFields: [Field] = (
          try field.nestedFields(objects: schema.objects, scalarMap: scalarMap, excluded: [])
        ).sorted(by: { $0.name < $1.name })

        let returnObjectType = try field.returnObjectType(schemaMap: schemaMap)

        return try code(
          selectionDecoderName: selectionDecoderName,
          responseName: responseName,
          nestedFields: nestedFields,
          objectType: returnObjectType,
          schemaMap: schemaMap
        )
      }.lines
    }.lines

    let objectCode = try schema.objects.compactMap { objectType in
      guard !objectType.isOperation, !objectType.isInternal else { return nil }

      let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: objectType)
      let responseName = try entityNameProvider.name(for: objectType)

      let nestedFields: [Field] = (
        try objectType.nestedFields(objects: schema.objects, scalarMap: scalarMap)
      ).sorted(by: { $0.name < $1.name })

      return try code(
        selectionDecoderName: selectionDecoderName,
        responseName: responseName,
        nestedFields: nestedFields,
        objectType: objectType,
        schemaMap: schemaMap
      )
    }.lines

    return [
      "// MARK: - SelectionDecoder",
      operationCode,
      objectCode
    ].lines
  }
}

private extension SelectionDecoderGenerator {
  func code(
    selectionDecoderName: String,
    responseName: String,
    nestedFields: [Field],
    objectType: ObjectType?,
    schemaMap: SchemaMap
  ) throws -> String {
    let selectionDeclaration = try nestedFields.compactMap {
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

    let fieldCodes = try objectType?.fields.compactMap { field in
      guard let objectType = objectType else { return nil }
      return try code(objectType: objectType, field: field, schemaMap: schemaMap)
    }.joined(separator: "\n\n") ?? ""

    return """
    class \(selectionDecoderName) {
      \(selectionDeclaration)
      private let response: \(responseName)
      private let \(Variables.populateSelections): Bool

      init(response: \(responseName), \(Variables.populateSelections): Bool = false) {
        self.response = response
        self.\(Variables.populateSelections) = \(Variables.populateSelections)
      }

      \(fieldCodes)
    }
    """
  }

  func code(objectType: ObjectType, field: Field, schemaMap: SchemaMap) throws -> String {
    let name = field.name.camelCase

    let funcDeclaration = try self.funcDeclaration(field: field, schemaMap: schemaMap)
    let selectionsVariableName = """
    if \(Variables.populateSelections) {
      \(try entityNameProvider.selectionsVariableName(for: objectType)).insert(.\(name))
    }
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

  func funcDeclaration(field: Field, schemaMap: SchemaMap) throws -> String {
    let name = field.name.camelCase
    let isPrimitive = try field.type.inverted.isPrimitive(scalarMap: scalarMap)
    let returnType = isPrimitive
      ? try entityNameProvider.name(for: field.type)
      : try entityNameProvider.genericName(for: field.type, identifier: genericIdentifier)

    if isPrimitive {
      return """
      func \(name)() throws -> \(returnType)
      """
    } else {
      let mapperCode: String

      if let returnObjectType = try field.returnObjectType(schemaMap: schemaMap) {
        mapperCode = try entityNameProvider.selectionDecoderName(type: returnObjectType)
      } else {
        mapperCode = try entityNameProvider.name(for: field.type.namedType)
      }

      return """
      func \(name)<\(genericIdentifier)>(mapper: (\(mapperCode)) throws -> \(genericIdentifier)) throws -> \(returnType)
      """
    }
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
    guard let \(valueName) = response.\(name) else {
      throw \(apiClientErrorName).missingData(context: "\(encodingKey) not found")
    }
    """

    if result.contains("response.launches") {

    }

    return result
  }

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
        let nestedFields = try field.nestedFields(objects: schemaMap.schema.objects, scalarMap: scalarMap, excluded: [])
          .sorted(by: { $0.name < $1.name })
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
        let decoder = \(selectionDecoderName)(response: value, \(Variables.populateSelections): \(Variables.populateSelections))
        let result = try mapper(decoder)

        \(selectionsDeclarations)

        return result
        """
      } else {
        return "return try mapper(value)"
      }
    }
  }
}
