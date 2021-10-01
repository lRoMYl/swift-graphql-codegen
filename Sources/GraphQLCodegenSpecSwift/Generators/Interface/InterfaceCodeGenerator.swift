//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct InterfaceCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let entityNameStrategy: EntityNamingStrategy

  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(
    scalarMap: ScalarMap,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap,
    entityNameStrategy: EntityNamingStrategy
  ) {
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
    let objectTypeMap = try schema.objectTypeMap(entityNameStrategy: entityNameStrategy)
    let code = try schema.interfaces.map { try self.code(interface: $0, objectTypeMap: objectTypeMap) }.lines

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
      objectTypeMap: objectTypeMap,
      entityNameStrategy: entityNameStrategy
    )

    return """
      struct \(try entityNameStrategy.name(for: interface)): Codable {
        enum Object {
          \(
            try possibleObjectTypes.map {
              "case \($0.name.camelCase)(\(try entityNameStrategy.name(for: $0)))"
            }.lines
          )
        }

        enum ObjectType: String, Decodable {
          \(
            possibleObjectTypes.map {
              "case \($0.name.camelCase) = \"\($0.name)\""
            }.lines
          )
        }

        let __typename: ObjectType
        let data: Object

        enum CodingKeys: String, CodingKey {
          case __typename
          case data
        }

        init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          let singleContainer = try decoder.singleValueContainer()

          __typename = try container.decode(ObjectType.self, forKey: .__typename)

          switch __typename {
          \(
            try possibleObjectTypes.map {
              """
              case .\($0.name.camelCase):
                data = .\($0.name.camelCase)(try singleContainer.decode(\(try entityNameStrategy.name(for: $0)).self))
              """
            }.lines
          )
          }
        }

        func encode(to _: Encoder) throws {
          fatalError("Not implemented")
        }
      }
      """
  }
}
