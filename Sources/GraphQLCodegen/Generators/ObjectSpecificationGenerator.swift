//
//  Object.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import GraphQLAST

struct ObjectSpecificationGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - Objects

    \(try schema.objects.compactMap { try $0.declaration(objects: schema.objects, scalarMap: scalarMap) }.lines)
    """
  }
}

private extension ObjectType {
  /// Declares (i.e. creates) the object itself.
  func declaration(objects: [ObjectType], scalarMap: ScalarMap) throws -> String {
    let name = self.name.pascalCase

    return """
    struct \(name): Codable {
      \(try allFields(objects: objects).variableDeclaration(scalarMap: scalarMap).lines)

      // MARK: - CodingKeys

      private enum CodingKeys: String, CodingKey {
        \(allFields(objects: objects).codingKeyDeclaration())
      }
    }
    """
  }
}

private extension Collection where Element == Field {
  func variableDeclaration(scalarMap: ScalarMap) throws -> [String] {
    let keys: [String] = try map {
      let type = try $0.type.namedType.scalarType(scalarMap: scalarMap)
      let wrappedType = $0.type.nonNullable.type(for: type)

      return """
      \($0.docs)
      \($0.availability)
      let \($0.name.camelCase): \(wrappedType)
      """
    }

    return keys
  }

  func codingKeyDeclaration() -> String {
    map {
      "case \($0.name.camelCase) = \"\($0.name)\""
    }.lines
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
