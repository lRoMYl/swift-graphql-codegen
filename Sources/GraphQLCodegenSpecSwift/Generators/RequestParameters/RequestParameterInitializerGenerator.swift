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
  private let entityNameProvider: EntityNameProviding

  init(scalarMap: ScalarMap, entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.scalarMap = scalarMap
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func declaration(field: Field) throws -> String {
    var arguments = try field.args.map {
      "\($0.name.camelCase): \(try entityNameProvider.name(for: $0.type))"
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
