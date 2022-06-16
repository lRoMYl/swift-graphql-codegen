//
//  GroceriesExampleApp.swift
//  GroceriesExample
//
//  Created by Romy Cheah on 6/10/21.
//

import ApiClient
import RxSwift
import SwiftUI

@main
struct GroceriesExampleApp: App {
  private let disposeBag = DisposeBag()
  private let groceriesRepository: GroceriesRepositoring = {
    return DIContainer
      .shared
      .groceryBuilderManual
      .repository()
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          testGroceriesGraphQL()
          testShopDetailsGraphQL()
          testProductsGraphQL()
          testQueryGraphQL()
        }
    }
  }

  func testGroceriesGraphQL() {
    let parameters = CampaignsQueryRequest(
      globalEntityId: "FP_SG",
      locale: "en_SG",
      vendorId: "x1yy"
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { campaigns in
          print("TEST: testGroceriesGraphQL success")
          guard let campaigns = campaigns else {
            print("Groceries campaign query request fail, no campaigns founds")
            return
          }

          print("Groceries campaign query request success")
          print("Product Deals Count: \(campaigns.productDeals?.count ?? -1)")
          print("Campaign Attributes Count: \(campaigns.attributes?.count ?? -1)")
        },
        onFailure: { error in
          print("TEST: testGroceriesGraphQL fail")
          print(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
  }

  func testShopDetailsGraphQL() {
    let request = ShopDetailsQueryRequest(
      input: ShopDetailsRequestRequestModel (
        vendorId: "x1yy",
        globalEntityId: "FP_SG",
        isDarkstore: false,
        customerId: nil,
        locale: "en_SG",
        platform: "ios",
        pastOrderStrategy: nil
      ),
      shopDetailsAttributesKeys: nil,
      shopDetailsShopItemsResponsePage: 0
    )

    groceriesRepository
      .shopDetails(with: request)
      .subscribe(
        onSuccess: { shopDetails in
          print("TEST: testShopDetailsGraphQL success")
          if let shopItemList = try? shopDetails?.shopItemsResponse?.shopItemsList {
            shopItemList.forEach { shopItem in
              if let shopItemItem = try? shopItem.shopItems {
                shopItemItem.enumerated().forEach {
                  switch $1 {
                  case let .banner(banner):
                    print("Test: \($0)) Banner: \(banner)")
                  case let .category(category):
                    print("Test: \($0)) Category: \(category)")
                  case let .product(product):
                    print("TEST: \($0)) Product: \(product)")
                  }
                }
              } else {

              }
            }
          } else {
            print("TEST Empty")
          }
        },
        onFailure: { error in
          print("TEST: testShopDetailsGraphQL fail")
          print(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
  }

  func testProductsGraphQL() {
    let productsRequest = ProductsQueryRequest(
      input: .init(
        vendorId: "x1yy",
        globalEntityId: "FP_SG",
        locale: "en_SG",
        platform: "ios",
        customerId: nil,
        page: nil,
        filters: nil,
        isDarkstore: true
      ),
      productsAttributesKeys: nil
    )

    groceriesRepository
      .products(with: productsRequest)
      .subscribe(
        onSuccess: { response in
          print("TEST: testProductsGraphQL success")

          do {
            let items = try response?.items
            print("TEST: testProductsGraphQL response: \(String(describing: items))")
          } catch {
            print("\(error.localizedDescription)")
          }
        },
        onFailure: { error in
          print("TEST: testProductsGraphQL fail")
          print(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
  }

  func testQueryGraphQL() {
    let campaignQueryRequest = CampaignsQueryRequest(
      globalEntityId: "FP_SG",
      locale: "en_SG",
      vendorId: "x1yy"
    )

    let shopDetailsQueryRequest = ShopDetailsQueryRequest(
      input: ShopDetailsRequestRequestModel(
        vendorId: "x1yy",
        globalEntityId: "FP_SG",
        isDarkstore: false,
        customerId: nil,
        locale: "en_SG",
        platform: "ios",
        pastOrderStrategy: nil
      ),
      shopDetailsAttributesKeys: nil,
      shopDetailsShopItemsResponsePage: 0
    )

    groceriesRepository
      .query(
        campaignQueryRequest: campaignQueryRequest,
        shopDetailsQueryRequest: shopDetailsQueryRequest
      )
      .subscribe(
        onSuccess: { result in
          print("TEST: testQueryGraphQL success")
          print("TEST testQueryGraphQL response:\n\(String(describing: result.campaigns))")
          print("TEST testQueryGraphQL response:\n\(String(describing: result.shopDetails))")
        },
        onFailure: { error in
          print("TEST: testQueryGraphQL fail")
          print(error.localizedDescription)
        }
      )
      .disposed(by: disposeBag)
  }
}
