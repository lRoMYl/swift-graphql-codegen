# DHGraphQLCodegen

Code implementation is created based on [swift-graphl AST](https://github.com/maticzav/swift-graphql)

## Roadmap

Supports GraphQL Native Feature
- [x] Object
- [x] InputObject
- [x] Enum / Enumeration
- [x] Interface
- [ ] Union
- [x] Query
- [x] Mutation
- [x] Subscription; Partial support, request/response/respository/resource are generated but DH ApiClient doesn't have native support for WebSocket yet
- [x] Introspection

Support DH Custom Feature
- [x] SPM package
- [x] Brew package
- [x] Local schema
- [x] Remote schema, download using introspection query
- [x] Remote schema authorization headers
- [x] Remote schema cache
- [x] Scalar Map extension
- [x] Custom field whitelisting
- [x] Support for custom unknown enum, this is necessary to ensure the generated code can work with future unknown enum value
- [x] Support for optional namespace to avoid naming collision
- [x] APIClient
- [ ] Split base class generation with `action` option, this would allow integration with different GraphQL microservice providers without duplicated base class

## Installation
```
brew tap lromyl/tap

brew install dh-graphql-codegen-ios
# if there are conflict, use the command below instead 
brew install lromyl/tap/dh-graphql-codegen-ios 
```

## How to use

### CLI Codegen Syntax
**Generate graphql code from local schema.json**
- `--schema-source` default value is `local`, thus the file is read from local file path
- By default, it will generate GraphQLSpec.swift file in the current directory
```
dh-graphql-codegen-ios "schema.json"

// Specific path instead of relative path
dh-graphql-codegen-ios "/User/Download/schema.json" --output "path/filename.swift"
```

**Generate graphql code from remote domain**
- Provide a remote url to fetch the schema
- Use `remote` for `--schema-source` to indicate the schema needs to be fetched remotely
```
dh-graphql-codegen-ios "https://sg-st.fd-api.com/groceries-product-service/query" --schema-source "remote"
```

**Providing custom config**
- Use `--config-path` to provide the location of config file
- Look at Sample Config file for more info 
```
dh-graphql-codegen-ios "schema.json" --config-path "config.json"
```

### Sample Query Code
```
// Product Query
let productRequest = try! GraphQLRequest(
  parameters: CampaignAttributeRequestParameter(
    vendorId: "test vendor id",
    globalEntityId: "global entity id",
    locale: "locale",
    languageId: nil,
    languageCode: "language code optional",
    apikY: "api key",
    discoClientId: "client id",
    selections: .init(
      campaignAttributeSelections: [.id, .discount, .benefits],
      discountSelections: [.type, .value]
    )
  )
)

graphQLClient.get(productRequest)
  .subscribe(...)
```

### Sample Config File
- A JSON file that can be passed into the CLI using `--config-path` 
- apiHeaders define the custom headers to be used for downloading the schema, this is useful to provide authorization headers for authentication
- scalarMap defines the custom mapping for Scalar type to native Swift type, code generation will fail if no mapping is found for custom scalar type
- selectionMap defines custom field whitelisting for selections, overrides the schema specification to only query the fields required by client use case

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
    "Discount": {
      "required": ["type"],
      "selectable": []
    }
  }
}
```
Example schema
```
dh-graphql-codegen-ios "https://sg-st.fd-api.com/groceries-product-service/query" --schema-source "remote" --output "GroceriesGraphQLSpec.swift"`
```

### Sample Resource Class
- Below is the gist of how a GraphQLResource implementing PD-Kami would works, the final structure and code generation itself will be done at later stage.
```
// To be added, just pass in the Encodable GraphQLRequest to APIClient with POST method
enum GraphQLResource: ResourceParameters
case request(GraphQLRequest)
case update(GraphQLRequest)

func bodyFormat() -> HttpBodyFormat {
.URLFormData
}

func httpMethod() -> RequestHttpMethod {
.post
}

func bodyParameters() -> Any? {
switch self {
case let .graphQL(parameters):
return parameters.bodyParameters()
}
}
}

extension GraphQLRequest: BodyParameters {
func bodyParameters() -> [String: Any] {
asDictionary ?? [:]
}
}
```
