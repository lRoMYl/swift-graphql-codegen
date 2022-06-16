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
    static let recursionDepth = "recursionDepth"
    static let recursionDepthType = "UInt"
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

    enum \(entityNameMap.requestType): String, \(entityNameProvider.responseType) {
      case query
      case mutation
      case subscription
    }

    enum \(entityNameMap.configuration) {
      /**
      GraphQL is unable to resolve recursive fragments as it would lead to inifnite loop. Thus we would
      need to define a fix depth to resolve the infinite loop issue
      */
      static var \(Variables.recursionDepth): \(Variables.recursionDepthType) = 5
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

    struct \(entityNameMap.response)<ResponseData: \(entityNameProvider.responseType)>: \(entityNameProvider.responseType) {
      let data: ResponseData?
      let errors: [\(entityNameMap.responseError)]?
    }

    struct \(entityNameMap.responseError): \(entityNameProvider.responseType) {
      let message: String?
      let locations: [[String: Int]]?
      let path: [String]?
      \(entityNameMap.responseErrorExtension.map { "let extensions: \($0)?" } ?? "")
    }

    enum \(entityNameProvider.graphQLError): Error, LocalizedError {
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
        \(Variables.typeName): String,
        depth: \(Variables.recursionDepthType) = \(entityNameMap.configuration).\(Variables.recursionDepth)
      ) -> (key: String, value: String) {
        let key = "\\(\(Variables.requestName))\\(\(Variables.typeName))Fragment"
        let fragmentFields = implodeRecursiveFragment(
          text: \(entityNameProvider.requestFragmentFields)(\(Variables.requestName): \(Variables.requestName)),
          fragmentKey: key,
          depth: depth
        )
        let value = \"\"\"
        fragment \\(key) on \\(\(Variables.typeName)) {
          \\(fragmentFields)
        }
        \"\"\"

        return (key: key, value: value)
      }

      func \(entityNameProvider.requestFragmentFields)(requestName: String) -> String {
        let values = count == 0
          ? Element.allCases.map { $0 as Element }
          : map { $0 as Element }
        let sortedValeus = values.sorted(by: { $0.rawValue < $1.rawValue })

        let variablePrefix = "$\\(requestName.prefix(1).lowercased() + requestName.dropFirst())"

        return sortedValeus.reduce(into: "") {
          let formatted = String(
            format: $1.rawValue.replacingOccurrences(of: "$%@", with: variablePrefix),
            requestName
          )

          $0 += "\\n  \\(formatted)"
        }
      }

      /**
        GraphQL query doesn't support recursive fragment, internally GraphQL will simply implode all fragment
        and if there is a recursive fragment it will just be stuck in infinite loop.

        Thus it is necessary to detect if recursive fragment exist and try to resolve it by providing
        a fixed depth for the recursion.
        - parameter depth: Define how many time the recursive fragment should be imploded, 0 would terminate the recursion
        */
      func implodeRecursiveFragment(text: String, fragmentKey: String, depth: UInt) -> String {
        guard let range = text.range(of: "...\\(fragmentKey)") else {
          return text
        }

        var formattedText = text

        if depth == 1 {
          var fieldsWithoutFragment = text

          if let fragmentFieldRange = self.fragmentFieldRange(text: text, fragmentRange: range) {
            fieldsWithoutFragment.replaceSubrange(fragmentFieldRange, with: "")
          } else {
            fieldsWithoutFragment.replaceSubrange(range, with: "")
          }

          formattedText.replaceSubrange(range, with: fieldsWithoutFragment)
        } else if depth == 0 {
          if let fragmentFieldRange = self.fragmentFieldRange(text: text, fragmentRange: range) {
            formattedText.replaceSubrange(fragmentFieldRange, with: "")
          } else {
            formattedText.replaceSubrange(range, with: "")
          }
        } else {
          formattedText.replaceSubrange(range, with: implodeRecursiveFragment(text: text, fragmentKey: fragmentKey, depth: (depth - 1)))
        }

        return formattedText
      }

      func fragmentFieldRange(text: String, fragmentRange: Range<String.Index>) -> Range<String.Index>? {
        let lowerOffset = 1
        let delimiter = "\\n"

        let lowerIndex: String.Index

        var searchIndex = fragmentRange.lowerBound
        var counter = 0

        while text.startIndex < searchIndex {
          if let foundRange = text.range(of: delimiter, options: .backwards, range: text.startIndex..<searchIndex) {
            counter += 1
            searchIndex = foundRange.lowerBound

            if counter > lowerOffset {
              break
            }
          } else {
            searchIndex = text.startIndex
          }
        }

        if counter > lowerOffset {
          lowerIndex = searchIndex
        } else {
          return nil
        }

        searchIndex = fragmentRange.upperBound

        guard let upperRange = text.range(of: delimiter, range: searchIndex..<text.endIndex) else {
          return nil
        }

        return lowerIndex..<text.index(after: upperRange.upperBound)
      }
    }

    extension Set where Element: \(entityNameMap.selection) {
      static var allFields: Set<Element> {
        Set(Element.allCases)
      }
    }

    // MARK: - \(entityNameMap.selections)+fragments

    extension \(entityNameMap.selections) {
      func \(entityNameProvider.nestedRequestFragmentsName)(selectionDeclarationMap: [String: String], rootSelectionKeys: Set<String>) -> [String] {
        rootSelectionKeys
          .map {
            nestedRequestFragments(
              selectionDeclarationMap: selectionDeclarationMap,
              rootSelectionKey: $0
            )
          }
          .reduce([String: String]()) { old, new in
            old.merging(new, uniquingKeysWith: { _, new in new })
          }
          .sorted(by: { $0.0 < $1.0 })
          .map { $0.1 }
      }

      func \(entityNameProvider.nestedRequestFragmentsName)(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
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

      func \(entityNameProvider.requestFragmentName)(
        \(Variables.requestName): String,
        \(Variables.typeName): String,
        possibleTypeNames: [String]
      ) -> (key: String, value: String) {
        let key = "\\(\(Variables.requestName))\\(\(Variables.typeName))Fragment"

        return (
          key: key,
          value: \"\"\"
            fragment \\(key) on \\(\(Variables.typeName)) {
              __typename
              \\(possibleTypeNames.map { "...\\(\(Variables.requestName))\\($0)Fragment" }.joined(separator: "\\n"))
            }
            \"\"\"
        )
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
          throw \(entityNameProvider.graphQLError).missingSelection(key: codingKey, type: String(describing: Model.self))
        }

        return value
      }
    }
    """
  }
}
