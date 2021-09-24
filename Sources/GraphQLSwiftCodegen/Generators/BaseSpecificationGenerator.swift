//
//  BaseSpecificationGenerator.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST

/// This code potentially be moved to PD-Kami

struct BaseSpecificationGenerator: GraphQLSpecificationGenerating {
  init() {
  }

  func declaration(schema: Schema) throws -> String {
    #"""
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import Foundation

    // MARK: - Interfaces

    protocol GraphQLRequestParameter: Encodable {
      associatedtype Selections: GraphQLSelections

      var requestType: GraphQLRequestType { get }
      var selections: Selections { get }
      var operationDefinition: String { get }
    }

    protocol GraphQLSelection: RawRepresentable, Hashable, CaseIterable where RawValue == String {}
    protocol GraphQLSelections {
      func declaration() -> String
    }

    // MARK: - Enum

    enum GraphQLRequestType {
      case query
      case mutation
      case subscription
    }

    // MARK: GraphQLRequest

    struct GraphQLRequest<RequestParameters: GraphQLRequestParameter>: Encodable {
      let parameters: RequestParameters

      enum CodingKeys: String, CodingKey {
        case parameters = "variables"
        case query
        case mutation
        case subscription
      }

      init(
        parameters: RequestParameters
      ) throws {
        self.parameters = parameters
      }

      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(parameters, forKey: .parameters)

        let operationDefinition = parameters.operationDefinition

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

    // MARK: - GraphQLResponse

    struct GraphQLResponse<OperationType: Codable, ReturnType: Codable>: Codable {
      let data: OperationType

      enum CodingKeys: String, CodingKey {
        case data
      }
    }

    // MARK: - GraphQLSelection+Declaration

    extension Collection where Element: GraphQLSelection {
      var declaration: String {
        if count == 0 {
          return Element.allCases.reduce(into: "") { $0 += "\n  \($1.rawValue)" }
        } else {
          return reduce(into: "") { $0 += "\n  \($1.rawValue)" }
        }
      }
    }

    // MARK: - GraphQLSelections+Declaration

    extension GraphQLSelections {
      func declaration(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> String {
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
            if currentFragment.contains("...\(childSelectionKey)") {
              let value = selectionDeclarationMap[childSelectionKey]!

              queue.append(value)
              dictionary[childSelectionKey] = value
            }
          }
        }

        return dictionary.values.joined(separator: "\n")
      }
    }

    // MARK: - GraphQLRequest+BodyParameters

    extension GraphQLRequest: BodyParameters {
      func bodyParameters() -> [String: Any] {
        guard
          let data = try? JSONEncoder().encode(self)
        else { return [:] }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
          .flatMap {
            $0 as? [String: Any]
          } ?? [:]
      }
    }
    """#
  }
}
