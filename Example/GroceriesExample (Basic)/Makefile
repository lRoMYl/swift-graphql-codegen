SCHEMA_URL = "https://sg-st.fd-api.com/groceries-product-service/query"
SCHEMA = "GraphQL/schema.json"
CONFIG = "GraphQL/config.json"
OUTPUT_PATH = "GroceriesExample/API/"
INTROSPECTION_PATH = "GraphQL/"
API_CLIENT_PREFIX = "Groceries"

install:
	sh scripts/carthage-update.sh bootstrap --platform ios --cache-builds --no-use-binaries --new-resolver --use-ssh
	brew tap lromyl/tap
	brew install swift-graphql-codegen

codegen-introspection:
	swift-graphql-codegen introspection $(SCHEMA_URL) --output-path $(INTROSPECTION_PATH)

codegen-groceries:
	swift-graphql-codegen dh-swift $(SCHEMA) --output-path $(OUTPUT_PATH) --config-path $(CONFIG) --api-client-prefix $(API_CLIENT_PREFIX)
