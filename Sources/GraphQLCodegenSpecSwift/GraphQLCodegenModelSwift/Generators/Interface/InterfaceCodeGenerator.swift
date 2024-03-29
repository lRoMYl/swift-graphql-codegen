//
//  File.swift
//
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

struct InterfaceCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let fieldSpecificationGenerator: FieldCodeGenerator

  private enum Variables {
    static let staticTypeName = "TypeName"
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

    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameProvider: entityNameProvider
    )
  }

  func code(schema: Schema) throws -> String {
    let objectTypeMap = ObjectTypeMap(schema: schema)
    let schemaMap = try SchemaMap(schema: schema)

    let interfaces = try schema.operations.map {
      try $0.type
        .nestedFields(schema: schema, scalarMap: scalarMap, selectionMap: selectionMap)
        .unique(by: { $0.type.namedType.name })
        .sorted(by: .namedType)
    }
    .reduce([], +)
    .compactMap { try schemaMap.interfaceTypeMap.value(from: $0.type.namedType) }

    let code = try interfaces.compactMap {
      return try self.code(interface: $0, objectTypeMap: objectTypeMap)
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.interface)

    \(code)

    """
  }
}

extension InterfaceCodeGenerator {
  func code(interface: InterfaceType, objectTypeMap: ObjectTypeMap) throws -> String {
    let possibleObjectTypes: [ObjectType] = try interface.possibleObjectTypes(
      objectTypeMap: objectTypeMap
    )
    let codingKeys = interface.selectableFields(selectionMap: selectionMap)
      .map { "case \($0.name.camelCase)" }
      .lines

    return """
    enum \(try entityNameProvider.name(for: interface)): \(entityNameProvider.responseType) {
      \(try possibleObjectTypes.map { "case \($0.name.camelCase)(\(try entityNameProvider.name(for: $0)))" }.lines)

      enum \(Variables.staticTypeName): String, \(entityNameProvider.responseType), CaseIterable {
        \(possibleObjectTypes.map { "case \($0.name.camelCase) = \"\($0.name)\"" }.lines)
      }

      private enum CodingKeys: String, CodingKey {
        case __typename
        \(codingKeys)
      }

      init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleValueContainer = try decoder.singleValueContainer()
        let type = try container.decode(\(Variables.staticTypeName).self, forKey: .__typename)

        switch type {
        \(
          try possibleObjectTypes.map {
            """
              case .\($0.name.camelCase):
              let value = try singleValueContainer.decode(\(try entityNameProvider.name(for: $0)).self)
              self = .\($0.name.camelCase)(value)
            """
          }.lines
        )
        }
      }

      func encode(to encoder: Encoder) throws {
        fatalError("Not implemented yet")
      }
    }
    """
  }
}
