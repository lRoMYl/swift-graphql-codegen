//
//  File.swift
//  
//
//  Created by Romy Cheah on 26/9/21.
//

import GraphQLAST
import GraphQLCodegenConfig

struct RequestParameterInitializerGenerator {
  private let scalarMap: ScalarMap
  private let entityNameMap: EntityNameMap

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
  }

  func declaration(field: Field) throws -> String {
    var arguments = try field.args.map {
      try "\($0.name.camelCase): \($0.type.type(scalarMap: scalarMap, entityNameMap: entityNameMap))"
    }
    .joined(separator: ",\n")

    if arguments.count > 0 {
      arguments.append(",\n")
    }
    arguments.append("selections: Selections = .init()")

    var assignments = field.args.map {
      let argumentName = $0.name.camelCase
      return "self.\(argumentName) = \(argumentName)"
    }.lines
    assignments.append("\nself.selections = selections")

    return """
    init(
      \(arguments)
    ) {
      \(assignments)
    }
    """
  }
  
}
