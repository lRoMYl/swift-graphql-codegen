//
//  File.swift
//  
//
//  Created by Romy Cheah on 6/10/21.
//

import GraphQLCodegenCLICore

func mockBasicExample() throws {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/dh-graphql-codegen-ios/Example/GroceriesExample (Basic)"

  // Generate schema.json from
  let remoteGroceriesSchema = "https://sg-st.fd-api.com/groceries-product-service/query"
  let introspectionOutputPath = examplePath + "/GraphQL/"

  GraphQLCodegenCLI.Introspection.main([
    remoteGroceriesSchema,
    "--output-path", introspectionOutputPath
  ])

  // Generate GraphQL codes
  let groceriesSchema = "\(examplePath)/GraphQL/schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/config.json"
  let outputPath = "\(examplePath)/GroceriesExample/API/"

  GraphQLCodegenCLI.DHSwift.main([
    groceriesSchema,
    "--config-path", groceriesConfig,
    "--output-path", outputPath,
    "--api-client-prefix", "Groceries"
  ])
}

func mockBasicCoreExample() throws {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/dh-graphql-codegen-ios/Example/GroceriesExample (Basic)"

  let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
  let entityOutputPath = "\(examplePath)/GroceriesExample/API/Core/"
  let groceriesOutputPath = "\(examplePath)/GroceriesExample/API/Groceries/Groceries"

  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.entity.rawValue,
      "--output", "\(entityOutputPath)GraphQLEntities.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(groceriesOutputPath)GraphQLNetworkModels.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.dhApiClient.rawValue,
      "--output", "\(groceriesOutputPath)ApiClient.swift",
      "--config-path", groceriesConfig
    ]
  )
}

func mockAdvancedCoreExample() {
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

  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.entity.rawValue,
      "--output", "\(examplePath)/GraphQLCodegenExample/Core/GraphQLEntities.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(groceriesOutputPath)GraphQLNetworkModels.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLI.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.dhApiClient.rawValue,
      "--output", "\(groceriesOutputPath)ApiClient.swift",
      "--config-path", groceriesConfig
    ]
  )

  let starwarsSchema = "\(examplePath)/GraphQL/starwars-schema.json"
  let starwarsConfig = "\(examplePath)/GraphQL/starwars-config.json"
  let starwarsOutputPath = "\(examplePath)/GraphQLCodegenExample/StarWars/StarWars"

  GraphQLCodegenCLI.main(
    [
      starwarsSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(starwarsOutputPath)GraphQLSpec.swift",
      "--config-path", starwarsConfig
    ]
  )
  GraphQLCodegenCLI.main(
    [
      starwarsSchema,
      "--target", CodegenTarget.dhApiClient.rawValue,
      "--output", "\(starwarsOutputPath)GraphQLApiClient.swift",
      "--config-path", starwarsConfig
    ]
  )
}
