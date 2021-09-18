//
//  File.swift
//  
//
//  Created by Romy Cheah on 18/9/21.
//

import GraphQLAST

final class ObjectFieldSpecificationGenerator {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func variableDeclaration(field: Field) throws -> String {
    let type = try field.type.namedType.scalarType(scalarMap: scalarMap)
    let wrappedType = field.type.type(for: type)

    return """
    \(field.docs)
    \(field.availability)
    let \(field.name.camelCase): \(wrappedType)
    """
  }

  func codingKeyDeclaration(field: Field) -> String {
    "case \(field.name.camelCase) = \"\(field.name)\""
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
