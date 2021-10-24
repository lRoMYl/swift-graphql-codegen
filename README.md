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
- [x] Root level query
- [ ] Directive, no plan to support it atm.

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
- [x] Mapper class, the mapping logic will also be used to compute the selections automatically

TODO
- [ ] Nested field selection with arguments is not handled yet
- [ ] ApiClientPrefix needs to be removed from EntityNameMap
- [ ] Ramp up test cases
- [ ] Ramp up documentation

## Installation
```
brew tap lromyl/tap

brew install dh-graphql-codegen
# if there are conflict, use the command below instead 
brew install lromyl/tap/dh-graphql-codegen
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
make codegen-appolo
```

In `Basic Example`, you can look at the `Makefile` to see how to use `dh-graphql-codegen dh-swift` to generate all the files using only 3 option to achieve similar result to `Advanced Example`
```
make codegen-groceries
```

---

### Sample Query Code

Optional mapper class can be used to defined how to map the response model into application/domain model.

The mapper would then generate the selections based on which field will be used for the mapping to query only the fields used during the mapping logic.

e.g. 
- `VenderResponseModel` have 10 fields; `id`, `name`, `source` and etc.
- In the example below, we have a `Vendor` application/model which is used within the app
- Define which fields in `VendorResponseModel` are required to populate the `Vendor` domain model, in this case example only 2 fields are are used.
- The mapper class will compute all the selections used for this mapping and create a selections based on that, in this case 2 selections
- The api call will only request for only `2` fields although the response model have `10` fields.
- Using the mapper, we can guarantee the code to be build-time safe. (Unless if there is a bug in the generated code)
- However, using mapper is optional as this is a separate module but mapping and selections generation will need to be done manually and there is a risk of selections not being the same as the field expected from the response.

```
let request = VendorQueryRequest(
  name: "vendor name", // Argument1 is code-generated
  country: .sg,  // Argument2 is code-generated
)

let mapper = VendorSelectionMapper { decoder in
  try Vendor(
    id: try decoder.id(),
    name: try decoder.name()
  )
}

let vendor = apiClient.vendor(with: request, selections: mapper.selections)
  .map { response in
    return try mapper.map(response: responseModel)
  }
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
- Look at example app `Makefile` for more examples to use the dh-graphql-codegen

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
