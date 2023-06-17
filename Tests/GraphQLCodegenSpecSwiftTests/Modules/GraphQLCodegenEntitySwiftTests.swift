//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class GraphQLCodegenEntitySwiftTests: XCTestCase {
  func testEntityCodegen() throws {
    let generator = GraphQLCodegenEntitySwift(
      entityNameMap: .default,
      entityNameProvider: EntityNameProvider(
        scalarMap: .default,
        entityNameMap: .default
      )
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(schema: groceriesSchema)
    let expectedDeclaration = try #"""
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all
    // swiftformat:disable all

    import Foundation

    // MARK: - Interfaces

    protocol GraphQLRequestParameter: Encodable {
      var requestType: GraphQLRequestType { get }
      var requestName: String { get }
      var rootSelectionKeys: Set<String> { get }

      var requestQuery: String { get }

      var requestArguments: [(key: String, value: String)] { get }
      var subRequestArguments: [(key: String, value: String)] { get }

      func requestArguments(with selections: GraphQLSelections) -> String
      func requestFragments(with selections: GraphQLSelections) -> String
    }

    protocol GraphQLSelection: Hashable, CaseIterable {}
    protocol GraphQLSelections {
      func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String
    }

    // MARK: - Enum

    enum GraphQLRequestType: String, Decodable {
      case query
      case mutation
      case subscription
    }

    enum GraphQLConfiguration {
      /**
      GraphQL is unable to resolve recursive fragments as it would lead to inifnite loop. Thus we would
      need to define a fix depth to resolve the infinite loop issue
      */
      static var recursionDepth: UInt = 5
    }

    // MARK: GraphQLRequest

    struct GraphQLRequest<RequestParameters: GraphQLRequestParameter>: Encodable {
      let parameters: RequestParameters
      let selections: GraphQLSelections

      enum CodingKeys: String, CodingKey {
        case parameters = "variables"
        case query
      }

      init(parameters: RequestParameters, selections: GraphQLSelections) {
        self.parameters = parameters
        self.selections = selections
      }

      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let requestTypeCode = parameters.requestType.rawValue
        let requestArguments = parameters.requestArguments(with: selections)

        let requestQuery = """
        \(requestTypeCode)\(requestArguments) {
          \(parameters.requestQuery)
        }

        \(parameters.requestFragments(with: selections))
        """

        try container.encode(parameters, forKey: .parameters)
        try container.encode(requestQuery, forKey: .query)
      }
    }

    // MARK: - GraphQLResponse

    struct GraphQLResponse<ResponseData: Decodable>: Decodable {
      let data: ResponseData?
      let errors: [GraphQLResponseError]?
    }

    struct GraphQLResponseError: Decodable {
      let message: String?
      let locations: [[String: Int]]?
      let path: [String]?
      
    }

    enum GraphQLError: Error, LocalizedError {
      case missingSelection(key: CodingKey, type: String)

      var errorDescription: String? {
        switch self {
        case let .missingSelection(key, type):
          return "\(Self.self): \(key.stringValue) is not selected for \(type) type in the GraphQL query"
        }
      }
    }

    // MARK: - GraphQLSelection+Fragments

    extension Collection where Element: GraphQLSelection & RawRepresentable, Element.RawValue == String {
      func requestFragment(
        requestName: String,
        typeName: String,
        depth: UInt = GraphQLConfiguration.recursionDepth
      ) -> (key: String, value: String) {
        let key = "\(requestName)\(typeName)Fragment"
        let fragmentFields = implodeRecursiveFragment(
          text: requestFragmentFields(requestName: requestName),
          fragmentKey: key,
          depth: depth
        )
        let value = """
        fragment \(key) on \(typeName) {
          \(fragmentFields)
        }
        """

        return (key: key, value: value)
      }

      func requestFragmentFields(requestName: String) -> String {
        let values = count == 0
          ? Element.allCases.map { $0 as Element }
          : map { $0 as Element }
        let sortedValeus = values.sorted(by: { $0.rawValue < $1.rawValue })

        let variablePrefix = "$\(requestName.prefix(1).lowercased() + requestName.dropFirst())"

        return sortedValeus.reduce(into: "") {
          let formatted = String(
            format: $1.rawValue.replacingOccurrences(of: "$%@", with: variablePrefix),
            requestName
          )

          $0 += "\n  \(formatted)"
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
        guard let range = text.range(of: "...\(fragmentKey)") else {
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
        let delimiter = "\n"

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

    extension Set where Element: GraphQLSelection {
      static var allFields: Set<Element> {
        Set(Element.allCases)
      }
    }

    // MARK: - GraphQLSelections+fragments

    extension GraphQLSelections {
      func nestedRequestFragments(selectionDeclarationMap: [String: String], rootSelectionKeys: Set<String>) -> [String] {
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

      func nestedRequestFragments(selectionDeclarationMap: [String: String], rootSelectionKey: String) -> [String: String] {
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
              selectionDeclarationMap[childSelectionKey] = nil
            }
          }
        }

        return dictionary
      }

      func requestFragment(
        requestName: String,
        typeName: String,
        possibleTypeNames: [String]
      ) -> (key: String, value: String) {
        let key = "\(requestName)\(typeName)Fragment"

        return (
          key: key,
          value: """
            fragment \(key) on \(typeName) {
              __typename
              \(possibleTypeNames.map { "...\(requestName)\($0)Fragment" }.joined(separator: "\n"))
            }
            """
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
          throw GraphQLError.missingSelection(key: codingKey, type: String(describing: Model.self))
        }

        return value
      }
    }
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
