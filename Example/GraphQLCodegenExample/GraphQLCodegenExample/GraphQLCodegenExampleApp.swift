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
  private let groceriesRepository: GroceriesRepository = {
    let restClient = RestClientImpl(
      webService: GroceriesWebService(),
      authProvider: nil
    )

    let apiClient = GroceriesApiClient(restClient: restClient)
    let repository = GroceriesRepository(apiClient: apiClient)

    return repository
  }()

  private let starWarsRepository: StarWarsRepository = {
    let restClient = RestClientImpl(
      webService: StarWarsWebService(),
      authProvider: nil
    )

    let apiClient = StarWarsApiClient(restClient: restClient)
    let repository = StarWarsRepository(apiClient: apiClient)

    return repository
  }()

  var body: some Scene {
    WindowGroup {
      ContentView().onAppear() {
        setup()

        try? testGroceriesGraphQL()
        try? testStarWarsInterfaceGraphQL()
      }
    }
  }
}

extension GraphQLCodegenExampleApp {
  func setup() {
    GroceriesResourceParametersDIContainer.shared.implementation
      = GraphQLResourceParametersProvider()
  }

  func testGroceriesGraphQL() throws {
    let parameters = CampaignsQueryRequest(
      vendorId: "x1yy",
      globalEntityId: "FP_SG",
      locale: "en_SG",
      languageId: "1",
      languageCode: "en",
      apikY: "iQis4oC8Y4DxHiO5",
      discoClientId: "iOS"
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { response in
          print(response)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsInterfaceGraphQL() throws {
    let parameters = CharactersStarWarsQuery(
      selections: .init(
        characterSelections: [.all],
        droidSelections: [.all],
        humanSelections: [.homePlanet]
      )
    )

    starWarsRepository
      .characters(with: parameters)
      .subscribe(
        onSuccess: { response in
          print(response)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
