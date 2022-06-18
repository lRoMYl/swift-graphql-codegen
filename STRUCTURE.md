# Diagram
## App Codegen Overview
This diagram illustrate how the generated code will be integrated into example application.

![App Overview](https://user-images.githubusercontent.com/5739692/148887375-c15deced-937e-47f2-9871-97d4fb971b83.png)

## Codegen Flow
This diagram is the overview for the simplified code generation flow created specifically for Swift code.

Sub Command: swift-graphql-codegen bootstrap

![Codegen Flow Diagram](https://user-images.githubusercontent.com/5739692/148887387-ea0b3251-41e2-4de2-ab83-23d6d442762c.png)

## Introspection Flow
Introspection is the action to fetch GraphQL Abstract Syntax Tree (AST) to be interpreted locally for codegeneration.

Sub Command: swift-graphql-codegen introspection

![Introspection Flow Diagram](https://user-images.githubusercontent.com/5739692/148887398-cc723991-f0e6-4df8-8a91-06f73b61a824.png)

# Project Folder Structure 
The project is broken down into multiple folder in which each folder should be responsible to either a single library reponsibility or generator.

Each generator should be generating exactly 1 file, if the generated files logic are tightly coupled, thus making code separation into multiple module difficult, do consider creating subfolder in a single parent folder.

E.g. 
- GraphQLCodegenApiClientSwift: Generate ApiClient.swift
- GraphQLCodegenSpecSwift: Parent doesn't generate file
    - GraphQLCodegenEntitySwift: Subfolder, Generate Entity.swift
    - GraphQLCodegenModelSwift: Subfolder, Generate Model.swift

## Common
These are the common packages in this repository which can be shared across all platform and generally require any or minimal rewrites.
| Name | Description | 
| - | - |
| GraphQLAST | AST stands for Abstract Syntax Tree which simply means complex nested object. This is the package to decode the GraphQL AST/Schema which allows us to traverse through the specification when generating code |
| GraphQLCodegenCLI | This is the terminal app package which contains the command and subcommands, documentation and logic to use other packages for code generation |
| GraphQLDownloader | API Client used by the terminal (CLI) to fetch  GraphQL schema remotely | 
| GraphQLCodegenConfig | This package contains the specification for code generation common configuration which can be used to customize the output. Refer to the readme for configuration for more details |
| GraphQLCodegenNameSwift | This package contains logic for class naming convention, this is helpful to ensure any customization done to naming will remain consistent across generator packages. E.g. Changes in core classes naming from `GraphQLRequest` to `MyGraphQLRequest` will be reflected automatically in all generated file |
| GraphQLCodegenUtil | Common extension/utility file which can be shared across language. E.g md5 hash generation, camelcase, pascalcase |

## Platform specific packages
These packages contains generators that are specific to organization or platform that are not suitable to be reused anywhere.

| Name | Description | 
| - | - |
| GraphQLCodegenApiClientSwift | This package contains the generator for DeliveryHero flavor API Client for swift specifically |
| GraphQLCodegenSpecSwift | Thus package contains the generator for `core entities` and `network models` |

## TBD
These packages are either work in progress or doesn't have a timeline yet, thus these packages are not usable

| Name | Description | 
| - | - |
| GraphQLCodegenMapperSwift | This is the generator package to generate a mapper class that would ensure type safety at build and run time. However this package is incomplete and require further discussion and experimentation, no concrete timeline for this package atm. |
