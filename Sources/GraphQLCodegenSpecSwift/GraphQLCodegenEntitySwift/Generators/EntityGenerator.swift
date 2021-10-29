//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig

struct EntityGenerator: GraphQLCodeGenerating {
  private let entityNameMap: EntityNameMap

  init(entityNameMap: EntityNameMap) {
    self.entityNameMap = entityNameMap
  }

  func code(schema _: Schema) throws -> String {
    """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import Foundation

    // MARK: - Interfaces

    protocol \(entityNameMap.requestParameter): Encodable {
      var requestType: \(entityNameMap.requestType) { get }
      var requestName: String { get }
      var rootSelectionKeys: Set<String> { get }

      func operationDefinition() -> String
      func operationArguments() -> String
      func fragments(with selections: GraphQLSelections) -> String
    }

    protocol \(entityNameMap.selection): Hashable, CaseIterable {}
    protocol \(entityNameMap.selections) {
      func declaration(for requestName: String, rootSelectionKeys: Set<String>) -> String
    }

    // MARK: - Enum

    enum \(entityNameMap.requestType): String, Codable {
      case query
      case mutation
      case subscription
    }

    // MARK: \(entityNameMap.request)

    struct \(entityNameMap.request)<RequestParameters: \(entityNameMap.requestParameter)>: Encodable {
      let parameters: RequestParameters
      let selections: \(entityNameMap.selections)

      enum CodingKeys: String, CodingKey {
        case parameters = "variables"
        case query
      }

      init(parameters: RequestParameters, selections: \(entityNameMap.selections)) {
        self.parameters = parameters
        self.selections = selections
      }

      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let requestTypeCode = parameters.requestType.rawValue
        let operationArguments = parameters.operationArguments()
        let operationArgumentCode = operationArguments.isEmpty
          ? ""
          : " (\\(operationArguments))"

        let operationDefinition = \"\"\"
        \\(requestTypeCode)\\(operationArgumentCode) {
          \\(parameters.operationDefinition())
        }

        \\(parameters.fragments(with: selections))
        \"\"\"

        try container.encode(parameters, forKey: .parameters)
        try container.encode(operationDefinition, forKey: .query)
      }
    }

    // MARK: - \(entityNameMap.response)

    struct \(entityNameMap.response)<ResponseData: Codable>: Codable {
      let data: ResponseData
    }

    enum GraphQLResponseError: Error, LocalizedError {
      case missingSelection(key: CodingKey, type: String)

      var errorDescription: String? {
        switch self {
        case let .missingSelection(key, type):
          return "\\(Self.self): \\(key.stringValue) is not selected for \\(type) type in the GraphQL query"
        }
      }
    }

    // MARK: - \(entityNameMap.selection)+Declaration

    extension Collection where Element: GraphQLSelection & RawRepresentable, Element.RawValue == String {
      func declaration(requestName: String) -> String {
        let values = count == 0
          ? Element.allCases.map { $0 as Element }
          : map { $0 as Element }

        let variablePrefix = "$\\(requestName.prefix(1).lowercased() + requestName.dropFirst())"

        return values.reduce(into: "") {
          let formatted = String(
            format: $1.rawValue.replacingOccurrences(of: "$%@", with: variablePrefix),
            requestName
          )

          $0 += "\\n  \\(formatted)"
        }
      }
    }

    extension Set where Element: GraphQLSelection {
      static var allFields: Set<Element> {
        Set(Element.allCases)
      }
    }

    // MARK: - \(entityNameMap.selections)+Declaration

    extension \(entityNameMap.selections) {
      func declaration(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
        var dictionary = [String: String]()
        dictionary[rootSelectionKey] = selectionDeclarationMap[rootSelectionKey]

        // Initialize queue with root selection
        var queue = Array(dictionary.values)

        // Remove root selection from SelectionDeclarationMap to prevent circular dependency
        var selectionDeclarationMap = selectionDeclarationMap
        selectionDeclarationMap.removeValue(forKey: rootSelectionKey)

        while !queue.isEmpty {
          let currentFragment = queue.removeFirst()

          for childSelectionKey in selectionDeclarationMap.keys {
            if currentFragment.contains("...\\(childSelectionKey)") {
              let value = selectionDeclarationMap[childSelectionKey]!

              queue.append(value)
              dictionary[childSelectionKey] = value
              selectionDeclarationMap[childSelectionKey] = nil
            }
          }
        }

        return dictionary
      }
    }
    """
  }
}
