# Swift GraphQL Codegen

## Objectives
- Zero GraphQL Query to be written manually
- Zero library/framework to be included in the main app
- Plain Swift Types with Type Safety
- Network Layer agnostic, use whichever networking library you prefer
- Favor Swift coding convention whenever applicable/possible 

Usage example without writing a single line of GraphQL query
```Swift
// Auto generated Request Model
let request = VendorQueryRequest(
  name: "vendor name", // Argument1 is code-generated
  country: .sg, // Argument2 is code-generated
)

// Auto generated ApiClient
let vendor = apiClient.vendor(
  with: request, 
  // Auto generated Selections class, this allows you to select
  // specifically which fields to be returned for this request
  selections: VendorQuerySelections(
    // An array of Enum representing the fields to be returned
    vendor: [.id, .name, .attributes], 
    // Alternatively, you can use `.allFields` explicitly to return all fields
    // All selections have `.allFields` as default value, so it's optional to explicitly assign this value.
    attributes: .allFields
  )
)
// Additional mapping if necessary
.map { response in // Response Model are auto generated
  // Assuming you have a Vendor domain model, this is how you would map it
  Vendor(
    // Similar to how Decodable can throw an Error, the fields in Response Model
    // are throwable so the proper error context can be returned to you for
    // debugging purpose, e.g.: Selection are missing for field name ***, please
    // rectify it by selecting the field.
    id: try response.id
    name: try response.name,
    attributes: try response.attributes
  )
  return responseModel 
}
// RxSwift
.subscribe...
```

Further reading
- [GETSTARTED.md](GETSTARTED.md) Step by step tutorial with examples on how to setup and integrate with the code generation tool.
- [TEMPLATES.md](TEMPLATES.md) Collections of template to help you get started with the code generation tool.
- [CONFIG.md](CONFIG.md) Overview on how to setup the config file
- [STRUCTURE.md](STRUCTURE.md) For overview of the entire code generation implementation structure
- [ADVANCED.md](ADVANCED.md) For detailed explanation of each sub-commands beyond `bootstrap`
- [ISSUES.md](ISSUES.md) List of known issues
- [CONTRIBUTE.md](CONTRIBUTE.md) How to contribute to this repository

## Reference
Code implementation is created based on [swift-graphl AST](https://github.com/maticzav/swift-graphql)

## Roadmap

Supports GraphQL Native Feature
- [x] Object
- [x] InputValue 
- [x] InputObject
- [x] Enum / Enumeration
- [x] Interface
- [x] Union
- [x] Query
- [x] Mutation
- [x] Subscription; Codes are generated except for ApiClient because ApiClient have no implementation for WebSocket yet
- [x] Introspection
- [x] Root level query
- [x] Recursive fragment resolution (Up to 5 recursion)
- [ ] Directive, no plan to support it atm.
- [ ] Aliases, no plan to support it atm.

Support Custom Requirements
- [x] SPM package
- [x] Brew package
- [x] Local schema
- [x] Remote schema, download using introspection query
- [x] Remote schema authorization headers
- [x] Remote schema cache
- [x] Scalar Map extension
- [x] Entity Name Map, override entity naming convention using config
- [x] Custom field whitelisting
- [x] Custom query/mutation/subscription whitelisting
- [x] Support for custom unknown enum, this is necessary to ensure the generated code can work with future unknown enum value
- [x] Support for optional namespace to avoid naming collision
- [x] Default APIClient
- [x] Provide service dependency injection for APIClient
- [x] Subcommand to simplify code generation

TODO
- [x] Nested field selection with arguments is not handled yet
- [x] ApiClientPrefix needs to be removed from EntityNameMap
- [ ] Rewrite ApiClient generator to use URLSession
- [ ] Ramp up test cases for the generated classes
- [ ] Ramp up documentation
- [ ] Setting up CI workflow to run the test for each PR
- [ ] Adding performance metric when generating GraphQL Query at runtime

Future
- [ ] Mapper class, the mapping logic will also be used to compute the selections automatically

## Installation
```
brew tap lromyl/tap

brew install swift-graphql-codegen
# if there are conflict, use the command below instead 
brew install lromyl/tap/swift-graphql-codegen
```

Goto [GETSTARTED.md](GETSTARTED.md) for detailed step-by-step to installing the CLI, setting up environment variables and examples on integration.

## How to use

### CLI Codegen Syntax

**Download remote schema as introspection file**

| Type | Name | Optional | Description | 
| - | - | - | - |
| argument | `schema` | No | Path or URL of the GraphQL Schema |
| option | `--output-path` | No | The directory to generate all the files |
| option | `--output` | Yes | The file name, default is `schema.json` |

Example command
```
swift-graphql-codegen introspection "https://www.domain.com" --output-path "directory_name"
```

---

**Generate GraphQL files**

| Type | Name | Optional | Description | 
| - | - | - | - |
| argument | schema | No | Path or URL of the GraphQL Schema |
| option | `--output-path` | No | The directory to generate all the files |
| option | `--api-client-prefix` | No | The prefix to generate ApiClient related files, this will affect the folders and class name |
| option | `--schema-source`| Yes | Source of the schema, `local` and `remote` |
| option | `--config-path` | Yes | File path of the configuration |
| flag | `--is-throwable-getter-enabled` | Yes | Specify if the generated code could use throwable getter introduced in Swift 5.5 |

There are other optional option that can be used to manipulate the generated file names, type `swift-graphql-codegen bootstrap --help` command to see the full list

Example command
```
swift-graphql-codegen bootstrap "schema.json" --config-path "config.json" --output-path "API"  --api-client-prefix "Groceries"
```
---

# Alternatives

## [apollo-ios](https://github.com/apollographql/apollo-ios)
apollo-ios is the most popular GraphQL codegeneration tool for Swift that comes with networking layer, web socket, caching and etc.

The a few key differences between apollo-ios and swift-graphql-codegen
- swift-graphql-codegen generated codes have no external dependencies, so you can continue to use whichever networking framework in your project without importing a new dependencies.
- swift-graphql-codegen handle on generate most of the common `GraphQL Operation` on code level so you don't have to write a single line of GraphQL syntax.
- apollo-ios generate unique models for every single `GraphQL Operation` you include in the projects so there are a lot of redundant codes, it can easily have more than ten thousands lines of generated code if you have a moderate size backend with more than 10 `GraphQL Operation`.
  - Using the [Apollo Fullstack Tutorial](https://apollo-fullstack-tutorial.herokuapp.com/) as a benchmark
  - apollo-ios will generate `8000+` lines of code for `15` `GraphQL Operation`
  - swift-graphql-codegen will generate `2000+` lines of code irregardless of how many `GraphQL Operation` you will need.
  - For our use case, the backend are much larger than the sample project in the tutorial and have at least `50+` `GraphQL Operation`, thus using apollo-ios is not feasible at all.

## [swift-graphl](https://github.com/maticzav/swift-graphql)

swift-graphql-codegen is designed with swift-grapqhl as a reference so there are a lot of similarities in how it works

The key differences are
- swift-grapqhl-codegen generated code doesn't have dependencies on any networking layer
- swift-graphql-codegen request and selection is done on request model, so it's decoupled from the mapping logic while swift-grapqhl derived the selections directly from the mapping logic.
  - `swift-graphql` mapping and selection logic is tightly coupled so you will need to define how the mapping is done before a request can be executed. 
  - This approach provide build-time safety at the expense of more boilerplate up-front and possibly a violation of single responsibility.
  - `swift-graphql-codegen` decoupled both selection and mapping logic so it's possible to execute the query without defining the mapping logic.
  - The mapping-selection logic can be included in the next phase as an optional module which provides build-time safety.
  - `swift-graphql-codegen` defined selections and arguments on request parameter while `swift-graphql` defined it through mapping logic. Both implementations are entirely different so please read the code example for more insight.
