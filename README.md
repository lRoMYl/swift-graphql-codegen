# DHGraphQLCodegeSwift

## Installation
```
brew tap lromyl/tap

brew install dh-graphql-codegen-ios
# if there are conflict, use the command below instead 
brew install lromyl/tap/dh-graphql-codegen-ios 
```

## How to use

Generate graphql code from local schema.json
- `--schema-source-type` default value is `local`, thus the file is read from local file path
- By default, it will generate GraphQLSpec.swift file in the current directory
```
dh-graphql-codegen-ios "schema.json"

// Specific path instead of relative path
dh-graphql-codegen-ios "/User/Download/schema.json" --output "path/filename.swift"
```

Generate graphql code from remote domain
- Provide a remote url to fetch the schema
- Use `remote` for `--schema-source-type` to indicate the schema needs to be fetched remotely
```
dh-graphql-codegen-ios "https://www.somedomain.com" --schema-source-type "remote"
```

Sample Query Code
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

Resource Class
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

Example schema.json
Ping me `@romy cheah` in slack for now and I'll share the schema file to you while the logic to generate the schema remotely is being built upon
