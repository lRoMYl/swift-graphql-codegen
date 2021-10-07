# DHGraphQLCodegen [WIP]

DH GraphQL Codegen Tool
- Plain Swift Types without external dependencies
- Network layer agnostic
  - DH flavor APIClient code generation

Usage example without writing a single line of GraphQL query
```
let request = VendorQueryRequest(
  name: "vendor name", // Argument1 is code-generated
  country: .sg,  // Argument2 is code-generated
)

repository.vendor(with: request) { ... }
```

Code implementation is created based on [swift-graphl AST](https://github.com/maticzav/swift-graphql)

## Roadmap

Supports GraphQL Native Feature
- [x] Object
- [x] InputObject
- [x] Enum / Enumeration
- [x] Interface
- [x] Union
- [x] Query
- [x] Mutation
- [x] Subscription; Partial support, request/response/respository/resource are generated but DH ApiClient doesn't have native support for WebSocket yet
- [x] Introspection
- [ ] Root level query

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

## Installation
```
brew tap lromyl/tap

brew install dh-graphql-codegen-ios
# if there are conflict, use the command below instead 
brew install lromyl/tap/dh-graphql-codegen-ios 
```

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
dh-graphql-codegen introspection "https://www.domain.com" --output-path "directory_name"
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

There are other optional option that can be used to manipulate the generated file names, type `dh-graphql-codegen dh-swift --help` command to see the full list

Example command
```
dh-graphql-codegen dh-swift "schema.json" --config-path "config.json" --output-path "API"  --api-client-prefix "Groceries"
```
---

### Example App
In both of the example app, just run `make install` command to install all the dependencies from carthage

In `Advanced Example`, you can look at the `Makefile` to see how to use `dh-graphql-codegen graph-ql-codengen` using all the option to customize the output
```
make codegen-groceries
make codegen-starwars
```

In `Basic Example`, you can look at the `Makefile` to see how to use `dh-graphql-codegen dh-swift` to generate all the files using only 3 option to achieve similar result to `Advanced Example`
```
make codegen-groceries
```

---

### Sample Query Code
```
let request = VendorQueryRequest(
  name: "vendor name", // Argument1 is code-generated
  country: .sg,  // Argument2 is code-generated
)

repository.vendor(with: request) { ... }
```

---

### Sample Config File
- A JSON file that can be passed into the CLI using `--config-path` 
- `namespace` define the optional namespace used for all codegenerated code, this is helpful to avoid naming collision as func/class name is defined from the schema which might conflict with existing code
- `apiHeaders` define the custom headers to be used for downloading the schema, this is useful to provide authorization headers for authentication
- `scalarMap` defines the custom mapping for Scalar type to native Swift type, code generation will fail if no mapping is found for custom scalar type
- `selectionMap` defines custom field whitelisting for selections, overrides the schema specification to only query the fields required by client use case
- `entityNameMap` allows overriding of shared entity name used across all the codegeneration logic instead of manually modification in the code

```JSON
{
  "namespace": "Groceries",
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
    "Discount": {
      "required": ["type"],
      "selectable": []
    }
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
- Look at example app `Makefile` for more examples to use the dh-graphql-codegen-ios

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
