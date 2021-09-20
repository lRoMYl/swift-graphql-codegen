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
    .executable(name: "dh-graphql-codegen-ios", targets: ["DHGraphQLCodegenSwift"])
  ],
  dependencies: [
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.41.2"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0")
  ],
  targets: [
    .target(
      name: "GraphQLAST",
      dependencies: [],
      path: "Sources/GraphQLAST"),
    .target(
      name: "GraphQLCodegen",
      dependencies: ["SwiftFormat", "GraphQLAST"],
      path: "Sources/GraphQLCodegen"),
    .target(
      name: "DHGraphQLCodegenSwift",
      dependencies: [
        "GraphQLCodegen",
        "GraphQLDownloader",
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]),
    .target(
      name: "GraphQLDownloader",
      dependencies: [
        "GraphQLAST"
      ],
      path: "Sources/GraphQLDownloader"),
    .testTarget(
      name: "DHGraphQLCodegenSwiftTests",
      dependencies: ["DHGraphQLCodegenSwift"]),
    .testTarget(
      name: "GraphQLCodegenTests",
      dependencies: ["GraphQLCodegen"]
    )
  ]
)
