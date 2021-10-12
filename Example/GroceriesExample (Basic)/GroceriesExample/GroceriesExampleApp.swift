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
  private let groceriesRepository: GroceriesRepository = {
    let restClient = RestClientImpl(
      webService: GroceriesWebService(),
      authProvider: nil
    )

    let apiClient = GroceriesApiClient(
      restClient: restClient
    )
    let repository = GroceriesRepository(apiClient: apiClient)

    return repository
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear {
          testGroceriesGraphQL()
        }
    }
  }

  func testGroceriesGraphQL() {
    let parameters = CampaignsQueryRequest(
      vendorId: "x1yy",
      globalEntityId: "FP_SG",
      locale: "en_SG"
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { campaigns in
          guard let campaigns = campaigns else {
            print("Groceries campaign query request fail, no campaigns founds")
            return
          }

          print("Groceries campaign query request success")
          print("Product Deals Count: \(campaigns.productDeals?.count ?? -1)")
          print("Campaign Attributes Count: \(campaigns.campaignAttributes?.count ?? -1)")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
