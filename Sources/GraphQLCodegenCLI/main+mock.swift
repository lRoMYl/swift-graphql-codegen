//
//  File.swift
//  
//
//  Created by Romy Cheah on 6/10/21.
//

import GraphQLCodegenApiClientSwift

func mockBasicExample() {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/swift-graphql-codegen/Example/GroceriesExample (Basic)"

  // Generate schema.json from
  let remoteGroceriesSchema = "https://sg-st.fd-api.com/groceries-graphql-gateway/query"
  let introspectionOutputPath = examplePath + "/GraphQL/"

  GraphQLCodegenCLI.Introspection.main([
    remoteGroceriesSchema,
    "--output-path", introspectionOutputPath
  ])

  // Generate GraphQL codes
  let groceriesSchema = "\(examplePath)/GraphQL/schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/config.json"
  let outputPath = "\(examplePath)/GroceriesExample/API/"

  GraphQLCodegenCLI.Bootstrap.main([
    groceriesSchema,
    "--config-path", groceriesConfig,
    "--output-path", outputPath,
    "--api-client-prefix", "",
    "--is-throwable-getter-enabled",
    "--api-client-strategy", ApiClientStrategy.rxSwift.rawValue,
    "--api-client-output", "Groceries/ApiClient.generated.swift"
  ])
}

func mockBasicCoreExample() throws {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/swift-graphql-codegen/Example/GroceriesExample (Basic)"

  let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
  let entityOutputPath = "\(examplePath)/GroceriesExample/API/Core/"
  let groceriesOutputPath = "\(examplePath)/GroceriesExample/API/Groceries/Groceries"

  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.entity.rawValue,
      "--output", "\(entityOutputPath)GraphQLEntities.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(groceriesOutputPath)NetworkModels.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.apiClient.rawValue,
      "--output", "\(groceriesOutputPath)ApiClient.swift",
      "--config-path", groceriesConfig
    ]
  )
}

func mockAdvancedCoreExample() {
  let examplePath = "/Users/r.cheah/Repos/lRoMYl/swift-graphql-codegen/Example/GraphQLCodegenExample (Advanced)"

  // --- Groceries Introspection
  let groceriesIntrospectionOutput = examplePath + "/GraphQL/groceries-schema.json"

  GraphQLCodegenCLI.Codegen.main(
    [
      "https://sg-st.fd-api.com/groceries-product-service/query",
      "--target", CodegenTarget.introspection.rawValue,
      "--schema-source", "remote",
      "--output", groceriesIntrospectionOutput
    ]
  )

  // --- Groceries
  let groceriesSchema = "\(examplePath)/GraphQL/groceries-schema.json"
  let groceriesConfig = "\(examplePath)/GraphQL/groceries-config.json"
  let groceriesOutputPath = "\(examplePath)/GraphQLCodegenExample/Groceries/Groceries"

  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.entity.rawValue,
      "--output", "\(examplePath)/GraphQLCodegenExample/Core/GraphQLEntities.generated.swift",
      "--config-path", groceriesConfig
    ]
  )

  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(groceriesOutputPath)NetworkModels.generated.swift",
      "--config-path", groceriesConfig
    ]
  )
  GraphQLCodegenCLI.Codegen.main(
    [
      groceriesSchema,
      "--target", CodegenTarget.apiClient.rawValue,
      "--output", "\(groceriesOutputPath)ApiClient.generated.swift",
      "--config-path", groceriesConfig,
      "--api-client-prefix", "Groceries"
    ]
  )

//  GraphQLCodegenCLI.Codegen.main(
//    [
//      groceriesSchema,
//      "--target", CodegenTarget.mapper.rawValue,
//      "--output", "\(groceriesOutputPath)Mappers.generated.swift",
//      "--config-path", groceriesConfig
//    ]
//  )

  // --- StarWars
  let starwarsSchema = "\(examplePath)/GraphQL/starwars-schema.json"
  let starwarsConfig = "\(examplePath)/GraphQL/starwars-config.json"
  let starwarsOutputPath = "\(examplePath)/GraphQLCodegenExample/StarWars/StarWars"

  GraphQLCodegenCLI.Codegen.main(
    [
      starwarsSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(starwarsOutputPath)GraphQLSpec.generated.swift",
      "--config-path", starwarsConfig
    ]
  )
  GraphQLCodegenCLI.Codegen.main(
    [
      starwarsSchema,
      "--target", CodegenTarget.apiClient.rawValue,
      "--output", "\(starwarsOutputPath)GraphQLApiClient.generated.swift",
      "--config-path", starwarsConfig,
      "--api-client-prefix", "StarWars"
    ]
  )

//  GraphQLCodegenCLI.Codegen.main(
//    [
//      starwarsSchema,
//      "--target", CodegenTarget.mapper.rawValue,
//      "--output", "\(starwarsOutputPath)Mappers.generated.swift",
//      "--config-path", starwarsConfig
//    ]
//  )

  // --- Apollo Introspection
  let apolloSchema = examplePath + "/GraphQL/apollo-schema.json"
  let apolloConfig = "\(examplePath)/GraphQL/apollo-config.json"
  let apolloOutputPath = "\(examplePath)/GraphQLCodegenExample/Apollo/Apollo"

  GraphQLCodegenCLI.Codegen.main(
    [
      "https://apollo-fullstack-tutorial.herokuapp.com/",
      "--target", CodegenTarget.introspection.rawValue,
      "--schema-source", "remote",
      "--output", apolloSchema
    ]
  )

  // --- Apollo

  GraphQLCodegenCLI.Codegen.main(
    [
      apolloSchema,
      "--target", CodegenTarget.specification.rawValue,
      "--output", "\(apolloOutputPath)GraphQLSpec.generated.swift",
      "--config-path", apolloConfig
    ]
  )
  GraphQLCodegenCLI.Codegen.main(
    [
      apolloSchema,
      "--target", CodegenTarget.apiClient.rawValue,
      "--output", "\(apolloOutputPath)GraphQLApiClient.generated.swift",
      "--config-path", apolloConfig,
      "--api-client-prefix", "Apollo"
    ]
  )

//  GraphQLCodegenCLI.Codegen.main(
//    [
//      apolloSchema,
//      "--target", CodegenTarget.mapper.rawValue,
//      "--output", "\(apolloOutputPath)Mappers.generated.swift",
//      "--config-path", apolloConfig
//    ]
//  )
}
