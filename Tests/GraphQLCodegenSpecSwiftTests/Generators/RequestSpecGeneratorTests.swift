//
//  File.swift
//  
//
//  Created by Romy Cheah on 17/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class RequestSpecGeneratorTests: XCTestCase {
  func testRequest() throws {
    let generator = RequestGenerator(
      scalarMap: .default,
      selectionMap: nil,
      entityNameMap: .default,
      entityNameProvider: DHEntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try #"""
    // MARK: - GraphQLRequestParameter

    /// CampaignAttributeGraphQLQuery
    struct CampaignAttributeGraphQLQuery: GraphQLRequestParameter {
      // MARK: - GraphQLRequestType

      let requestType: GraphQLRequestType = .query
      let requestName: String = "campaignAttribute"
      let rootSelectionKeys: Set<String> = ["CampaignAttributeCampaignAttributeFragment"]

      // MARK: - Arguments

      let vendorId: String

      let globalEntityId: String

      let locale: String

      let languageId: String?

      let languageCode: String?

      let apiKey: String

      let discoClientId: String

      private enum CodingKeys: String, CodingKey {
        case vendorId = "campaignAttributeVendorId"

        case globalEntityId = "campaignAttributeGlobalEntityId"

        case locale = "campaignAttributeLocale"

        case languageId = "campaignAttributeLanguageId"

        case languageCode = "campaignAttributeLanguageCode"

        case apiKey = "campaignAttributeApiKey"

        case discoClientId = "campaignAttributeDiscoClientId"
      }

      init(
        apiKey: String,
        discoClientId: String,
        globalEntityId: String,
        languageCode: String?,
        languageId: String?,
        locale: String,
        vendorId: String
      ) {
        self.apiKey = apiKey
        self.discoClientId = discoClientId
        self.globalEntityId = globalEntityId
        self.languageCode = languageCode
        self.languageId = languageId
        self.locale = locale
        self.vendorId = vendorId
      }

      let requestQuery: String = {
        """
        campaignAttribute(
          VendorID: $campaignAttributeVendorId
          GlobalEntityID: $campaignAttributeGlobalEntityId
          Locale: $campaignAttributeLocale
          LanguageID: $campaignAttributeLanguageId
          LanguageCode: $campaignAttributeLanguageCode
          APIKey: $campaignAttributeApiKey
          DiscoClientID: $campaignAttributeDiscoClientId
        ) {
           ...CampaignAttributeCampaignAttributeFragment
        }
        """
      }()

      let requestArguments: String = {
        """
        $campaignAttributeApiKey: String!,
        $campaignAttributeDiscoClientId: String!,
        $campaignAttributeGlobalEntityId: String!,
        $campaignAttributeLanguageCode: String,
        $campaignAttributeLanguageId: String,
        $campaignAttributeLocale: String!,
        $campaignAttributeVendorId: String!
        """
      }()

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// CampaignsGraphQLQuery
    struct CampaignsGraphQLQuery: GraphQLRequestParameter {
      // MARK: - GraphQLRequestType

      let requestType: GraphQLRequestType = .query
      let requestName: String = "campaigns"
      let rootSelectionKeys: Set<String> = ["CampaignsCampaignsFragment"]

      // MARK: - Arguments

      let vendorId: String

      let globalEntityId: String

      let locale: String

      let languageId: String

      let languageCode: String

      let apiKey: String

      let discoClientId: String

      private enum CodingKeys: String, CodingKey {
        case vendorId = "campaignsVendorId"

        case globalEntityId = "campaignsGlobalEntityId"

        case locale = "campaignsLocale"

        case languageId = "campaignsLanguageId"

        case languageCode = "campaignsLanguageCode"

        case apiKey = "campaignsApiKey"

        case discoClientId = "campaignsDiscoClientId"
      }

      init(
        apiKey: String,
        discoClientId: String,
        globalEntityId: String,
        languageCode: String,
        languageId: String,
        locale: String,
        vendorId: String
      ) {
        self.apiKey = apiKey
        self.discoClientId = discoClientId
        self.globalEntityId = globalEntityId
        self.languageCode = languageCode
        self.languageId = languageId
        self.locale = locale
        self.vendorId = vendorId
      }

      let requestQuery: String = {
        """
        campaigns(
          VendorID: $campaignsVendorId
          GlobalEntityID: $campaignsGlobalEntityId
          Locale: $campaignsLocale
          LanguageID: $campaignsLanguageId
          LanguageCode: $campaignsLanguageCode
          APIKey: $campaignsApiKey
          DiscoClientID: $campaignsDiscoClientId
        ) {
           ...CampaignsCampaignsFragment
        }
        """
      }()

      let requestArguments: String = {
        """
        $campaignsApiKey: String!,
        $campaignsDiscoClientId: String!,
        $campaignsGlobalEntityId: String!,
        $campaignsLanguageCode: String!,
        $campaignsLanguageId: String!,
        $campaignsLocale: String!,
        $campaignsVendorId: String!
        """
      }()

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    struct GraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = ""
      var rootSelectionKeys: Set<String> {
        return requests.reduce(into: Set<String>()) { result, request in
          request.rootSelectionKeys.forEach {
            result.insert($0)
          }
        }
      }

      let campaignAttribute: CampaignAttributeGraphQLQuery?
      let campaigns: CampaignsGraphQLQuery?

      private var requests: [GraphQLRequesting] {
        let requests: [GraphQLRequesting?] = [
          campaignAttribute,
          campaigns
        ]

        return requests.compactMap { $0 }
      }

      init(
        campaignAttribute: CampaignAttributeGraphQLQuery? = nil,
        campaigns: CampaignsGraphQLQuery? = nil
      ) {
        self.campaignAttribute = campaignAttribute
        self.campaigns = campaigns
      }

      func encode(to encoder: Encoder) throws {
        try requests.forEach {
          try $0.encode(to: encoder)
        }
      }

      var requestQuery: String {
        requests
          .map { $0.requestQuery }
          .joined(separator: "\n")
      }

      var requestArguments: String {
        requests
          .map { $0.requestArguments }
          .joined(separator: "\n")
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        requests.map {
          selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
        }.joined(separator: "\n")
      }
    }

    /// CampaignAttributeGraphQLMutation
    struct CampaignAttributeGraphQLMutation: GraphQLRequestParameter {
      // MARK: - GraphQLRequestType

      let requestType: GraphQLRequestType = .mutation
      let requestName: String = "campaignAttribute"
      let rootSelectionKeys: Set<String> = ["CampaignAttributeCampaignAttributeFragment"]

      // MARK: - Arguments

      let vendorId: String

      let benefits: [String]

      let optionalBenefits: [String?]?

      private enum CodingKeys: String, CodingKey {
        case vendorId = "campaignAttributeVendorId"

        case benefits = "campaignAttributeBenefits"

        case optionalBenefits = "campaignAttributeOptionalBenefits"
      }

      init(
        benefits: [String],
        optionalBenefits: [String?]?,
        vendorId: String
      ) {
        self.benefits = benefits
        self.optionalBenefits = optionalBenefits
        self.vendorId = vendorId
      }

      let requestQuery: String = {
        """
        campaignAttribute(
          VendorID: $campaignAttributeVendorId
          Benefits: $campaignAttributeBenefits
          OptionalBenefits: $campaignAttributeOptionalBenefits
        ) {
           ...CampaignAttributeCampaignAttributeFragment
        }
        """
      }()

      let requestArguments: String = {
        """
        $campaignAttributeBenefits: [String!]!,
        $campaignAttributeOptionalBenefits: [String],
        $campaignAttributeVendorId: String!
        """
      }()

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    struct GraphQLMutation: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .mutation
      let requestName: String = ""
      var rootSelectionKeys: Set<String> {
        return requests.reduce(into: Set<String>()) { result, request in
          request.rootSelectionKeys.forEach {
            result.insert($0)
          }
        }
      }

      let campaignAttribute: CampaignAttributeGraphQLMutation?

      private var requests: [GraphQLRequesting] {
        let requests: [GraphQLRequesting?] = [
          campaignAttribute
        ]

        return requests.compactMap { $0 }
      }

      init(
        campaignAttribute: CampaignAttributeGraphQLMutation? = nil
      ) {
        self.campaignAttribute = campaignAttribute
      }

      func encode(to encoder: Encoder) throws {
        try requests.forEach {
          try $0.encode(to: encoder)
        }
      }

      var requestQuery: String {
        requests
          .map { $0.requestQuery }
          .joined(separator: "\n")
      }

      var requestArguments: String {
        requests
          .map { $0.requestArguments }
          .joined(separator: "\n")
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        requests.map {
          selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
        }.joined(separator: "\n")
      }
    }
    """#.format()

    XCTAssertEqual(declaration, expectedDeclaration)
  }
}
