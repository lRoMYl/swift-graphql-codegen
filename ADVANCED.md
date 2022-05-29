# Advanced
For the convenience of developers, we have a simplified sub-command `dh-swift` which internally use the subcommand listed belows as it could be quite verbose to use.

In this section, we will be exploring in details how to use all the sub-command as it could be useful for use case that are not handled in `dh-swift` or just to give a better overview of what `dh-swift` is doing under the hood.

You can also look at the example folders for the simple (`dh-swift`) and advanced (`codegen`) examples in real projects.

# codegen
`swift-graphql-codegen codegen` subcommand is used specifically to generate files given the arguments

| Name | Type | Description | Example Value |
| - | - | - | - |
| schema | Argument | The URL of the schema, this is used in conjunction with `schema-source` to define how to fetch the file | `/User/Download/schema.json` or `https://www.somedomain.com` |
| platform | Option | Platform of the code to be generated, currently we only have `swift` | `swift`, default `swift` | 
| target | Option | There are multiple files that could be generated using the codegenerator. Target is the representation of the file to be generated. More detailed information about target will be explained in `Target` section | `dh-apiclient`, `mapper`, `specification`, `introspection`, `entity` |
| schema-source | Option | This is to indicate if the source of the `schema` argument provided should be fetched remotely or locally | `local` or `remote`, default `local` |
| output | Option | Path and name of the output file | `GraphQLSpec.swift` or `Users/Download/GraphQLSpec.swift` |
| api-client-prefix | Option | This value is only provided if target is `dh-apiclient`. The prefix is used for the file and class and can be customized to adhere to naming convention or to prevent naming collision when multiple ApiClient exist in a single project | default: `GraphQL` |
| config-path | Option | The path and name of the config file | `GraphQL/config.json`. `config.json` |
| verbose | Option | This is a flag to enable extra information to be outputted, primarily for debugging purpose | N/A |

## Target
| Name | Description |
| - | - |
| dh-apiclient | Delivery Hero flavor APIClient which includes all query as functions. If there are multiple API/schema used in the project, used `api-client-prefix` in the CLI option to provide different prefix name to prevent naming collision/overriding | 
| mapper | Mapper is still a work in progress, don't use this |
| specification | This is to generate the network models based on the schema provided |
| introspection | This is to generate the GraphQL Abstract Syntax Tree (json) file locally from the GraphQL schema provided. This is useful to be generated locally so we can perform code generation without any remote call | 
| entity | Entity target create the base class required for the generated GraphQL models such as GraphQLRequest, GraphQLSelection |

# introspection
This is the subcommand to generate the GraphQL Abstract Syntax Tree (json) file locally from the GraphQL schema provided. This is useful to be generated locally so we can perform code generation without any remote call

| Name | Type | Description | Example Value |
| - | - | - | - |
| schema | Argument | The URL of the schema, this is used in conjunction with `schema-source` to define how to fetch the file | `/User/Download/schema.json` or `https://www.somedomain.com` |
| output-path | Option | Path of the output file | `Users/Download` |
| output | Option | Name of the output file | `GraphQLSpec.swift` |

# dh-swift
This is subcommand created for the convenience of the developers which internally call the `codegen` subcommand multiple times with different target and overriding `default` value based on delivery hero naming convention.

| Name | Type | Description | Example Value |
| - | - | - | - |
| schema | Argument | The URL of the schema, this is used in conjunction with `schema-source` to define how to fetch the file | `/User/Download/schema.json` or `https://www.somedomain.com` |
| schema-source | Option | This is to indicate if the source of the `schema` argument provided should be fetched remotely or locally | `local` or `remote`, default `local` |
| output-path | Option | Path for all the output files | `Users/Download/` |
| introspection-output | Option | Path and name of the introspection file | `schema.json` or `Users/Download/schema.json` |
| entity-output | Option | Path and name of the entity file | `GraphQLEntities.swift` or `Users/Download/GraphQLEntities.swift`, default: `Core/GraphQLEntities.generated.swift` |
| specification-output | Option | Path and name of the specitication file | `NetworkModels.swift` or `Users/Download/NetworkModels.swift`, default: `NetworkModels.generated.swift` |
| api-client-output | Option | Path and name of the ApiClient file | `NetworkModels.swift` or `Users/Download/NetworkModels.swift`, default: `ApiClient.generated.swift` |
| api-client-prefix | Option | This value is only provided if target is `dh-apiclient`. The prefix is used for the file and class and can be customized to adhere to naming convention or to prevent naming collision when multiple ApiClient exist in a single project | default: `GraphQL` |
| config-path | Option | The path and name of the config file | `GraphQL/config.json`. `config.json` |
| targets | Option | Array of targets to be generated | default: `entity`, `specification`, `dhApiClient` |
| mapper-output | WIP, do not use this | N/A |

Please be noted, all customization to target output will use `output-path` option as prefix path, if no value is provided to `output-path` it will use the relative path where the CLI is executed.

Example:
```
swift-graphql-codegen dh-swift schema schema.json --output-path`: `Users/Download/` --specification-output test.swift
```
Would generates the following files:
- `Users/Download/Core/GraphQLEntities.generated.swift`, default value for `entity-output`
- `Users/Download/test.swift`, overwritten value for `specification-output`
- `Users/Download/GraphQLApiClient.generated.swift`, default value for `api-client-output`

Notice that the specified `output-path` is used as a shared directory for all the subsequent output files.

For `GraphQLEntities.swift`, the default value includes a `Core/` as a path so the file is generated in `Users/Download/Core/`.

```
swift-graphql-codegen dh-swift schema schema.json --output-path`: `Users/Download/` --entity-output test.swift
```
Would generates the following files:
- `Users/Download/test.swift`, overwritten value for `entity-output`
- `Users/Download/NetworkModels.generated.swift`, default value for `specification-output`
- `Users/Download/GraphQLApiClient.generated.swift`, default value for `api-client-output`

Notice that once we have overwritten `entity-output` value, the file is generated in `Users/Download` instead of `Users/Download/Core/`
