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

      func operationDefinition() -> String
      func operationArguments() -> String
    }

    protocol \(entityNameMap.selection): Hashable, CaseIterable {
    }
    protocol \(entityNameMap.selections) {
      func declaration(with rootSelectionKeys: Set<String>) -> String
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

        \\(selections.declaration(with: parameters.rootSelectionKeys))
        \"\"\"

        try container.encode(parameters, forKey: .parameters)
        try container.encode(operationDefinition, forKey: .query)
      }
    }

    // MARK: - \(entityNameMap.response)

    struct \(entityNameMap.response)<ResponseData: Codable>: Codable {
      let data: ResponseData
    }

    // MARK: - Maybe

    enum Maybe<T> {
      case some(T)
      case none
    }

    extension Maybe {
      enum MaybeError: Error, LocalizedError {
        case missingValue(context: String)

        var failureReason: String? {
          switch self {
          case let .missingValue(context):
            return "Unwrapping value failed in \\(context). Please ensure the GraphQL query contain selection for the value"
          }
        }
      }

      func safelyUnwrapped(
        file: String = #file,
        function: String = #function,
        line: Int = #line
      ) throws -> T {
        switch self {
        case let .some(wrappedValue):
          return wrappedValue
        case .none:
          let fileName = file.split(separator: "/").last ?? ""
          throw MaybeError.missingValue(context: "\\(fileName) line:\\(line)")
        }
      }
    }

    extension KeyedDecodingContainer {
      func decode<T>(_ type: Maybe<T>.Type, forKey key: Key) throws -> Maybe<T> where T: Codable {
        do {
          if contains(key) {
            let value = try decode(T.self, forKey: key)
            return .some(value)
          } else {
            return .none
          }
        } catch {
          throw error
        }
      }
    }

    extension Maybe: Codable where T: Codable {
      init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let value = try? container.decode(T.self) else {
          self = .none
          return
        }

        self = .some(value)
      }

      func encode(to encoder: Encoder) throws {
        var encoder = encoder.singleValueContainer()

        switch self {
        case .none:
          break
        case let .some(value):
          try encoder.encode(value)
        }
      }
    }

    // MARK: - \(entityNameMap.selection)+Declaration

    extension Collection where Element: GraphQLSelection, Element: RawRepresentable {
      var declaration: String {
        if count == 0 {
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
