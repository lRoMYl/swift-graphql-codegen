# DHGraphQLCodegen

DH GraphQL Codegen Tool
- Plain Swift Types without external dependencies
- Network layer agnostic
  - DH flavor APIClient code generation is available

Usage example without writing a single line of GraphQL query
```
let request = VendorQueryRequest(
  name: "vendor name", // Argument1 is code-generated
  country: .sg,  // Argument2 is code-generated
)

repository.vendor(with: request) { ... }
```

Further reading
- [GETSTARTED.md](GETSTARTED.md) Step by step tutorial with examples on how to setup and integrate with the code generation tool.
- [CONFIG.md](CONFIG.md) Overview on how to setup the config file
- [STRUCTURE.md](STRUCTURE.md) For overview of the entire code generation implementation structure
- [ADVANCED.md](ADVANCED.md) For detailed explanation of each sub-commands beyond `dh-swift`

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
- [x] Subscription; Codes are generated except for ApiClient because DH ApiClient have no implementation for WebSocket yet
- [x] Introspection
- [x] Root level query
- [ ] Directive, no plan to support it atm.
- [ ] Aliases, no plan to support it atm.

Support DH Custom Feature
- [x] SPM package
- [x] Brew package
- [x] Local schema
- [x] Remote schema, download using introspection query
- [x] Remote schema authorization headers
- [x] Remote schema cache
- [x] Scalar Map extension
- [x] Entity Name Map, override entity naming convention using config
- [x] Custom field whitelisting
- [ ] Custom query/mutation/subscription whitelisting
- [x] Support for custom unknown enum, this is necessary to ensure the generated code can work with future unknown enum value
- [x] Support for optional namespace to avoid naming collision
- [x] DH flavor APIClient
- [x] Provide service dependency injection for DH flavor APIClient
- [x] DHSwift subcommand to simplify code generation

TODO
- [x] Nested field selection with arguments is not handled yet
- [x] ApiClientPrefix needs to be removed from EntityNameMap
- [x] Ramp up test cases
- [x] Ramp up documentation

Future
- [ ] Mapper class, the mapping logic will also be used to compute the selections automatically
- [ ] Rewrite code generator using Sourcery?

## Pre-requisite
- MacOS 12.2.1 and above
- XCode 13.2.1 and above

## Installation
```
brew tap lromyl/tap

brew install swift-graphql-codegen
# if there are conflict, use the command below instead 
brew install lromyl/tap/swift-graphql-codegen
```

## Setup

For this code generation tool, we would need to create a environment variable for github api token, `HOMEBREW_GITHUB_API_TOKEN`.

To configure it, you can follow the steps belows;

**Creating Github API Token**
- Goto https://github.com/settings/tokens/new
  - If the link is broken, you can locate it in your `Github Settings -> Developer Settings -> Personal Access Tokens`
- Tap on `Generate new token` at the top of the page
- [Optional] Recommended to write in the `Note` field to indicate this access token is exclusively for homebrew
- [Optional] Change the `Expiration` from the default value of 30 days to something longer or no expiration, you can revoke this access token anytime when necessary
- [Required] In `Select scopes` field, tick the `repo` checkbox as this would be required for the codegen library, no other scopes are required for this codegen.
- Tap on `Generate token` at the bottom of the page.
- [Important] You will be redirected back to `Personal Access Tokens` page and be shown the raw value of the access token you've just created, `copy` it to a temporary notepad as you will only be shown this value once.
- [Optional] In `Personal Access Tokens` page, you will see a `Configure SSO` button next to your access token, tap on it and authorize your organization SSO for this token.

**Adding Github API Token to Environment Variable**
- Locate either `~/.bash_profile` or `~/.zshenv` (If you're using zsh) to update environment variables
  - If it doesn't exist, you can create it by using `touch ~/.bash_profile` or `~/.zshenv` in the terminal
- Add `export HOMEBREW_GITHUB_API_TOKEN="put your token"` into the file, save it
- Restart the terminal

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

There are other optional option that can be used to manipulate the generated file names, type `swift-graphql-codegen dh-swift --help` command to see the full list

Example command
```
swift-graphql-codegen dh-swift "schema.json" --config-path "config.json" --output-path "API"  --api-client-prefix "Groceries"
```
---

## How to create new release

**Manual**
- Draft a new release [here](https://github.com/lRoMYl/swift-graphql-codegen/releases) just like any other Github release.
- Download the Source code (tar.gz) for the release you've just created
- Obtain the sha256 of the tar.gz file. For example, you can use this [online tool](https://emn178.github.io/online-tools/sha256_checksum.html)
- Goto [homebrew-pd-tap-ios](https://github.com/lRoMYl/homebrew-tap) to update the homebrew formulae for this new release
  - Locate `swift-graphql-codegen.rb`
  - Update the `url` field to point to the new release url, generally we only need to update the version portion of the url. E.g. `https://github.com/lRoMYl/swift-graphql-codegen/archive/refs/tags/`0.3.1`.tar.gz`
  - Update the `sha` field with the new release tar.gz sha256
- Use `brew install --build-from-source swift-graphql-codegen.rb` command to test if the build succeded locally
- Create a new PR in [homebrew-pd-tap-ios](https://github.com/lRoMYl/swift-graphql-codegen) with the changes in `swift-graphql-codegen.rb`

**Automated**
- Its possible to just write a script in [homebrew-pd-tap-ios](https://github.com/lRoMYl/homebrew-tap) to update the version and sha256 with a single command line
- Will work on this later on when its necessary as there is some issues with the command to generate sha256 locally on my current local machine to test it properly.

### Example App
In both of the example app, just run `make install` command to install all the dependencies from carthage

In `Advanced Example`, you can look at the `Makefile` to see how to use `swift-graphql-codegen` using all the option to customize the output
```
make codegen-groceries
make codegen-starwars
make codegen-appolo
```

In `Basic Example`, you can look at the `Makefile` to see how to use `swift-graphql-codegen dh-swift` to generate all the files using only 3 option to achieve similar result to `Advanced Example`
```
make codegen-groceries
```

---

### Sample Query Code

Optional mapper class can be used to defined how to map the response model into application/domain model.

The mapper would then generate the selections based on which field will be used for the mapping to query only the fields used during the mapping logic.

e.g. 
- `VendorResponseModel` have 10 fields; `id`, `name`, `source` and etc.
- In the example below, we have a `Vendor` application/model which is used within the app
- Define which fields in `VendorResponseModel` are required to populate the `Vendor` domain model, in this case example only 2 fields are are used.
- The mapper class will compute all the selections used for this mapping and create a selections based on that, in this case 2 selections
- The api call will only request for only `2` fields although the response model have `10` fields.
- Using the mapper, we can guarantee the code to be build-time safe. (Unless if there is a bug in the generated code)
- However, using mapper is optional as this is a separate module but mapping and selections generation will need to be done manually and there is a risk of selections not being the same as the field expected from the response.

```Swift
// Auto generated NetworkModel
let request = VendorQueryRequest(
  name: "vendor name", 
  country: .sg,
)

// Auto generated DH flavor ApiClient
// Repository is not generated by the code generation tool, if you use Repository in your codebase, create it yourself and use apiClient in your repository code.
let vendor = apiClient.vendor(
  with: request, 
  selections: VendorQuerySelections(
    // Enum of fields to be returned specifically for this request
    vendor: [.id, .name, .attributes], 
    // Alternatively, you can use `.allFields` explicitly to return all fields
    // All selections have `.allFields` as default value, so it's optional to explicitly assign this value.
    attributes: .allFields
  )
)
.map { response in
  // Additional mapping if necessary
  return responseModel 
}
// RxSwift
.subscribe...
```

---

### Sample Config File
- A JSON file that can be passed into the CLI using `--config-path` 
- `namespace` define the optional namespace used for all codegenerated code, this is helpful to avoid naming collision as func/class name is defined from the schema which might conflict with existing code
- `apiHeaders` define the custom headers to be used for downloading the schema, this is useful to provide authorization headers for authentication
- `scalarMap` defines the custom mapping for Scalar type to native Swift type, code generation will fail if no mapping is found for custom scalar type
- `selectionMap` overrides which fields in the Schema `Type` should be included for code generation, by default all fields are included for code generation. This is useful to filter fields in `Type` that have tons of fields which the client have no intention of using.
- `entityNameMap` allows overriding of shared entity name used across all the codegeneration logic instead of manually modification in the code

```JSON
{
  "apiHeaders": {
    "authorization": "aasd8uioj213+="
  },
  "scalarMap": {
    "BigDecimal": "Double",
    "DateTime": "Double",
    "Long": "Double",
    "Upload": "String"
  },
  "selectionMap": {
    "Discount": ["type"]
  },
  "entityNameMap": {
    "request": "CustomRequestEntityName"
  }
}
```

---

### Sample App
- install all dh carthage dependencies
- run `make install` to install dh-graphlq-codegen-ios
- Build the example app, it will attempt to run the make script on each build phases to generate the latest GraphQL specification
- Look at example app `Makefile` for more examples to use the swift-graphql-codegen

---

# Troubleshooting

```
Xcode Swift Package Manager error - The repository could not be found
```

HTTPS connection failed due to proxy configuration, check your `~/.gitconfig` and remove the following statement temporarily

```
[url "git@github.com:"]
insteadOf = https://github.com/
```

---
```
Failed to create file at /API/Core/GraphQLEntities.generated.swift
```
Make sure the directory path exist, if not create it manually and retry again

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
