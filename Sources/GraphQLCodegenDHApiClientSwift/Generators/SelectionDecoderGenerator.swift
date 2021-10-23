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

    let objectCode = try schema.objects.compactMap { object in
      guard !object.isOperation, !object.isInternal else { return nil }

      let selectionDecoderName = try entityNameProvider.selectionDecoderName(type: object)
      let selectionName = try entityNameProvider.selectionName(for: object)
      let responseName = try entityNameProvider.name(for: object)

      let fieldCodes = try object.fields.map { field in
        return try code(field: field, schemaMap: schemaMap)
      }.joined(separator: "\n\n")

      return """
      class \(selectionDecoderName) {
        private(set) var selections = Set<\(selectionName)>()
        private let response: \(responseName)

        init(response: \(responseName)) {
          self.response = response
        }

        \(fieldCodes)
      }
      """
    }.lines

    return [
      "// MARK: - ResponseSelectionDecoder",
      objectCode
    ].lines
  }
}

private extension SelectionDecoderGenerator {
  func code(field: Field, schemaMap: SchemaMap) throws -> String {
    let name = field.name.camelCase

    let funcDeclaration = try self.funcDeclaration(field: field, schemaMap: schemaMap)
    let unwrapFieldDeclaration = self.unwrapFieldDeclaration(field: field)
    let returnDeclaration = try self.returnDeclaration(
      field: field,
      outputTypeRef: field.type,
      schemaMap: schemaMap
    )

    return """
    \(funcDeclaration) {
      selections.insert(.\(name))

      \(unwrapFieldDeclaration)

      \(returnDeclaration)
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
    case let .named(outputRef):
      return try returnDeclaration(field: field, outputRef: outputRef, scalarMap: scalarMap)
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

  func returnDeclaration(field: Field, outputRef: OutputRef, scalarMap: ScalarMap) throws -> String {
    let isPrimitive = try outputRef.isPrimitive(scalarMap: scalarMap)

    if isPrimitive {
      return "return value"
    } else {
      if let selectionDecoderName = try entityNameProvider.selectionDecoderName(outputRef: outputRef) {
        return """
        let decoder = \(selectionDecoderName)(response: value)
        return try mapper(decoder)
        """
      } else {
        return "return try mapper(value)"
      }
    }
  }
}
