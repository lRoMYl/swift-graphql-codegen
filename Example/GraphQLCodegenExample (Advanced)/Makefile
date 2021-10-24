GROCERIES_URL = "https://sg-st.fd-api.com/groceries-product-service/query"
GROCERIES_SCHEMA = "GraphQL/groceries-schema.json"
GROCERIES_CONFIG = "GraphQL/groceries-config.json"
GROCERIES_OUTPUT_PREFIX = "GraphQLCodegenExample/Groceries/Groceries"

STARWARS_URL = "https://swift-swapi.herokuapp.com/"
STARWARS_SCHEMA = "GraphQL/starwars-schema.json"
STARWARS_CONFIG = "GraphQL/starwars-config.json"
STARWARS_OUTPUT_PREFIX = "GraphQLCodegenExample/StarWars/StarWars"

APOLLO_URL = "https://apollo-fullstack-tutorial.herokuapp.com/"
APOLLO_SCHEMA = "GraphQL/apollo-schema.json"
APOLLO_CONFIG = "GraphQL/apollo-config.json"
APOLLO_OUTPUT_PREFIX = "GraphQLCodegenExample/Apollo/Apollo"

install:
	sh scripts/carthage-update.sh bootstrap --platform ios --cache-builds --no-use-binaries --new-resolver --use-ssh
	brew tap lromyl/tap
	brew install dh-graphql-codegen-ios

codegen-entity:
	# Generate common entity class for all GraphQL microservices. 
	# If you have multiple endpoint for GraphQL, do not regenerate this.
	dh-graphql-codegen codegen $(GROCERIES_SCHEMA) --target "entity" --output "GraphQLCodegenExample/Core/GraphQLEntities.generated.swift" --config-path $(GROCERIES_CONFIG)

codegen-groceries:
	# Generate GraphQL introspection file from remote url
	dh-graphql-codegen codegen $(GROCERIES_URL) --target "introspection" --schema-source "remote" --output $(GROCERIES_SCHEMA) --config-path $(GROCERIES_CONFIG)

	# Generate groceries GraphQL specification file from local schema
	dh-graphql-codegen codegen $(GROCERIES_SCHEMA) --target "specification" --output "$(GROCERIES_OUTPUT_PREFIX)NetworkModels.generated.swift" --config-path $(GROCERIES_CONFIG)

	# Generate groceries ApiClient file from local schema
	dh-graphql-codegen codegen $(GROCERIES_SCHEMA) --target "dh-apiclient" --output "$(GROCERIES_OUTPUT_PREFIX)ApiClient.generated.swift" --config-path $(GROCERIES_CONFIG)

	# Generate groceries Mappers file from local scehma
	dh-graphql-codegen codegen $(GROCERIES_SCHEMA) --target "mapper" --output "$(GROCERIES_OUTPUT_PREFIX)Mappers.generated.swift" --config-path $(GROCERIES_CONFIG)

codegen-starwars:
	# For the purpose of this example, we will be providing a namespace to avoid name collision
	dh-graphql-codegen codegen $(STARWARS_URL) --target "introspection" --schema-source "remote" --output $(STARWARS_SCHEMA) --config-path $(STARWARS_CONFIG)

	# Generate StarWars GraphQL specification file from local schema
	dh-graphql-codegen codegen $(STARWARS_SCHEMA) --target "specification" --output "$(STARWARS_OUTPUT_PREFIX)GraphQLSpec.generated.swift" --config-path $(STARWARS_CONFIG)

	# Generate StarWars ApiClient file from local schema
	dh-graphql-codegen codegen $(STARWARS_SCHEMA) --target "dh-apiclient" --output "$(STARWARS_OUTPUT_PREFIX)GraphQLApiClient.generated.swift" --config-path $(STARWARS_CONFIG)

	# Generate StarWars Mappers file from local scehma
	dh-graphql-codegen codegen $(STARWARS_SCHEMA) --target "mapper" --output "$(STARWARS_OUTPUT_PREFIX)Mappers.generated.swift" --config-path $(STARWARS_CONFIG)

codegen-apollo:
	# For the purpose of this example, we will be providing a namespace to avoid name collision
	dh-graphql-codegen codegen $(APOLLO_URL) --target "introspection" --schema-source "remote" --output $(APOLLO_SCHEMA) --config-path $(APOLLO_CONFIG)

	# Generate Apollo GraphQL specification file from local schema
	dh-graphql-codegen codegen $(APOLLO_SCHEMA) --target "specification" --output "$(APOLLO_OUTPUT_PREFIX)GraphQLSpec.generated.swift" --config-path $(APOLLO_CONFIG)

	# Generate Apollo ApiClient file from local schema
	dh-graphql-codegen codegen $(APOLLO_SCHEMA) --target "dh-apiclient" --output "$(APOLLO_OUTPUT_PREFIX)GraphQLApiClient.generated.swift" --config-path $(APOLLO_CONFIG)

	# Generate Apollo Mappers file from local scehma
	dh-graphql-codegen codegen $(APOLLO_SCHEMA) --target "mapper" --output "$(APOLLO_OUTPUT_PREFIX)Mappers.generated.swift" --config-path $(APOLLO_CONFIG)