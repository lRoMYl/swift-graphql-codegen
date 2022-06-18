# Config
This document is intended to the document on making sense with the configuration file and how to use it.

Config file is represented as a `json` file and can be named as anything, for the purpose of this document we would be using `config.json`.

The `config.json` have 4 fields in total and can all be optionally provided to provide customization to the generated code. 

Here is the example of a `config.json`

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

We will now go over it in details what each fields represent and how it would impact the generated code with examples.

## API Headers (apiHeaders)

API headers (apiHeaders) is just a convenient field to inject additionals headers when fetching GraphQL schema from the backend service.

Unlike other fields in the configuration, this field doesn't directly affected the output of the code but is used to provide additional information when connection to the backend service.

Example of scenarios where additional headers are required:
- `authorization` field is commonly used to associate the connection with a user/entity to ensure proper flow control, rate limiting and etc.
- Common event tracking headers such app version, platform and etc

## Scalar Map (scalarMap)

Scalar map (scalarMap) defines the mapping for Scalar type to an assigned concrete type.

Before we explore how to use this mapping, we need to explore the concept of `Scalar Type` in GraphQL to understand why we needed this mapping.

Taken from GraphQL documentation for [Scalar Types](https://graphql.org/learn/schema/#scalar-types)
> A GraphQL object type has a name and fields, but at some point those fields have to resolve to some concrete data. That's where the scalar types come in: they represent the leaves of the query.

Basically a `scalar type` requires both backend and frontend to agree on the serialization/deserialization logic of the primitive/concrete data type.

Examples of built-in scalar type supported by GraphQL out of the box are;
- Int: A signed 32‐bit integer.
- Float: A signed double-precision floating-point value.
- String: A UTF‐8 character sequence.
- Boolean: true or false.
- ID: The ID scalar type represents a unique identifier, often used to refetch an object or as the key for a cache. The ID type is serialized in the same way as a String; however, defining it as an ID signifies that it is not intended to be human‐readable.

The code generation tool will only handle the default scalar mapping, anything else would need to be defined by the respective squad when generating their code.

```Swift
public extension ScalarMap {
  static let `default`: ScalarMap = {
    [
      // In GraphQL spec, ID refer to Identifier that are internally using a String type
      "ID": "String", 
      "String": "String",
      "Int": "Int",
      "Boolean": "Bool",
      // In GraphQL spec, Double doesn't exist. To cater to our codebase common use cases,
      // I've mapped Float to Double instead of Float. 
      // This can however be overwritten using scalarMap field in your config file.
      "Float": "Double" 
    ]
  }()
}
```

Examples of common scalar type that are not supported out of the box;
- Date: Backend would need to define which ISO standard to handle the date such as `ISO8601` or `Epoch`
- URL

Can be defined as such
```JSON
{
  "scalarMap": [
    // The values on the left side is the GraphQL Scalar type name, the value on the right is the Swift type name
    "DateTime": "Date",
    "URL": "URL",
    "SomeFancyScalarType": "YourFancySwiftType"
  ]
}
```

If a `scalar type` doesn't have any equivalent mapping defined in the configuration file, an error will be printed with message indicating the exact `scalar type` requires a mapping to be defined.

Please note that the code generation tool doesn't check if the provided `Swift type` exist in your code base, it simply check if you've provided the necessary mapping for the `scalar type`. 

## Selection Map (selectionMap)

Selection Map (selectionMap) defines the mapping for fields within any `type` that should be auto code generated.

There are generally two main use cases for selection mapping, and I would share some example below to illustrate it.

**Exclude unused fields**

GraphQL Schema with an object type, `Vendor` that have 4 fields within it with a mix of optionality.

```GraphQL Schema
type Vendor {
  id: ID!
  name: String
  latitude: Float!
  longitude: Float!
}
```

Config with selection map for `Vendor` that only whitelisted 2 out of 4 fields.

`Vendor` is provided as the name of the object in which the fields selection would be overwritten and `id` and `name` was passed in as an array of String.

```JSON
"selectionMap": {
  "Vendor": ["id", "name"]
}
```

By default, if no selection mapping was provided for `Vendor`, the generated code would include all fields automatically but in this case, only 2 fields was provided

While it is possibile to just write the filter in the code to exclude these unused fields but there are times when client would want to significantly trim down the codes when it is clear that it wouldn't be used.

**Root Operation Filter**

GraphQL schema for `Query` operation

```GraphQL Schema
type Query {
  vendors: [Vendor]
  products: [Product]
  service: Service
}

type Service {
  innerObject: InnerObject
  otherInnerObject: OtherInnerObject
}

type Vendor {
  vendorInnerObject: VendorInnerObject
}
```

Config to selectively whitelist only `vendors` and `products` query.

```JSON
"selectionMap" {
    "query": ["vendors", "products"]
}
```

Selection mapping can be provided for `Root Operation` such as `query` and `mutation` which is in lower-cased.

When filtering the fields for root operation, the code generation would automatically compute the tree path to only generate code that would be used for the selected `fields`.

In the case illustrated above, `Service` object have two other object namely `InnerObject` and `OtherInnerObject` but all 3 of the types would not be generated as part of the code generation as no tree path lead to these data type. Meanwhile, `VendorInnerObject` which is part of `Vendor` would be generated because the tree path will eventually lead to `VendorInnerObject` when `Vendor` is whitelisted

GraphQL generally have a bunch of operation bundled with the API that the client doesn't require, this is especially true when the entire company only have a single GraphQL API exposed to be consumed which is quite typical.

To further provide example of the problem in real-life scenario, a company could easily have more than 100 queries and mutation operations but the client that wants to integrate is only interested in 2 operations. Without this selection mapping, it would create the entities unnecessarily for 100 queries which could involve a few hundreds objects and enums. With the selection mapping, the client could generate code for 2 entities instead of a few hundred of entities.

## Entity Name Map (entityNameMap)

Entity Name Map (entityNameMap) defines the mapping of custom name for each entity type.

The entity types here are referring to common entity that are officially supported by GraphQL such as `object`, `inputObject` and etc with some additional entity types that would useful for code generation such as `request` and `response`

Here is the full list of entity types that are supported for entity name map;
- request
- requestType
- requestParameter
- response
- selection
- selections
- query
- mutation
- subscription
- object
- inputObject
- interface
- union
- enum

To override it, just provide the key in the config for the specific entity name you wish to override and leaving the rest out of the config as there are already a default name for each entity type.

For example, if you wish to override the entity name for `object` and `selection`, just do so
```JSON
{
    "entityNameMap": {
        "object": "MyLongObjectObjectNamingConvention",
        "selection": "SelectionNamingConvention"
    }
}
```

This would result in the following output name 
```Swift
// MARK: - Object

// Default would be VendorGraphQLObject
struct VendorMyLongObjectEntityNamingConvention {
  ...
}

// MARK: - Selection

// Default would be VendorGraphQLSelection
struct VendorSelectionNamingConvention {
  ...
}
```

The global default naming convention is in `EntityNameMap.swift`, static `default` variable.

```Swift
static let `default`: EntityNameMap = {
  EntityNameMap(
    request: "GraphQLRequest",
    requestType: "GraphQLRequestType",
    requestParameter: "GraphQLRequestParameter",
    response: "GraphQLResponse",
    selection: "GraphQLSelection",
    selections: "GraphQLSelections",
    query: "GraphQLQuery",
    mutation: "GraphQLMutation",
    subscription: "GraphQLSubscription",
    object: "GraphQLObject",
    inputObject: "GraphQLInputObject",
    interface: "GraphQLInterfaceObject",
    union: "GraphQLUnionObject",
    enum: "GraphQLEnumObject"
  )
}()
```

As for bootstrap subcommand, there is a custom default naming convention in `GraphQLCodegenSpecSwiftConfig.swift`, static `defaultConfigResponse` variable.

```Swift
EntityNameMapResponse(
  request: "GraphQLRequest",
  requestParameter: "GraphQLRequestParameter",
  query: "QueryRequest",
  mutation: "MutationRequest",
  subscription: "SubscriptionRequest",
  object: "ResponseModel",
  inputObject: "RequestModel",
  interface: "InterfaceResponseModel",
  union: "UnionResponseModel",
  enum: "EnumResponseModel"
)
```
