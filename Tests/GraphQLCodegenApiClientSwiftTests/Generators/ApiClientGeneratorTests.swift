//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenApiClientSwift
import XCTest

final class ApiClientGeneratorTests: XCTestCase {
  func testApiClient() throws {
    let generator = ApiClientGenerator(
      selectionMap: nil,
      entityNameMap: .default,
      scalarMap: .default,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default),
      apiClientPrefix: "Groceries",
      apiClientStrategy: .default
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")

    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try #"""
    // MARK: - GroceriesApiClientProtocol

    protocol GroceriesApiClientProtocol {
      func query(
        with request: GraphQLQuery,
        selections: GraphQLQuerySelections
      ) -> Single<ApiResponse<QueryGraphQLObject>>
      func campaignAttribute(
        with request: CampaignAttributeGraphQLQuery,
        selections: CampaignAttributeGraphQLQuerySelections
      ) -> Single<ApiResponse<CampaignAttributeQueryResponse>>
      func campaigns(
        with request: CampaignsGraphQLQuery,
        selections: CampaignsGraphQLQuerySelections
      ) -> Single<ApiResponse<CampaignsQueryResponse>>
      func update(
        with request: GraphQLMutation,
        selections: GraphQLMutationSelections
      ) -> Single<ApiResponse<MutationGraphQLObject>>
      func campaignAttribute(
        with request: CampaignAttributeGraphQLMutation,
        selections: CampaignAttributeGraphQLMutationSelections
      ) -> Single<ApiResponse<CampaignAttributeMutationResponse>>
    }

    enum GroceriesApiClientError: Error, LocalizedError {
      case missingData(context: String)

      var errorDescription: String? {
        switch self {
        case let .missingData(context):
          return "\(Self.self): \(context)"
        }
      }
    }

    final class GroceriesApiClient: GroceriesApiClientProtocol {
      private let restClient: RestClient
      private let scheduler: SchedulerType
      private let resourceParametersConfigurator: GroceriesResourceParametersConfigurating?

      init(
        restClient: RestClient,
        scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background),
        resourceParametersConfigurator: GroceriesResourceParametersConfigurating? = nil
      ) {
        self.restClient = restClient
        self.scheduler = scheduler
        self.resourceParametersConfigurator = resourceParametersConfigurator
      }

      func campaignAttribute(
        with request: CampaignAttributeGraphQLQuery,
        selections: CampaignAttributeGraphQLQuerySelections
      ) -> Single<ApiResponse<CampaignAttributeQueryResponse>> {
        let resource = GroceriesResourceParametersProvider(
          resourceParametersConfigurator: resourceParametersConfigurator,
          resourceBodyParameters: .queryCampaignAttribute(request: request, selections: selections)
        )

        return executeGraphQLQuery(
          resource: resource
        )
      }

      func campaigns(
        with request: CampaignsGraphQLQuery,
        selections: CampaignsGraphQLQuerySelections
      ) -> Single<ApiResponse<CampaignsQueryResponse>> {
        let resource = GroceriesResourceParametersProvider(
          resourceParametersConfigurator: resourceParametersConfigurator,
          resourceBodyParameters: .queryCampaigns(request: request, selections: selections)
        )

        return executeGraphQLQuery(
          resource: resource
        )
      }

      func query(
        with request: GraphQLQuery,
        selections: GraphQLQuerySelections
      ) -> Single<ApiResponse<QueryGraphQLObject>> {
        let resource = GroceriesResourceParametersProvider(
          resourceParametersConfigurator: resourceParametersConfigurator,
          resourceBodyParameters: .query(request: request, selections: selections)
        )

        let response: Single<ApiResponse<QueryGraphQLObject>> = executeGraphQLQuery(resource: resource)

        return response
          .map { result in
            let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
              (request.campaignAttribute, result.data?.campaignAttribute),
              (request.campaigns, result.data?.campaigns)
            ]

            try responseExpectations.forEach {
              if let request = $0.0, $0.1 == nil {
                throw GroceriesApiClientError.missingData(
                  context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
                )
              }
            }

            return result
          }
      }

      func campaignAttribute(
        with request: CampaignAttributeGraphQLMutation,
        selections: CampaignAttributeGraphQLMutationSelections
      ) -> Single<ApiResponse<CampaignAttributeMutationResponse>> {
        let resource = GroceriesResourceParametersProvider(
          resourceParametersConfigurator: resourceParametersConfigurator,
          resourceBodyParameters: .updateCampaignAttribute(request: request, selections: selections)
        )

        return executeGraphQLMutation(
          resource: resource
        )
      }

      func update(
        with request: GraphQLMutation,
        selections: GraphQLMutationSelections
      ) -> Single<ApiResponse<MutationGraphQLObject>> {
        let resource = GroceriesResourceParametersProvider(
          resourceParametersConfigurator: resourceParametersConfigurator,
          resourceBodyParameters: .update(request: request, selections: selections)
        )

        let response: Single<ApiResponse<MutationGraphQLObject>> = executeGraphQLQuery(resource: resource)

        return response
          .map { result in
            let responseExpectations: [(GraphQLRequesting?, Codable?)] = [
              (request.campaignAttribute, result.data?.campaignAttribute)
            ]

            try responseExpectations.forEach {
              if let request = $0.0, $0.1 == nil {
                throw GroceriesApiClientError.missingData(
                  context: "Missing data for \(request.requestType.rawValue) { \(request.requestQuery) }"
                )
              }
            }

            return result
          }
      }
    }

    private extension GroceriesApiClient {
      func executeGraphQLQuery<Response>(
        resource: ResourceParameters
      ) -> Single<ApiResponse<Response>> where Response: Codable {
        let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
          .executeRequest(resource: resource)

        return request
          .map { apiResponse in
            ApiResponse(
              data: apiResponse.data?.data,
              httpURLResponse: apiResponse.httpURLResponse,
              metaData: apiResponse.metaData
            )
          }
          .subscribe(on: scheduler)
      }

      func executeGraphQLMutation<Response>(
        resource: ResourceParameters
      ) -> Single<ApiResponse<Response>> where Response: Codable {
        let request: Single<ApiResponse<GraphQLResponse<Response>>> = restClient
          .executeRequest(resource: resource)

        return request
          .map { apiResponse in
            ApiResponse(
              data: apiResponse.data?.data,
              httpURLResponse: apiResponse.httpURLResponse,
              metaData: apiResponse.metaData
            )
          }
          .subscribe(on: scheduler)
      }
    }
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
