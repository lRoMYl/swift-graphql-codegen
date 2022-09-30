# Getting Started
This document is intended to be a step-by-step tutorial to integrate the code generation tool for the first time.

## Pre-requisite
- MacOS 10 and above
- XCode 12.4 and above

## Setup

## Installation
```
install:
  brew tap lromyl/tap
  brew install swift-graphql-codegen
```

# Simple Tutorial (1 GraphQL Schema)
For this tutorial, the script is written using `Makefile` in [TEMPLATES.md](TEMPLATES.md)

## Step 1: Defining the variable for the script
```
SCHEMA_URL = "https://sg-st.fd-api.com/groceries-product-service/query"
SCHEMA = "GraphQL/schema.json"
CONFIG = "GraphQL/config.json"

INTROSPECTION_OUTPUT_PATH = "GraphQL/"
CODEGEN_OUTPUT_PATH = "Verticals/API/"

API_CLIENT_PREFIX = "Groceries"
```

- `SCHEMA_URL`: The URL where the GraphQL schema is hosted at, for the purpose of this tutorial we're using the URL for groceries schema so do remember changing this.
- `INTROSPECTION_OUTPUT_PATH`: The directory to generate the introspection files
- `CODEGEN_OUTPUT_PATH`: The directories to generate the generated code files
- `SCHEMA`: The file path and name
- `CONFIG`: The file path and name
- `API_CLIENT_PREFIX`: This is the prefix used for the generated ApiClient file which is only applicable to iOS atm. This variable is meant to be unique per schema to prevent naming collision, so you would need to create multiple `API_CLIENT_PREFIX` if your project have multiple schema.

## Step 2: Fetching the latest GraphQL schema using introspection and cache it locally
```
introspection:
	swift-graphql-codegen introspection $(SCHEMA_URL) --output-path $(INTROSPECTION_OUTPUT_PATH)
```

- The code generator has a built in sub-command to perform introspection conveniently, `swift-graphql-codegen introspection`.
- This command would fetch the GraphQL schema from the provided URL and then generating the GraphQL Abstract Syntax Tree as `schema.json` in the provided output path.

## Step 3: Generating code using local schema and config

Read [CONFIG.md](CONFIG.md) for more info on how to create the config file

```
codegen:
	swift-graphql-codegen bootstrap $(SCHEMA) --output-path $(CODEGEN_OUTPUT_PATH) --config-path $(CONFIG) --api-client-prefix $(API_CLIENT_PREFIX)
```

- Using the sub-command `bootstrap`, it conveniently generate multiple files with default naming convention for classes and file name with a single command.
- You might be encoutering error when generating file if you do not have a folder `Core` in the output path, if that's the case just create the folder manually and try again.

## Step 4: Execute the script
Once you have created the makefile, you can simply execute it with the following commands as example

```
make install
```
- To install the dependencies, you only need to execute this once on new machine
- If there are newer version of the code generation tool, this command will attempt to install the latest version

```
make introspection
```
- To fetch the latest GraphQL schema, you will need to execute this whenever you need the latest changes from backend

```
make codegen
```
- To generate the code according to the downloaded schema, execute this after you fetch the latest GraphQL schema.

# Advance Tutorial (More than 1 GraphQL schema)
This advance tutorial is very similar to the simple tutorial above but demonstrated how to resolve naming collision issue which will happen when trying to generate code for multiple GraphQL schema.

## Step 1: Defining the variable for the script
```shell
# Groceries specific variables
GROCERIES_SCHEMA_URL = "https://sg-st.fd-api.com/groceries-product-service/query"
GROCERIES_SCHEMA = "GraphQL/groceries-schema.json"
GROCERIES_CONFIG = "GraphQL/groceries-config.json"
GROCERIES_CODEGEN_OUTPUT_PREFIX = "GraphQLCodegenExample/Groceries/Groceries"
GROCERIES_API_CLIENT_PREFIX = "Groceries"

# StarWars specific variables
STARWARS_SCHEMA_URL = "https://swift-swapi.herokuapp.com/"
STARWARS_SCHEMA = "GraphQL/starwars-schema.json"
STARWARS_CONFIG = "GraphQL/starwars-config.json"
STARWARS_CODEGEN_OUTPUT_PATH = "GraphQLCodegenExample/StarWars/StarWars"
STARWARS_API_CLIENT_PREFIX = "StarWars"

# Common variables
INTROSPECTION_OUTPUT_PATH = "GraphQL/"
```

It's pretty self-explanatory from the example variables above, the structure of the variables are generally the same but duplicated with a `GROCERIES_` or `STARWARS_` prefix that points to their own respective values.

## Step 3: Fetching the latest GraphQL schema using introspection and cache it locally
```
introspection:
	swift-graphql-codegen introspection $(GROCERIES_SCHEMA_URL) --output-path $(INTROSPECTION_OUTPUT_PATH) --output $(GROCERIES_SCHEMA)
  swift-graphql-codegen introspection $(STARWARS_SCHEMA_URL) --output $(STARWARS_SCHEMA)
```

- 2 key differences from the simple tutorials;
    - Instead of executing only 1 sub-commands, we're now repeating it twice or as many times as needed accordingly to the number of endpoint we need to fetch the schema from.
    - Additional `--output` parameter to override the output file name, we would have `groceries-schema.json` and `starwars-schema.json` instead of a single file named `schema.json`.
- In the example above, we're grouping both introspection execution in a single Make command but it's really up to you to decide if executing it in a group or sepearetely makes more sense for your project.

## Step 4: Generating code using local schema and config

Read [CONFIG.md](CONFIG.md) for more info on how to create the config file

```
codegen:
	swift-graphql-codegen bootstrap $(GROCERIES_SCHEMA) --output-path $(GROCERIES_CODEGEN_OUTPUT_PATH) --config-path $(GROCERIES_CONFIG) --api-client-prefix $(GROCERIES_API_CLIENT_PREFIX)
  swift-graphql-codegen bootstrap $(STARWARS_SCHEMA) --output-path $(STARWARS_CODEGEN_OUTPUT_PATH) --config-path $(STARWARS_CONFIG) --api-client-prefix $(STARWARS_API_CLIENT_PREFIX)
```

- Similar to introspection, we're executing the same command twice with respective project variables

## Step 5: Execute the script
```
make install
make introspection
make codegen
```
- No difference from the simple tutorial on how to execute the script 

# Troubleshooting
```
Failed to create file at /API/Core/GraphQLEntities.generated.swift
```
Make sure the directory path exist, if not create it manually and retry again
