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
      var rootSelectionKeys: Set<String> { get }
    }

    protocol \(entityNameMap.selection): Hashable, CaseIterable {
      static var requiredDeclaration: String { get }
    }
    protocol \(entityNameMap.selections) {
      func declaration(with rootSelectionKeys: Set<String>) -> String
      func operationDefinition(with rootSelectionKeys: Set<String>) -> String
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
        case mutation
        case subscription
      }

      init(parameters: RequestParameters, selections: \(entityNameMap.selections)) {
        self.parameters = parameters
        self.selections = selections
      }

      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(parameters, forKey: .parameters)

        let operationDefinition = selections.operationDefinition(with: parameters.rootSelectionKeys)

        switch parameters.requestType {
        case .query:
          try container.encode(operationDefinition, forKey: .query)
        case .mutation:
          try container.encode(operationDefinition, forKey: .mutation)
        case .subscription:
          try container.encode(operationDefinition, forKey: .subscription)
        }
      }
    }

    // MARK: - \(entityNameMap.response)

    struct \(entityNameMap.response)<ResponseData: Codable>: Codable {
      let data: ResponseData
    }

    // MARK: - \(entityNameMap.selection)+Declaration

    extension Collection where Element: GraphQLSelection, Element: RawRepresentable {
      var declaration: String {
        if Element.requiredDeclaration.isEmpty, count == 0 {
          return Element.allCases.reduce(into: "") { $0 += "\\n  \\($1.rawValue)" }
        } else {
          return reduce(into: "") { $0 += "\\n  \\($1.rawValue)" }
        }
      }
    }

    extension Set where Element: GraphQLSelection {
      static var requiredFields: Set<Element> {
        []
      }

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
            }
          }
        }

        return dictionary
      }
    }
    """
  }
}
