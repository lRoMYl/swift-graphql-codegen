//
//  BaseSpecificationGenerator.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 13/9/21.
//

import Foundation

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

    protocol GraphQLRequestParameters: Encodable {
      associatedtype Selections: GraphQLSelections

      var requestType: GraphQLRequestType { get }
      var selections: Selections { get }
      var operationDefinition: String { get }
    }

    protocol GraphQLSelection: RawRepresentable, Hashable where RawValue == String {}
    protocol GraphQLSelections {
      func declaration() -> String
    }

    enum GraphQLRequestType {
      case query
      case mutation
    }

    protocol GraphQLNetworkModel: Codable {}

    private let requestParametersEncoder = JSONEncoder()

    struct GraphQLRequest<RequestParameters: GraphQLRequestParameters>: Encodable {
      let parameters: RequestParameters

      enum CodingKeys: String, CodingKey {
        case parameters = "variables"
        case query
        case mutation
      }

      init(
        parameters: RequestParameters
      ) throws {
        self.parameters = parameters
      }

      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let parametersData = try requestParametersEncoder.encode(parameters)
        let parametersString = String(data: parametersData, encoding: .utf8) ?? ""
        try container.encode(parametersString, forKey: .parameters)

        let operationDefinition = parameters.operationDefinition

        switch parameters.requestType {
        case .query:
          try container.encode(operationDefinition, forKey: .query)
        case .mutation:
          try container.encode(operationDefinition, forKey: .mutation)
        }
      }
    }
    """
  }
}
