GROCERIES_URL = "https://sg-st.fd-api.com/groceries-product-service/query"
GROCERIES_SCHEMA = "GraphQL/groceries-schema.json"
GROCERIES_CONFIG = "GraphQL/groceries-config.json"
GROCERIES_OUTPUT_PREFIX = "GroceriesExample (Basic)/Groceries/Groceries"

install:
	carthage bootstrap --platform ios --cache-builds --no-use-binaries --new-resolver --use-ssh
	brew tap lromyl/tap
	brew install dh-graphql-codegen-ios

codegen-entity:
	# Generate common entity class for all GraphQL microservices. 
	# If you have multiple endpoint for GraphQL, do not regenerate this.
	dh-graphql-codegen-ios $(GROCERIES_SCHEMA) --target "entity" --output "GroceriesExample/Core/GraphQLEntities.swift" --config-path $(GROCERIES_CONFIG)

codegen-groceries:
	# Generate GraphQL introspection file from remote url
	dh-graphql-codegen-ios $(GROCERIES_URL) --target "introspection" --schema-source "remote" --output $(GROCERIES_SCHEMA) --config-path $(GROCERIES_CONFIG)

	# Generate groceries GraphQL specification file from local schema
	dh-graphql-codegen-ios $(GROCERIES_SCHEMA) --target "specification" --output "$(GROCERIES_OUTPUT_PREFIX)GraphQLNetworkModels.swift" --config-path $(GROCERIES_CONFIG)

	# Generate groceries ApiClient file from local schema
	dh-graphql-codegen-ios $(GROCERIES_SCHEMA) --target "dh-apiclient" --output "$(GROCERIES_OUTPUT_PREFIX)ApiClient.swift" --config-path $(GROCERIES_CONFIG)