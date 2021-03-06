// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftGraphQLCodegen",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(name: "swift-graphql-codegen", targets: ["GraphQLCodegenCLI"])
  ],
  dependencies: [
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.41.2"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    .package(url: "https://github.com/kiliankoe/CLISpinner", .upToNextMajor(from: "0.4.0"))
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
      dependencies: ["SwiftFormat", "GraphQLCodegenConfig"]
    ),
    .target(
      name: "GraphQLCodegenNameSwift",
      dependencies: ["GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil"]
    ),
    .target(
      name: "GraphQLCodegenSpecSwift",
      dependencies: ["SwiftFormat", "GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil", "GraphQLCodegenNameSwift"]
    ),
    .target(
      name: "GraphQLCodegenApiClientSwift",
      dependencies: ["SwiftFormat", "GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil", "GraphQLCodegenNameSwift"]
    ),
    .target(
      name: "GraphQLCodegenMapperSwift",
      dependencies: ["SwiftFormat", "GraphQLAST", "GraphQLCodegenConfig", "GraphQLCodegenUtil", "GraphQLCodegenNameSwift"]
    ),
    .target(
      name: "GraphQLCodegenCLI",
      dependencies: [
        "GraphQLCodegenSpecSwift",
        "GraphQLCodegenApiClientSwift",
        "GraphQLCodegenMapperSwift",
        "GraphQLDownloader",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "CLISpinner", package: "CLISpinner")
      ]
    ),
    .target(
      name: "GraphQLDownloader",
      dependencies: [
        "GraphQLAST"
      ]
    ),
    .testTarget(
      name: "GraphQLCodegenCLITests",
      dependencies: ["GraphQLCodegenCLI"]
    ),
    .testTarget(
      name: "GraphQLCodegenSpecSwiftTests",
      dependencies: ["GraphQLCodegenSpecSwift", "GraphQLDownloader"],
      resources: [
        .process("Resources")
      ]
    ),
    .testTarget(
      name: "GraphQLCodegenNameSwiftTests",
      dependencies: ["GraphQLCodegenNameSwift", "GraphQLDownloader", "GraphQLCodegenApiClientSwift"]
    ),
    .testTarget(
      name: "GraphQLStringCaseTests",
      dependencies: ["SwiftFormat", "GraphQLCodegenConfig", "GraphQLCodegenUtil", "GraphQLDownloader"]
    ),
    .testTarget(
      name: "GraphQLCodegenApiClientSwiftTests",
      dependencies: ["GraphQLCodegenApiClientSwift", "GraphQLDownloader"],
      resources: [
        .process("Resources")
      ]
    )
  ]
)
