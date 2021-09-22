//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST

struct FieldSpecificationGenerator {
  private let scalarMap: ScalarMap
  private let selectionMap: SelectionMap?

  init(scalarMap: ScalarMap, selectionMap: SelectionMap?) {
    self.scalarMap = scalarMap
    self.selectionMap = selectionMap
  }

  func variableDeclaration(object: Structure, field: Field) throws -> String {
    let isRequired = object.isRequired(field: field, selectionMap: selectionMap)
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isRequired || isSelectable {
      let type: String
      if isRequired {
        type = try field.type.namedType.scalarType(scalarMap: scalarMap)
      } else {
        var scalarType = try field.type.namedType.scalarType(scalarMap: scalarMap)
        if !scalarType.contains("?") {
          scalarType.append("?")
        }

        type = scalarType
      }

      return """
      \(field.docs)
      \(field.availability)
      let \(field.name.camelCase): \(type)
      """
    } else {
      return ""
    }
  }

  func codingKeyDeclaration(object: Structure, field: Field) -> String {
    let isRequired = object.isRequired(field: field, selectionMap: selectionMap)
    let isSelectable = object.isSelectable(field: field, selectionMap: selectionMap)

    if isRequired || isSelectable {
      return "case \(field.name.camelCase) = \"\(field.name)\""
    } else {
      return ""
    }
  }
}

private extension Field {
  var docs: String {
    if let description = self.description {
      return "/// \(description)"
    }
    return ""
  }

  var availability: String {
    if isDeprecated {
      let message = deprecationReason ?? ""
      return "@available(*, deprecated, message: \"\(message)\")"
    }
    return ""
  }
}
