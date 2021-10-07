//
//  File.swift
//  
//
//  Created by Romy Cheah on 6/10/21.
//

import GraphQLCodegenCLICore

func mockGroceriesExample() throws {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/dh-graphql-codegen-ios/Example/GroceriesExample (Basic)"

  let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
  let entityOutputPath = "\(examplePath)/GroceriesExample/API/Core/"
  let groceriesOutputPath = "\(examplePath)/GroceriesExample/API/Groceries/Groceries"

  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "entity",
      "--output", "\(entityOutputPath)GraphQLEntities.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "specification",
      "--output", "\(groceriesOutputPath)GraphQLNetworkModels.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "dh-apiclient",
      "--output", "\(groceriesOutputPath)ApiClient.swift",
      "--config-path", groceriesConfig
    ]
  )
}

func mockGraphQLExample() {
  // GraphQLCodegenCLI.main(
  //  [
  //    "https://sg-st.fd-api.com/groceries-product-service/query",
  //    "--action", "introspection",
  //    "--schema-source", "remote",
  //    "--output", "/Users/r.cheah/Desktop/schema.json"
  //  ]
  // )
  //
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/dh-graphql-codegen-ios/Example/GraphQLCodegenExample (Advanced)"

  let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
  let groceriesOutputPath = "\(examplePath)/GraphQLCodegenExample/Groceries/Groceries"

  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "entity",
      "--output", "\(examplePath)/GraphQLCodegenExample/Core/GraphQLEntities.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "specification",
      "--output", "\(groceriesOutputPath)GraphQLNetworkModels.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLICore.main(
    [
      groceriesSchema,
      "--target", "dh-apiclient",
      "--output", "\(groceriesOutputPath)ApiClient.swift",
      "--config-path", groceriesConfig
    ]
  )

  let starwarsSchema = "\(examplePath)/GraphQL/starwars-schema.json"
  let starwarsConfig = "\(examplePath)/GraphQL/starwars-config.json"
  let starwarsOutputPath = "\(examplePath)/GraphQLCodegenExample/StarWars/StarWars"

  GraphQLCodegenCLICore.main(
    [
      starwarsSchema,
      "--target", "specification",
      "--output", "\(starwarsOutputPath)GraphQLSpec.swift",
      "--config-path", starwarsConfig
    ]
  )
  GraphQLCodegenCLICore.main(
    [
      starwarsSchema,
      "--target", "dh-apiclient",
      "--output", "\(starwarsOutputPath)GraphQLApiClient.swift",
      "--config-path", starwarsConfig
    ]
  )
}
