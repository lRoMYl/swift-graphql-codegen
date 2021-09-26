install:
	brew tap lromyl/tap
	brew install dh-graphql-codegen-ios

codegen-groceries:
	# Generate GraphQL introspection file from remote url
	dh-graphql-codegen-ios "https://sg-st.fd-api.com/groceries-product-service/query" --action "introspection" --schema-source "remote" --output "GraphQL/groceries-schema.json" --config-path "GraphQL/groceries-config.json"

	# Generate common entity class for all GraphQL microservices. 
	# If you have multiple endpoint for GraphQL, do not regenerate this.
	dh-graphql-codegen-ios "GraphQL/groceries-schema.json" --action "entity" --output "GraphQLCodegenExample/GraphQLEntity.swift" --config-path "GraphQL/groceries-config.json"

	# Generate groceries GraphQL specification file from local schema
	dh-graphql-codegen-ios "GraphQL/groceries-schema.json" --action "specification" --output "GraphQLCodegenExample/Groceries/GroceriesGraphQLSpec.swift" --config-path "GraphQL/groceries-config.json"
	# Generate groceries repository file from local schema
	dh-graphql-codegen-ios "GraphQL/groceries-schema.json" --action "dh-repository" --output "GraphQLCodegenExample/Groceries/GroceriesGraphQLRepository.swift" --config-path "GraphQL/groceries-config.json"

codegen-bigcommerce:
	# For the purpose of this example, we will not need to fetch bigcommerce introspection from remote url
	# For the purpose of this example, we will be providing a namespace to avoid name collision

	# Generate groceries GraphQL specification file from local schema
	dh-graphql-codegen-ios "GraphQL/bigcommerce-schema.json" --action "specification" --output "GraphQLCodegenExample/BigCommerce/BigCommerceGraphQLSpec.swift" --config-path "GraphQL/bigcommerce-config.json"
	# Generate groceries repository file from local schema
	dh-graphql-codegen-ios "GraphQL/bigcommerce-schema.json" --action "dh-repository" --output "GraphQLCodegenExample/BigCommerce/BigCommerceGraphQLRepository.swift" --config-path "GraphQL/bigcommerce-config.json"