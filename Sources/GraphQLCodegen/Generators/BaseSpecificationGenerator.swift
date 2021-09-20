//
//  BaseSpecificationGenerator.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import GraphQLAST

struct BaseSpecificationGenerator: GraphQLSpecificationGenerating {
  init() {
  }

  func declaration(schema: Schema) throws -> String {
    """
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

    enum GraphQLRequestType {
      case query
      case mutation
      case subscription
    }

    protocol GraphQLNetworkModel: Codable {}

    private let requestParametersEncoder = JSONEncoder()

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

        let parametersData = (try? requestParametersEncoder.encode(parameters)) ?? Data()
        let parametersString = String(data: parametersData, encoding: .utf8) ?? ""
        try container.encode(parametersString.isEmpty ? "null" : parametersString, forKey: .parameters)

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

    // MARK: - Extension
    fileprivate extension Collection where Element: GraphQLSelection {
      var declaration: String {
        if count == 0 {
          return Element.allCases.reduce(into: "") { $0 += \"\\n  \\($1.rawValue)\" }
        } else {
          return reduce(into: "") { $0 += \"\\n  \\($1.rawValue)\" }
        }
      }
    }
    """
  }
}
