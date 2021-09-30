//
//  File.swift
//  
//
//  Created by Romy Cheah on 26/9/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenConfig
import GraphQLCodegenUtil
import SwiftFormat

public enum GraphQLCodegenEntitySwiftError: Error, LocalizedError {
  case formatError(context: String)

  public var errorDescription: String? {
    switch self {
    case let .formatError(context):
      return "\(Self.self): \(context)"
    }
  }
}

public struct GraphQLCodegenEntitySwift {
  private let entityNameMap: EntityNameMap

  public init(entityNameMap: EntityNameMap?) {
    self.entityNameMap = entityNameMap ?? EntityNameMap.default
  }

  public func code(schema: Schema) throws -> String {
    let code = """
    // @generated
    // Do not edit this generated file
    // swiftlint:disable all

    import Foundation

    // MARK: - Interfaces

    protocol \(entityNameMap.requestParameter): Encodable {
      associatedtype Selections: \(entityNameMap.selections)

      var requestType: \(entityNameMap.requestType) { get }
      var selections: Selections { get }
      var operationDefinition: String { get }
    }

    protocol \(entityNameMap.selection): RawRepresentable, Hashable, CaseIterable where RawValue == String {}
    protocol \(entityNameMap.selections) {
      func declaration() -> String
    }

    // MARK: - Enum

    enum \(entityNameMap.requestType) {
      case query
      case mutation
      case subscription
    }

    // MARK: \(entityNameMap.request)

    struct \(entityNameMap.request)<RequestParameters: \(entityNameMap.requestParameter)>: Encodable {
      let parameters: RequestParameters

      enum CodingKeys: String, CodingKey {
        case parameters = "variables"
        case query
        case mutation
        case subscription
      }

      init(parameters: RequestParameters) {
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

    // MARK: - \(entityNameMap.response)

    struct \(entityNameMap.response)<ResponseData: \(entityNameMap.responseData)>: Codable {
      let data: ResponseData

      var wrappedValue: Decodable {
        data.data
      }
    }

    // MARK: - \(entityNameMap.responseData)
    protocol \(entityNameMap.responseData): Codable {
      associatedtype T: Decodable

      var data: T { get }
    }

    // MARK: - \(entityNameMap.selection)+Declaration

    extension Collection where Element: \(entityNameMap.selection) {
      var declaration: String {
        if count == 0 {
          return Element.allCases.reduce(into: "") { $0 += "\\n  \\($1.rawValue)" }
        } else {
          return reduce(into: "") { $0 += "\\n  \\($1.rawValue)" }
        }
      }
    }

    // MARK: - \(entityNameMap.selections)+Declaration

    extension \(entityNameMap.selections) {
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
            if currentFragment.contains("...\\(childSelectionKey)") {
              let value = selectionDeclarationMap[childSelectionKey]!

              queue.append(value)
              dictionary[childSelectionKey] = value
            }
          }
        }

        return dictionary.values.joined(separator: "\\n")
      }
    }
    """

    let formattedCode: String

    do {
      formattedCode = try code.format()
    } catch {
      throw GraphQLCodegenEntitySwiftError
        .formatError(
          context: """
            \(error)
            Raw text:
            \(code)
            """
        )
    }

    return formattedCode
  }
}
