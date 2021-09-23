// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "dh-graphql-codegen-ios",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "GraphQLCodegen", targets: ["GraphQLCodegen"]),
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
      name: "GraphQLCodegen",
      dependencies: ["SwiftFormat", "GraphQLAST"]
    ),
    .target(
      name: "DHGraphQLCodegenCLI",
      dependencies: [
        "GraphQLCodegen",
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
      name: "GraphQLCodegenTests",
      dependencies: ["GraphQLCodegen", "GraphQLDownloader"],
      resources: [
        .process("Resources")
      ]
    )
  ]
)
