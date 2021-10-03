//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct UnionCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?, entityNameMap: EntityNameMap, entityNameStrategy: EntityNamingStrategy) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.entityNameStrategy = entityNameStrategy
    
    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap,
      entityNameStrategy: entityNameStrategy
    )
  }

  func code(schema: Schema) throws -> String {
    let objectTypeMap = ObjectTypeMap(schema: schema)

    let code = try schema.unions.compactMap { union -> String in
      let possibleObjectTypes = try union.possibleTypes.compactMap {
        try $0.objectType(objectTypeMap: objectTypeMap)
      }
      let fields = possibleObjectTypes
        .flatMap { ($0 as Structure).selectableFields(selectionMap: selectionMap) }
        .unique(by: { $0.name })
        .sorted(by: { $0.name < $1.name })

      return """
      enum \(try entityNameStrategy.name(for: union)): Codable {
        \(try possibleObjectTypes.map { "case \($0.name.camelCase)(\(try entityNameStrategy.name(for: $0)))" }.lines)

        enum Typename: String, Decodable {
          \(possibleObjectTypes.map { "case \($0.name.camelCase) = \"\($0.name)\"" }.lines)
        }

        private enum CodingKeys: String, CodingKey {
          case __typename
          \(fields.map { "case \($0.name.camelCase)" }.lines)
        }

        init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          let singleValueContainer = try decoder.singleValueContainer()
          let type = try container.decode(Typename.self, forKey: .__typename)

          switch type {
          \(
            try possibleObjectTypes.map {
              return """
                case .\($0.name.camelCase):
                let value = try singleValueContainer.decode(\(try entityNameStrategy.name(for: $0)).self)
                self = .\($0.name.camelCase)(value)
              """
            }.lines
          )
          }
        }

        func encode(to encoder: Encoder) throws {
          assertionFailure("Not implemented yet")
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
