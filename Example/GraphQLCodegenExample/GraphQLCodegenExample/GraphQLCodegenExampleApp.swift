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

    let apiClient = GroceriesApiClient(
      restClient: restClient,
      resourceParametersProvider: GraphQLResourceParametersProvider()
    )
    let repository = GroceriesRepository(apiClient: apiClient)

    return repository
  }()

  private let starWarsRepository: StarWarsRepository = {
    let restClient = RestClientImpl(
      webService: StarWarsWebService(),
      authProvider: nil
    )

    let apiClient = StarWarsApiClient(
      restClient: restClient,
      resourceParametersProvider: nil
    )
    let repository = StarWarsRepository(apiClient: apiClient)

    return repository
  }()

  var body: some Scene {
    WindowGroup {
      ContentView().onAppear() {
        testGroceriesGraphQL()
        testStarWarsInterfaceGraphQL()
        testStarWarsUnionHumanGraphQL()
        testStarWarsUnionDroidGraphQL()
      }
    }
  }
}

extension GraphQLCodegenExampleApp {
  func testGroceriesGraphQL() {
    let parameters = CampaignsQueryRequest(
      vendorId: "x1yy",
      globalEntityId: "FP_SG",
      locale: "en_SG",
      languageId: "1",
      languageCode: "en",
      apiKey: "iQis4oC8Y4DxHiO5",
      discoClientId: "iOS"
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { response in
          print("Groceries campaign query request success")
          // print(String(describing: response))
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsInterfaceGraphQL() {
    let parameters = CharactersStarWarsQuery(
      selections: .init(
        characterSelections: [],
        droidSelections: [],
        humanSelections: [.homePlanet]
      )
    )

    starWarsRepository
      .characters(with: parameters)
      .subscribe(
        onSuccess: { response in
          print("Starwars characters interface query request success")
          // print(response)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsUnionHumanGraphQL() {
    let parameters = CharacterStarWarsQuery(
      id: "1000",
      selections: .init(
        characterUnionSelections: [.all],
        droidSelections: [],
        humanSelections: [.infoURL]
      )
    )

    starWarsRepository
      .character(with: parameters)
      .subscribe(
        onSuccess: { response in
          switch response {
          case let .human(human):
            print("Starwars character union query request as human success")
          default :
            print("Starwars character union query request as human failed xxxx")
          }

          // print(response)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsUnionDroidGraphQL() {
    let parameters = CharacterStarWarsQuery(
      id: "2000",
      selections: .init(
        droidSelections: [],
        humanSelections: []
      )
    )

    starWarsRepository
      .character(with: parameters)
      .subscribe(
        onSuccess: { response in
          switch response {
          case .droid:
            print("Starwars character union query request as droid success")
          default :
            print("Starwars character union query request as droid failed xxxx")
          }

          // print(response)
        },
        onError: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
