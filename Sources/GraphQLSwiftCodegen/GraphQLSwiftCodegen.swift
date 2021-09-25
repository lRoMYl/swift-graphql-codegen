//
//  GraphQLCodegen.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

public struct GraphQLSwiftCodegen {
  private let namespace: String
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?
  private let entityNameMap: EntityNameMap
  private let generators: [GraphQLSpecificationGenerating]

  public init(
    namespace: String?,
    scalarMap: ScalarMap?,
    selectionMap: SelectionMap?,
    entityNameMap: EntityNameMap?
  ) throws {
    try selectionMap?.validate()

    self.namespace = namespace ?? ""
    self.scalarMap = ScalarMap.default.merging(
      scalarMap ?? [:],
      uniquingKeysWith: { (_, new) in new }
    )
    self.selectionMap = selectionMap
    self.entityNameMap = entityNameMap ?? EntityNameMap.default

    self.generators = [
      BaseSpecificationGenerator(entityNameMap: self.entityNameMap),
      EnumSpecificationGenerator(scalarMap: self.scalarMap),
      ObjectSpecificationGenerator(scalarMap: self.scalarMap, selectionMap: self.selectionMap),
      InputObjectSpecificationGenerator(scalarMap: self.scalarMap),
      RequestParameterGenerator(
        scalarMap: self.scalarMap,
        selectionMap: self.selectionMap,
        entityNameMap: self.entityNameMap
      )
    ]
  }

  public func generate(schema: Schema) throws -> String {
    let code = try generators.map { try $0.declaration(schema: schema) }.lines

    let source = try code.format()
    return source
  }
}
