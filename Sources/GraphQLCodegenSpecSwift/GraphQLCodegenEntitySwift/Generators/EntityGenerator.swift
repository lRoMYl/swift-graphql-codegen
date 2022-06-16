//
//  File.swift
//  
//
//  Created by Romy Cheah on 7/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenNameSwift

struct EntityGenerator: GraphQLCodeGenerating {
  private let entityNameMap: EntityNameMap
  private let entityNameProvider: EntityNameProviding

  private enum Variables {
    static let requestName = "requestName"
    static let capitalizedRequestName = "capitalizedRequestName"
    static let typeName = "typeName"
  }

  init(entityNameMap: EntityNameMap, entityNameProvider: EntityNameProviding) {
    self.entityNameMap = entityNameMap
    self.entityNameProvider = entityNameProvider
  }

  func code(schema _: Schema) throws -> String {
    """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    import Foundation

    // MARK: - Interfaces

    protocol \(entityNameMap.requestParameter): Encodable {
      var requestType: \(entityNameMap.requestType) { get }
      var requestName: String { get }
      var rootSelectionKeys: Set<String> { get }

      var \(entityNameProvider.requestQueryName): String { get }

      var \(entityNameProvider.requestArgumentsName): [(key: String, value: String)] { get }
      var sub\(entityNameProvider.requestArgumentsName.pascalCase): [(key: String, value: String)] { get }

      func \(entityNameProvider.requestArgumentsName)(with selections: \(entityNameMap.selections)) -> String
      func \(entityNameProvider.requestFragmentsName)(with selections: \(entityNameMap.selections)) -> String
    }

    protocol \(entityNameMap.selection): Hashable, CaseIterable {}
    protocol \(entityNameMap.selections) {
      func requestFragments(for \(Variables.requestName): String, rootSelectionKeys: Set<String>) -> String
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
        let requestArguments = parameters.\(entityNameProvider.requestArgumentsName)(with: selections)

        let requestQuery = \"\"\"
        \\(requestTypeCode)\\(requestArguments) {
          \\(parameters.\(entityNameProvider.requestQueryName))
        }

        \\(parameters.\(entityNameProvider.requestFragmentsName)(with: selections))
        \"\"\"

        try container.encode(parameters, forKey: .parameters)
        try container.encode(requestQuery, forKey: .query)
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

    // MARK: - \(entityNameMap.selection)+Fragments

    extension Collection where Element: \(entityNameMap.selection) & RawRepresentable, Element.RawValue == String {
      func \(entityNameProvider.requestFragmentName)(
        \(Variables.requestName): String,
        \(Variables.typeName): String
      ) -> (key: String, value: String) {
        let key = "\\(\(Variables.requestName))\\(\(Variables.typeName))Fragment"
        let value = \"\"\"
        fragment \\(key) on \\(\(Variables.typeName)) {
          \\(requestFragments(\(Variables.requestName): \(Variables.requestName)))
        }
        \"\"\"

        return (key: key, value: value)
      }

      func \(entityNameProvider.requestFragmentsName)(requestName: String) -> String {
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

      func \(entityNameProvider.requestFragmentName)(
        \(Variables.requestName): String,
        \(Variables.typeName): String,
        possibleTypeNames: [String]
      ) -> (key: String, value: String) {
        let key = "\\(\(Variables.requestName))\\(\(Variables.typeName))Fragment"

        return (
          key: key,
          value: \"\"\"
            fragment \\(key) on \\(\(Variables.requestName)) {
              __typename
              \\(possibleTypeNames.map { "...\\(\(Variables.requestName))\\($0)Fragment" }.joined(separator: "\\n"))
            }
            \"\"\"
        )
      }
    }

    extension Set where Element: \(entityNameMap.selection) {
      static var allFields: Set<Element> {
        Set(Element.allCases)
      }
    }

    // MARK: - \(entityNameMap.selections)+fragments

    extension \(entityNameMap.selections) {
      func \(entityNameProvider.requestFragmentsName)(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
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

    extension KeyedDecodingContainer {
      func decodeOptionalIfPresent<T>(
        _ type: T.Type,
        forKey key: KeyedDecodingContainer<K>.Key
      ) throws -> T? where T: Decodable {
        guard contains(key) else {
          return nil
        }

        return Optional(try decode(type, forKey: key))
      }
    }

    extension Decodable {
      func value<Model, Value>(for keyPath: KeyPath<Model, Value?>, codingKey: CodingKey) throws -> Value {
        guard
          let model = self as? Model,
          let value = model[keyPath: keyPath]
        else {
          throw GraphQLResponseError.missingSelection(key: codingKey, type: String(describing: Model.self))
        }

        return value
      }
    }
    """
  }
}
