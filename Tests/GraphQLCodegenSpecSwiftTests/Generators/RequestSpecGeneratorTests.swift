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
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let groceriesSchema = try Schema.schema(from: "CampaignSelectionsTestSchema")
    let declaration = try generator.code(schema: groceriesSchema).format()
    let expectedDeclaration = try #"""
    // MARK: - GraphQLRequestParameter

    /// CampaignsGraphQLQuery
    struct CampaignsGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "campaigns"
      let rootSelectionKeys: Set<String> = ["CampaignsCampaignsFragment"]

      let vendorId: String
      let globalEntityId: String
      let locale: String

      private enum CodingKeys: String, CodingKey {
        case vendorId = "campaignsVendorId"
        case globalEntityId = "campaignsGlobalEntityId"
        case locale = "campaignsLocale"
      }

      init(
        globalEntityId: String,
        locale: String,
        vendorId: String
      ) {
        self.globalEntityId = globalEntityId
        self.locale = locale
        self.vendorId = vendorId
      }

      let requestQuery: String = {
        """
        campaigns(
          VendorID: $campaignsVendorId
          GlobalEntityID: $campaignsGlobalEntityId
          Locale: $campaignsLocale
        ) {
           ...CampaignsCampaignsFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
        ("$campaignsVendorId", "$campaignsVendorId: String!"),
        ("$campaignsGlobalEntityId", "$campaignsGlobalEntityId: String!"),
        ("$campaignsLocale", "$campaignsLocale: String!")
      ]

      let subRequestArguments: [(key: String, value: String)] = [
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// ProductDetailsGraphQLQuery
    struct ProductDetailsGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "productDetails"
      let rootSelectionKeys: Set<String> = ["ProductDetailsProductDetailsFragment"]

      let productDetailsAttributesKeys: [String]?
      let productDetailsCrossSellProductsPlatform: String
      let productDetailsCrossSellProductsConfig: String
      let productDetailsCrossSellProductsIsDarkstore: Bool
      let input: ProductRequestGraphQLInputObject?

      private enum CodingKeys: String, CodingKey {
        case productDetailsAttributesKeys
        case productDetailsCrossSellProductsPlatform
        case productDetailsCrossSellProductsConfig
        case productDetailsCrossSellProductsIsDarkstore
        case input = "productDetailsInput"
      }

      init(
        input: ProductRequestGraphQLInputObject?,
        productDetailsAttributesKeys: [String]?,
        productDetailsCrossSellProductsConfig: String,
        productDetailsCrossSellProductsIsDarkstore: Bool,
        productDetailsCrossSellProductsPlatform: String
      ) {
        self.input = input
        self.productDetailsAttributesKeys = productDetailsAttributesKeys
        self.productDetailsCrossSellProductsConfig = productDetailsCrossSellProductsConfig
        self.productDetailsCrossSellProductsIsDarkstore = productDetailsCrossSellProductsIsDarkstore
        self.productDetailsCrossSellProductsPlatform = productDetailsCrossSellProductsPlatform
      }

      let requestQuery: String = {
        """
        productDetails(
          input: $productDetailsInput
        ) {
           ...ProductDetailsProductDetailsFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
        ("$productDetailsInput", "$productDetailsInput: ProductRequest")
      ]

      let subRequestArguments: [(key: String, value: String)] = [
        ("$productDetailsAttributesKeys", "$productDetailsAttributesKeys: [String!]"),
        ("$productDetailsCrossSellProductsPlatform", "$productDetailsCrossSellProductsPlatform: String!"),
        ("$productDetailsCrossSellProductsConfig", "$productDetailsCrossSellProductsConfig: String!"),
        ("$productDetailsCrossSellProductsIsDarkstore", "$productDetailsCrossSellProductsIsDarkstore: Boolean!")
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// ProductsGraphQLQuery
    struct ProductsGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "products"
      let rootSelectionKeys: Set<String> = ["ProductsProductFilterResultFragment"]

      let productsAttributesKeys: [String]?
      let input: ProductsFilterRequestGraphQLInputObject?

      private enum CodingKeys: String, CodingKey {
        case productsAttributesKeys
        case input = "productsInput"
      }

      init(
        input: ProductsFilterRequestGraphQLInputObject?,
        productsAttributesKeys: [String]?
      ) {
        self.input = input
        self.productsAttributesKeys = productsAttributesKeys
      }

      let requestQuery: String = {
        """
        products(
          input: $productsInput
        ) {
           ...ProductsProductFilterResultFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
        ("$productsInput", "$productsInput: ProductsFilterRequest")
      ]

      let subRequestArguments: [(key: String, value: String)] = [
        ("$productsAttributesKeys", "$productsAttributesKeys: [String!]")
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// ServiceGraphQLQuery
    struct ServiceGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "service"
      let rootSelectionKeys: Set<String> = ["ServiceServiceFragment"]

      func encode(to _: Encoder) throws {}

      init(
      ) {}

      let requestQuery: String = {
        """
        service {
           ...ServiceServiceFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
      ]

      let subRequestArguments: [(key: String, value: String)] = [
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// ShopDetailsGraphQLQuery
    struct ShopDetailsGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "shopDetails"
      let rootSelectionKeys: Set<String> = ["ShopDetailsShopDetailsFragment"]

      let shopDetailsAttributesKeys: [String]?
      let input: ShopDetailsRequestGraphQLInputObject?
      let shopDetailsShopItemsResponsePage: Int

      private enum CodingKeys: String, CodingKey {
        case shopDetailsAttributesKeys
        case input = "shopDetailsInput"
        case shopDetailsShopItemsResponsePage
      }

      init(
        input: ShopDetailsRequestGraphQLInputObject?,
        shopDetailsAttributesKeys: [String]?,
        shopDetailsShopItemsResponsePage: Int
      ) {
        self.input = input
        self.shopDetailsAttributesKeys = shopDetailsAttributesKeys
        self.shopDetailsShopItemsResponsePage = shopDetailsShopItemsResponsePage
      }

      let requestQuery: String = {
        """
        shopDetails(
          input: $shopDetailsInput
        ) {
           ...ShopDetailsShopDetailsFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
        ("$shopDetailsInput", "$shopDetailsInput: ShopDetailsRequest")
      ]

      let subRequestArguments: [(key: String, value: String)] = [
        ("$shopDetailsAttributesKeys", "$shopDetailsAttributesKeys: [String!]"),
        ("$shopDetailsShopItemsResponsePage", "$shopDetailsShopItemsResponsePage: Int!")
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

      func requestFragments(with selections: GraphQLSelections) -> String {
        selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
      }
    }

    /// ServiceGraphQLQuery
    struct ServiceGraphQLQuery: GraphQLRequestParameter {
      let requestType: GraphQLRequestType = .query
      let requestName: String = "_service"
      let rootSelectionKeys: Set<String> = ["_service_ServiceFragment"]

      func encode(to _: Encoder) throws {}

      init(
      ) {}

      let requestQuery: String = {
        """
        _service {
           ..._service_ServiceFragment
        }
        """
      }()

      let requestArguments: [(key: String, value: String)] = [
      ]

      let subRequestArguments: [(key: String, value: String)] = [
      ]

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
      }

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

      let service: ServiceGraphQLQuery?
      let campaigns: CampaignsGraphQLQuery?
      let productDetails: ProductDetailsGraphQLQuery?
      let products: ProductsGraphQLQuery?
      let service: ServiceGraphQLQuery?
      let shopDetails: ShopDetailsGraphQLQuery?

      private var requests: [GraphQLRequestParameter] {
        let requests: [GraphQLRequestParameter?] = [
          service,
          campaigns,
          productDetails,
          products,
          service,
          shopDetails
        ]

        return requests.compactMap { $0 }
      }

      init(
        service: ServiceGraphQLQuery? = nil,
        campaigns: CampaignsGraphQLQuery? = nil,
        productDetails: ProductDetailsGraphQLQuery? = nil,
        products: ProductsGraphQLQuery? = nil,
        service: ServiceGraphQLQuery? = nil,
        shopDetails: ShopDetailsGraphQLQuery? = nil
      ) {
        self.service = service
        self.campaigns = campaigns
        self.productDetails = productDetails
        self.products = products
        self.service = service
        self.shopDetails = shopDetails
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

      var requestArguments: [(key: String, value: String)] {
        requests.reduce(into: [(key: String, value: String)]()) { result, element in
          result.append(contentsOf: element.requestArguments)
        }
      }

      var subRequestArguments: [(key: String, value: String)] {
        requests.reduce(into: [(key: String, value: String)]()) { result, element in
          result.append(contentsOf: element.subRequestArguments)
        }
      }

      func requestArguments(with selections: GraphQLSelections) -> String {
        let requestFragments = self.requestFragments(with: selections)
        var selectedSubRequestArguments = [(key: String, value: String)]()

        subRequestArguments.forEach {
          if requestFragments.contains($0.key) {
            selectedSubRequestArguments.append($0)
          }
        }

        let arguments = requestArguments + selectedSubRequestArguments

        return arguments.isEmpty
          ? ""
          : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
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
