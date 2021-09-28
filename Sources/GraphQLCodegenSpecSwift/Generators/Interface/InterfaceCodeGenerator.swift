//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct InterfaceCodeGenerator: GraphQLCodeGenerating {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let fieldSpecificationGenerator: FieldCodeGenerator

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap
    self.fieldSpecificationGenerator = FieldCodeGenerator(
      scalarMap: scalarMap,
      selectionMap: selectionMap,
      entityNameMap: entityNameMap
    )
  }

  func code(schema: Schema) throws -> String {
    return """
    // MARK: - \(entityNameMap.interfaces)

    enum \(entityNameMap.interfaces) {}

    extension \(entityNameMap.interfaces) {
      \(
        schema.interfaces.compactMap {
          """
          struct \($0.name): Codable {
          }
          """
        }.lines
      )
    }

    """
  }
}
