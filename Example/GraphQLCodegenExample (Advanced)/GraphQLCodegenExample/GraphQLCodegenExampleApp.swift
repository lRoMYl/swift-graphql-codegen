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
      resourceParametersConfigurator: GroceriesResourceParametersConfigurator()
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
      restClient: restClient
    )
    let repository = StarWarsRepository(apiClient: apiClient)

    return repository
  }()

  private let apolloRepository: ApolloRepository = {
    let restClient = RestClientImpl(
      webService: ApolloWebService(),
      authProvider: nil
    )

    let apiClient = ApolloApiClient(restClient: restClient)
    let repository = ApolloRepository(apiClient: apiClient)

    return repository
  }()

  var body: some Scene {
    WindowGroup {
      ContentView().onAppear {
        testGroceriesGraphQL()
        testStarWarsInterfaceGraphQL()
        testStarWarsUnionHumanGraphQL()
        testStarWarsUnionDroidGraphQL()
        testStarWarsDateGraphQL()
        testStarWarsQueryGraphQL()
        testStarWarsGreetingQueryGraphQL()
        testStarWarsMutationGraphQL()
        testApolloMutationsGraphQL()
      }
    }
  }
}

extension GraphQLCodegenExampleApp {
  func testGroceriesGraphQL() {
    let parameters = CampaignsQueryRequest(
      globalEntityId: "FP_SG",
      locale: "en_SG",
      vendorId: "x1yy"
    )

    groceriesRepository
      .campaigns(with: parameters)
      .subscribe(
        onSuccess: { _ in
          print("Groceries campaign query request success")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsInterfaceGraphQL() {
    let parameters = CharactersStarWarsQuery()

    let expected = Array(
      [
        Array(repeating: String(describing: HumanStarWarsModel.self), count: 5),
        Array(repeating: String(describing: DroidStarWarsModel.self), count: 2)
      ]
      .joined()
    )

    starWarsRepository
      .characters(with: parameters)
      .subscribe(
        onSuccess: { characters in
          print("Starwars characters interface query request success")

          guard expected.count == characters.count else {
            print("Response count(\(characters.count)) != expected count(\(expected.count))")
            return
          }

          zip(characters, expected).enumerated().forEach { enumeration in
            let modelType: String
            let expectedType = enumeration.element.1

            switch enumeration.element.0 {
            case .human:
              modelType = String(describing: HumanStarWarsModel.self)
            case .droid:
              modelType = String(describing: DroidStarWarsModel.self)
            }

            if modelType != expectedType {
              print("Invalid type(\(modelType) but expected (\(expectedType) at \(enumeration.offset)")
            }
          }
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsUnionHumanGraphQL() {
    let parameters = CharacterStarWarsQuery(
      id: "1000"
    )

    starWarsRepository
      .character(with: parameters)
      .subscribe(
        onSuccess: { response in
          switch response {
          case .human:
            print("Starwars character union query request as human success")
          default:
            print("Starwars character union query request as human failed xxxx")
          }
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsUnionDroidGraphQL() {
    let parameters = CharacterStarWarsQuery(
      id: "2000"
    )

    starWarsRepository
      .character(with: parameters)
      .subscribe(
        onSuccess: { response in
          switch response {
          case .droid:
            print("Starwars character union query request as droid success")
          default:
            print("Starwars character union query request as droid failed xxxx")
          }
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsDateGraphQL() {
    starWarsRepository.time(with: .init())
      .subscribe(
        onSuccess: { response in
          print("Starwars time query request success: \(response.rawValue)")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsQueryGraphQL() {
    starWarsRepository
      .query(
        with: StarWarsQuery(
          character: .init(id: "1000"),
          characters: .init()
        )
      )
      .subscribe(
        onSuccess: { response in
          print("Test StarWarsQuery success")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsGreetingQueryGraphQL() {
    starWarsRepository
      .query(
        with: StarWarsQuery(
          greeting: .init(input: .init(language: .en, name: "Name"))
        )
      )
      .subscribe(
        onSuccess: { response in
          print("Test StarWarsQuery Greeting success")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testStarWarsMutationGraphQL() {
    starWarsRepository
      .mutate(with: .init())
      .subscribe(
        onSuccess: { response in
          print("Test StarWarsMutate success")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }

  func testApolloMutationsGraphQL() {
    apolloRepository
      .update(
        with: ApolloMutation(
          cancelTrip: .init(cancelTripMissionPatchSize: .small, launchId: "101"),
          login: .init(email: "test@test.com")
        )
      )
      .subscribe(
        onSuccess: { response in
          print("Test Apollo Mutation success")
        },
        onFailure: { error in
          print(error)
        }
      )
      .disposed(by: disposeBag)
  }
}
