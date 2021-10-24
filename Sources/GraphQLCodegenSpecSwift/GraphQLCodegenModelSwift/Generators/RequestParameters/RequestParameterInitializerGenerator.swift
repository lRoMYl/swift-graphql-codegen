//
//  File.swift
//
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct RequestParameterInitializerGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap
  private let selectionMap: SelectionMap?
  private let entityNameProvider: EntityNameProviding

  init(
    scalarMap: ScalarMap,
    entityNameMap: EntityNameMap,
    selectionMap: SelectionMap?,
    entityNameProvider: EntityNameProviding
  ) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.selectionMap = selectionMap
    self.entityNameProvider = entityNameProvider
  }

  func declaration(with field: Field) throws -> String {
    let arguments = try field.args.map {
      "\($0.name.camelCase): \(try entityNameProvider.name(for: $0.type))"
    }
    .joined(separator: ",\n")

    let assignments = field.args.map {
      let argumentName = $0.name.camelCase
      return "self.\(argumentName) = \(argumentName)"
    }.lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }

  func declaration(with operation: GraphQLAST.Operation) throws -> String {
    let fields = operation.type.selectableFields(selectionMap: selectionMap)
    let arguments = try fields.map {
      "\($0.name.camelCase): \(try entityNameProvider.requestParameterName(for: $0, with: operation))? = nil"
    }
    .joined(separator: ",\n")

    let assignments = fields.map {
      let argumentName = $0.name.camelCase
      return "self.\(argumentName) = \(argumentName)"
    }.lines

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }
}
