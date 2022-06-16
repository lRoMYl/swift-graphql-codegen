SCHEMA_URL = "https://sg.fd-api.com/groceries-graphql-gateway/query"
SCHEMA = "GraphQL/schema.json"
CONFIG = "GraphQL/config.json"
OUTPUT_PATH = "GroceriesExample/API/"
INTROSPECTION_PATH = "GraphQL/"
API_CLIENT_PREFIX = "Groceries"

install:
	sh scripts/carthage-update.sh bootstrap --platform ios --cache-builds --no-use-binaries --new-resolver --use-ssh
	brew tap lromyl/tap
	brew install swift-graphql-codegen

graphql-introspection:
	swift-graphql-codegen introspection $(SCHEMA_URL) --output-path $(INTROSPECTION_PATH)

graphql-codegen:
	swift-graphql-codegen dh-swift $(SCHEMA) --output-path $(OUTPUT_PATH) --config-path $(CONFIG) --api-client-prefix $(API_CLIENT_PREFIX) --is-throwable-getter-enabled
