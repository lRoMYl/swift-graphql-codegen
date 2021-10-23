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

struct UnionCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?, entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
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

    let code = try schema.unions.compactMap { union -> String in
      let possibleObjectTypes = try union.possibleTypes.compactMap {
        try $0.objectType(objectTypeMap: objectTypeMap)
      }
      let codingKeys = possibleObjectTypes
        .flatMap { ($0 as Structure).selectableFields(selectionMap: selectionMap) }
        .unique(by: { $0.name })
        .sorted(by: { $0.name < $1.name })
        .map { "case \($0.name.camelCase)" }
        .lines

      return """
      enum \(try entityNameProvider.name(for: union)): Codable {
        \(try possibleObjectTypes.map { "case \($0.name.camelCase)(\(try entityNameProvider.name(for: $0)))" }.lines)

        enum Typename: String, Decodable {
          \(possibleObjectTypes.map { "case \($0.name.camelCase) = \"\($0.name)\"" }.lines)
        }

        private enum CodingKeys: String, CodingKey {
          case __typename
          \(codingKeys)
        }

        init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          let singleValueContainer = try decoder.singleValueContainer()
          let type = try container.decode(Typename.self, forKey: .__typename)

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
    }.lines

    guard !code.isEmpty else { return "" }

    return """
    // MARK: - \(entityNameMap.union)

    \(code)
    """
  }
}
