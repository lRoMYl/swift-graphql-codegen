//
//  ResponseParameters.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 11/9/21.
//

import Foundation
import GraphQLAST

enum ResponseParametersError: Error, LocalizedError {
  case missingReturnType(context: String)
  case notImplemented(context: String)

  var errorDescription: String? {
    "\(Self.self).\(self)"
  }
}

struct ResponseParametersGenerator: GraphQLSpecificationGenerating {
  private let scalarMap: ScalarMap

  init(scalarMap: ScalarMap) {
    self.scalarMap = scalarMap
  }

  func declaration(schema: Schema) throws -> String {
    """
    // MARK: - RequestParameters

    \(
      try schema.operations.map {
        try operation($0, objects: schema.objects, scalarMap: scalarMap)
      }.lines
    )
    """
  }
}

private extension ResponseParametersGenerator {
  func operation(_ operation: GraphQLAST.Operation, objects: [ObjectType], scalarMap: ScalarMap) throws -> String {
    let text: String

    switch operation {
    case let .query(object),
         let .mutation(object):
      text = try operation.declaration(
        object: object,
        objects: objects,
        scalarMap: scalarMap
      ).lines
    case .subscription:
      text = ""
      assertionFailure("Not implemented")
    }

    return text
  }
}

// MARK: - Operation

private extension GraphQLAST.Operation {
  func declaration(
    object: ObjectType,
    objects: [ObjectType],
    scalarMap: ScalarMap
  ) throws -> [String] {
    let operationTypeName = type.name.lowercased()

    return try object.fields.compactMap {
      let fieldName = $0.name.pascalCase

      let operationVariables = $0.operationVariables
      let operationArguments = try $0.operationArguments()
      let argumentVariables = try $0.argumentVariables(scalarMap: scalarMap)

      let codingKeys = try $0.codingKeys()
      let namePrefix = structNamePrefix

      let selections = try selectionDeclaration(field: $0, objects: objects, scalarMap: scalarMap)

      let reqeuestParametersName = "\(namePrefix)\(fieldName)RequestParameters"

      return """
      // MARK: - \(reqeuestParametersName)

      struct \(reqeuestParametersName): GraphQLRequestParameters {
        private let operationDefinitionFormat: String = \"\"\"
        \(operationTypeName) (\n\(operationVariables)
        ) {
        \(
          """
          \($0.name)(
          \(operationArguments)
          ) {
            ...\(fieldName)Fragment
          }
          """
        )

        %1$@
        \"\"\"

        var operationDefinition: String {
          String(
            format: operationDefinitionFormat,
            selections.declaration()
          )
        }

        // MARK: - Arguments

        \(argumentVariables)

        // MARK: - Request Type

        let requestType: GraphQLRequestType = .\(operationTypeName)

        // MARK: - Selections

        \(selections)

        // MARK: - CodingKeys

        \(codingKeys)
      }
      """
    }
  }

  func selectionDeclaration(field: Field, objects: [ObjectType], scalarMap: ScalarMap) throws -> String {
    guard
      let returnObjectType = objects.first(where: { $0.name == field.type.namedType.name })
    else {
      throw ResponseParametersError.missingReturnType(context: "No ObjectType type found for field \(field.name)")
    }

    let allFields = returnObjectType.allFields(objects: objects)

    var dictionary = [String:String]()

    // Add base selection for the current operation
    try field.selectionDeclaration(objects: objects, dictionary: &dictionary)

    // Add sub-selection for all object in the current operation recursively
    try allFields.forEach { field in
      try field.selectionDeclaration(objects: objects, dictionary: &dictionary)
    }

    let sortedDictionary = Array(dictionary).sorted(by: <)

    let code = """
    let selections: Selections

    struct Selections: GraphQLSelections {
    \(sortedDictionary.map { $0.value }.lines )

      func declaration() -> String {
        \"\"\"
        \(
          sortedDictionary.map {
            """
            fragment \($0.key)Fragment on \($0.key) {\\(\($0.key.camelCase)Selections.reduce(into: "") { $0 += "\\n  \\($1.rawValue)" })
            }\n
            """
          }.lines
        )
        \"\"\"
      }
    }
    """
    let formattedCode = try code.format()

    return formattedCode
  }

  /// Custom name prefix to prevent collision for the same operation object for Query, Mutation and Subscription
  var structNamePrefix: String {
    switch self {
    case .query:
      return ""
    case .mutation:
      return "Update"
    case .subscription:
      return "Subscribe"
    }
  }
}

// MARK: - Field

private extension Field {
  func selectionDeclaration(objects: [ObjectType], dictionary: inout [String: String]) throws {
    let returnName = type.namedType.name

    guard
      let returnObjectType = objects.first(where: { $0.name == returnName })
    else {
      return
    }

    let allFields = returnObjectType.allFields(objects: objects)

    let defaultSelections = try allFields.compactMap { field in
      switch field.type {
      case .list, .nonNull:
        try field.selectionDeclaration(objects: objects, dictionary: &dictionary)
      case .named:
        break
      }

      return try field.enumCaseDeclaration(type: field.type)
    }.lines

    let selectionVariableName = "\(returnName.camelCase)Selections"
    let selectionEnumName = "\(returnName.pascalCase)Selection"
    let result = """
    let \(selectionVariableName): Set<\(selectionEnumName)>

    enum \(selectionEnumName): String, GraphQLSelection {
      \(defaultSelections)
    }
    """

    dictionary["\(returnName)"] = result
  }

  func enumCaseDeclaration(type: OutputTypeRef) throws -> String {
    switch type {
    case let .list(outputRef):
      return try enumCaseDeclaration(type: outputRef)
    case let .named(objectRef):
      switch objectRef {
      case .scalar, .enum:
        return "case \(name) = \"\(name)\""
      case .object:
        return "case \(name) = \"...\(name.pascalCase)Fragment\""
      case .union, .interface:
        throw ResponseParametersError.notImplemented(context: "Union and Interface are not implemented yet")
      }
    case let .nonNull(outputRef):
      return try enumCaseDeclaration(type: outputRef)
    }
  }

  /**
   - Operation variables is functionalities in GraphQL which allow injection of a list of variables on the root operation.
   - Variables are marked with `$` prefix
   - Required/mandatory field have a `!` prefix, optional field have no prefix
   - GraphQL example syntax for variables is `($productId: String!, $isAvailable: Bool, $vendorId: String)`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) { // Here
    product(id: $productId, isAvailable: $isAvailable) {
      name
    }
    vendor(id: $vendorId) {
      name
    }
   }
   ~~~
   */
  var operationVariables: String {
    args.compactMap {
      switch $0.type {
      case let .named(objectRef):
        let typeName: String
        switch objectRef {
        case let .enum(name), let .inputObject(name), let .scalar(name):
          typeName = name
        }

        return "    $\($0.name): \(typeName)"
      case let .nonNull(objectRef), let .list(objectRef):
        return "    $\($0.name): \(objectRef.argument)!"
      }
    }.lines
  }

  /**
   - Operation argument is the operation variables passed from the root the selection
   - Operation argument have `$` prefix
   - Example of operation agument is `id: $productId, isAvailable: $isAvailable` and `id: $vendorId`
   ~~~
   query($productId: String!, $isAvaiable: Bool, $vendorId: String) {
     product(id: $productId, isAvailable: $isAvailable) { // Here
      name
     }
     vendor(id: $vendorId) { // Here
      name
     }
   }
   ~~~
   */
  func operationArguments() throws -> String {
    args.compactMap {
      return "    \($0.name): $\($0.name)"
    }.lines
  }

  func codingKeys() throws -> String {
    """
    private enum CodingKeys: String, CodingKey {
      \(try args.compactMap { try $0.codingKeysDeclaration() }.lines)
    }
    """
  }

  func argumentVariables(scalarMap: ScalarMap) throws -> String {
    try args.compactMap { try $0.argumentVariableDeclaration(scalarMap: scalarMap) }.lines
  }
}

// MARK: - InputValue

private extension InputValue {
  var docs: String {
    if let description = self.description {
      return "/// \(description)"
    }
    return ""
  }

  func argumentVariableDeclaration(scalarMap: ScalarMap) throws -> String {
    let typeName = try type.scalarType(scalarMap: scalarMap)

    return """
    \(docs)
    let \(name.camelCase): \(typeName)
    """
  }

  func codingKeysDeclaration() throws -> String {
    return """
    \(docs)
    case \(name.camelCase) = \"\(name)\"
    """
  }
}
