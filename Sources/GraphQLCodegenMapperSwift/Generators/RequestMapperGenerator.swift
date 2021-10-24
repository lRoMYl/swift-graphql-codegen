//
//  File.swift
//  
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import GraphQLCodegenNameSwift

struct RequestMapperGenerator: Generating {
  private let entityNameProvider: EntityNameProviding
  private let scalarMap: ScalarMap

  private enum Constants {
    static let mapperBlock = "MapperBlock"
  }

  init(entityNameProvider: EntityNameProviding, scalarMap: ScalarMap) {
    self.entityNameProvider = entityNameProvider
    self.scalarMap = scalarMap
  }

  func code(schema: Schema) throws -> String {
    let schemaMap = try SchemaMap(schema: schema)

    let comment = "// MARK: - Mappers"
    let codes: String = try schema.operations.compactMap { operation in
      try operation.type.fields.compactMap { field in
        guard
          let selectionDecoder = try entityNameProvider.selectionDecoderName(field: field, operation: operation, schemaMap: schemaMap)
        else { return nil }
        let mapperName = try entityNameProvider.mapperName(for: field, operation: operation)
        let selectionsName = try entityNameProvider.selectionsName(for: field, operation: operation)
        let responseName = try entityNameProvider.name(for: field.type.namedType)

        let nestedFields: [Field] = (
          try field.nestedFields(objects: schema.objects, scalarMap: scalarMap, excluded: [])
        )

        let selectionsMemberwiseInitializer = try nestedFields.compactMap { field in
          guard
            let selectionsName = try entityNameProvider.selectionsVariableName(
              for: field.type.namedType,
              entityNameProvider: entityNameProvider
            )?.camelCase
          else { return nil }

          return """
          \(selectionsName): decoder.\(selectionsName)
          """
        }.joined(separator: ",\n")

        return """
        struct \(mapperName)<T> {
          typealias \(Constants.mapperBlock) = (\(selectionDecoder)) throws -> T
          private let block: \(Constants.mapperBlock)

          let selections: \(selectionsName)

          init(_ block: @escaping \(Constants.mapperBlock)) {
            self.block = block

            let decoder = \(selectionDecoder)(response: .selectionMock(), populateSelections: true)

            do {
              _ = try block(decoder)
            } catch {
              assertionFailure("Failed to mock serialization")
            }

            self.selections = \(selectionsName)(
              \(selectionsMemberwiseInitializer)
            )
          }

          func map(response: \(responseName)) throws -> T {
            try block(\(selectionDecoder)(response: response))
          }
        }
        """
      }.lines
    }.lines

    guard !codes.isEmpty else { return "" }

    return [
      comment,
      codes
    ].joined(separator: "\n\n")
  }
}
