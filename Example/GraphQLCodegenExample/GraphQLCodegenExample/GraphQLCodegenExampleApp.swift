//
//  GraphQLCodegenExampleApp.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/9/21.
//

import ApiClient
import RxSwift
import SwiftUI

@main
struct GraphQLCodegenExampleApp: App {
  private let disposeBag = DisposeBag()
  private let groceriesRepository: Repositoring = {
    let restClient = RestClientImpl(
      webService: GroceriesWebService(),
      authProvider: nil
    )

    let repository = Repository(restClient: restClient)

    return repository
  }()

  var body: some Scene {
    WindowGroup {
      ContentView().onAppear() {
        try? testGroceriesGraphQL()
      }
    }
  }
}

extension GraphQLCodegenExampleApp {
  func testGroceriesGraphQL() throws {
    let parameters = QueryParameter.CampaignsRequestParameter(
      vendorId: "x1yy",
      globalEntityId: "FP_SG",
      locale: "en_SG",
      languageId: "1",
      languageCode: "en",
      apikY: "iQis4oC8Y4DxHiO5",
      discoClientId: "iOS",
      selections: .init(
        benefitSelections: [],
        campaignAttributeSelections: [],
        campaignsSelections: [],
        dealSelections: [],
        productDealSelections: []
      )
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { response in
          guard let data = response.data else {
            print("Empty Response Data")
            return
          }
          print(data)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
