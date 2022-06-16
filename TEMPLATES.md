# Templates

This document will be a collection of templates that would be useful to get you get started with using the code generator 

## Makefile

E.g.
```Makefile
## -------
## Variables
## Update the values here according to your project structure
## -------
SCHEMA_URL = "https://sg-st.fd-api.com/groceries-graphql-gateway/query"
SCHEMA = "GraphQL/schema.json"

CONFIG = "GraphQL/config.json"

INTROSPECTION_OUTPUT_PATH = "GraphQL/"
CODEGEN_OUTPUT_PATH = "Verticals/API/"

API_CLIENT_PREFIX = "Groceries"

## -------
## Install codegen
## -------
install:
	brew tap lromyl/tap
	brew install swift-graphql-codegen

## -------
## Update and re-install codegen
## -------
update:
  brew update
  brew install swift-graphql-codegen

## -------
## Fetch latest schema using introspection
## -------

graphql-introspection:
	swift-graphql-codegen introspection $(SCHEMA_URL) --output-path $(INTROSPECTION_OUTPUT_PATH)

## -------
## Generate code using local schema and config
## -------

graphql-codegen:
	swift-graphql-codegen dh-swift $(SCHEMA) --output-path $(CODEGEN_OUTPUT_PATH) --config-path $(CONFIG) --api-client-prefix $(API_CLIENT_PREFIX) --is-throwable-getter-enabled
```

## config.json
```JSON
// All fields in config are optionals, this file is meant to be overwrite the default 
// configuration values
{
  // This is a key-value-pair field to incude a custom headers when connecting to your 
  // server to fetch schema.
  // Useful to provide auth headers or anything specific to your service.
  "schemaApiHeaders": {
    "Authorization": "Bearer ...",
    "Platform": "iOS"
  },
  // A list of whitelisting for fields/queries to be generated
  "selectionMap": {
    // Root level whitelisting
    "Query": ["campaigns", "productDetails", "products", "shopDetails"],
    "Mutation": ["product"],
    // Object level whitelisting
    "Product": ["id", "name"]
  },
  // A mapping from GraphQL primitive data type to Swift Data Type
  "scalarMap": {
    "Date": "Date",
    "URL": "URL"
  },
  // Custom naviming for these entities
  "entityNameMap": {
    "request": null,
    "requestType": null,
    "requestParameter": null,
    "response": null,
    "responseError": null,
    "responseErrorExtension": null,
    "selection": null,
    "selections": null,
    "configuration": null,
    "query": null,
    "mutation": null,
    "subscription": null,
    "object": null,
    "inputObject": null,
    "interface": null,
    "union": null,
    "enum": null
  }
}
```