//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

enum ObjectCodeGeneratorError: Error, LocalizedError {
  case emptyFields(name: String)

  var errorDescription: String? {
    switch self {
    case let .emptyFields(name):
      return "\(Self.self): No fields was whitelisted for \(name) object"
    }
  }
}

struct ObjectCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let fieldSpecificationGenerator: FieldCodeGenerator

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

    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    let code = try schema.objects.compactMap {
      try declaration($0)
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.object)

    \(code)

    """
  }
}

extension ObjectCodeGenerator {
  func declaration(_ objectType: ObjectType) throws -> String {
    let sortedFields = objectType.selectableFields(selectionMap: selectionMap).sorted()

    let fieldsVariable = try sortedFields
      .compactMap { try fieldSpecificationGenerator.variableDeclaration(object: objectType, field: $0) }
      .joined(separator: "\n\n")
    let fieldsCodingKey = sortedFields
      .compactMap { fieldSpecificationGenerator.codingKeyDeclaration(object: objectType, field: $0) }
      .lines

    guard !fieldsCodingKey.isEmpty || !fieldsCodingKey.isEmpty else {
      throw ObjectCodeGeneratorError.emptyFields(name: objectType.name)
    }

    // Due to a PD-Kami requiring the ApiModel to be Codable, we cannot generate an object
    // with Decodable conformance
    return """
    struct \(try entityNameProvider.name(for: objectType)): Codable {
      \(fieldsVariable)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(fieldsCodingKey)
      }
    }
    """
  }
}
