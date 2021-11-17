//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenDHApiClientSwift
import XCTest

final class ResourceParameterGeneratorTests: XCTestCase {
  func testResourceParameter() throws {
    let generator = ResourceParametersGenerator(
      entityNameMap: .default,
      scalarMap: .default,
      entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default),
      apiClientPrefix: "Groceries"
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try """
    // MARK: - GroceriesResourceParametersProvider

    protocol GroceriesResourceParametersConfigurating {
      func servicePath(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> String
      func headers(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> [String: String]?
      func timeoutInterval(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> TimeInterval?
      func preventRetry(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
      func preventAddingLanguageParameters(with bodyParameters: GroceriesResourceParametersProvider.BodyParameters) -> Bool
    }

    struct GroceriesResourceParametersProvider: ResourceParameters {
      enum BodyParameters {
        case queryCampaignAttribute(request: CampaignAttributeGraphQLQuery, selections: CampaignAttributeGraphQLQuerySelections)
        case queryCampaigns(request: CampaignsGraphQLQuery, selections: CampaignsGraphQLQuerySelections)
        case query(request: GraphQLQuery, selections: GraphQLQuerySelections)
        case updateCampaignAttribute(request: CampaignAttributeGraphQLMutation, selections: CampaignAttributeGraphQLMutationSelections)
        case update(request: GraphQLMutation, selections: GraphQLMutationSelections)

        func bodyParameters() -> Any? {
          switch self {
          case let .queryCampaignAttribute(request, selections):
            return bodyParameters(request: request, selections: selections as GraphQLSelections)
          case let .queryCampaigns(request, selections):
            return bodyParameters(request: request, selections: selections as GraphQLSelections)
          case let .query(request, selections):
            return bodyParameters(request: request, selections: selections as GraphQLSelections)
          case let .updateCampaignAttribute(request, selections):
            return bodyParameters(request: request, selections: selections as GraphQLSelections)
          case let .update(request, selections):
            return bodyParameters(request: request, selections: selections as GraphQLSelections)
          }
        }

        private func bodyParameters<T>(request: T, selections: GraphQLSelections) -> [String: Any] where T: GraphQLRequestParameter {
          guard
            let data = try? JSONEncoder().encode(GraphQLRequest(parameters: request, selections: selections))
          else { return [:] }

          return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
            .flatMap {
              $0 as? [String: Any]
            } ?? [:]
        }
      }

      private let resourceParametersConfigurator: GroceriesResourceParametersConfigurating?
      private let resourceBodyParameters: BodyParameters

      init(
        resourceParametersConfigurator: GroceriesResourceParametersConfigurating?,
        resourceBodyParameters: BodyParameters
      ) {
        self.resourceParametersConfigurator = resourceParametersConfigurator
        self.resourceBodyParameters = resourceBodyParameters
      }

      func bodyFormat() -> HttpBodyFormat {
        .JSON
      }

      func httpMethod() -> RequestHttpMethod {
        .post
      }

      func servicePath() -> String {
        resourceParametersConfigurator?.servicePath(with: resourceBodyParameters) ?? ""
      }

      func headers() -> [String: String]? {
        resourceParametersConfigurator?.headers(with: resourceBodyParameters) ?? nil
      }

      func timeoutInterval() -> TimeInterval? {
        resourceParametersConfigurator?.timeoutInterval(with: resourceBodyParameters) ?? nil
      }

      func preventRetry() -> Bool {
        resourceParametersConfigurator?.preventRetry(with: resourceBodyParameters) ?? false
      }

      func preventAddingLanguageParameters() -> Bool {
        resourceParametersConfigurator?.preventAddingLanguageParameters(with: resourceBodyParameters) ?? false
      }

      func bodyParameters() -> Any? {
        return resourceBodyParameters.bodyParameters()
      }
    }
    """.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
