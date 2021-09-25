// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "dh-graphql-codegen-ios",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "GraphQLCodegenConfig", targets: ["GraphQLCodegenConfig"]),
    .library(name: "GraphQLCodegenUtil", targets: ["GraphQLCodegenUtil"]),
    .library(name: "GraphQLSwiftCodegen", targets: ["GraphQLSwiftCodegen"]),
    .library(name: "DHGraphQLApiClientCodegen", targets: ["DHGraphQLApiClientCodegen"]),
    .library(name: "GraphQLAST", targets: ["GraphQLAST"]),
    .library(name: "GraphQLDownloader", targets: ["GraphQLDownloader"]),
    .executable(name: "dh-graphql-codegen-ios", targets: ["DHGraphQLCodegenCLI"])
  ],
  dependencies: [
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.41.2"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0")
  ],
  targets: [
    .target(
      name: "GraphQLAST",
      dependencies: []
    ),
    .target(
      name: "GraphQLCodegenConfig",
      dependencies: []
    ),
    .target(
      name: "GraphQLCodegenUtil",
      dependencies: ["SwiftFormat"]
    ),
    .target(
      name: "GraphQLSwiftCodegen",
      dependencies: ["SwiftFormat", "GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil"]
    ),
    .target(
      name: "DHGraphQLApiClientCodegen",
      dependencies: ["SwiftFormat", "GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil"]
    ),
    .target(
      name: "DHGraphQLCodegenCLI",
      dependencies: [
        "GraphQLSwiftCodegen",
        "DHGraphQLApiClientCodegen",
        "GraphQLDownloader",
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]
    ),
    .target(
      name: "GraphQLDownloader",
      dependencies: [
        "GraphQLAST"
      ]
    ),
    .testTarget(
      name: "DHGraphQLCodegenCLITests",
      dependencies: ["DHGraphQLCodegenCLI"]
    ),
    .testTarget(
      name: "GraphQLSwiftCodegenTests",
      dependencies: ["GraphQLSwiftCodegen", "GraphQLDownloader"],
      resources: [
        .process("Resources")
      ]
    )
  ]
)
