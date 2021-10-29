//
//  File.swift
//  
//
//  Created by Romy Cheah on 28/10/21.
//

import GraphQLAST
import GraphQLCodegenNameSwift

extension EntityNameProviding {
  func responseInternalVariableName(with field: Field) throws -> String {
    "internal\(field.name.pascalCase)"
  }

  /**
   Variable named used at the top level of GraphQL Query
   ~~~
   query(
    $productId: String! // productId is the operationVariableName
   ) {
    product(id: $productId) { // productId here is identical to the top declaration and should use this function as well
     name
    }
   }
   ~~~
   - Parameter inputValue: This is the argument required in the field
   - Parameter field: The parent field for InputValue
   - Parameter rootField: The top most field used for query
   */
  func operationVariableName(
    with inputValue: InputValue,
    field: Field,
    rootField: Field
  ) throws -> String {
    let isRootArgument = field.name == rootField.name && field.type == rootField.type
    let variableName = isRootArgument
      ? (field.name.camelCase + inputValue.name.pascalCase).camelCase
      // rootField name is not transformed using camelCase or pascal case because
      // the name is type sensitive and necessary to resolve naming conflict
      : rootField.name + field.name.pascalCase + inputValue.name.pascalCase

    return variableName
  }

  /**
   Variable key name is the key used as the name for a field arguments, the key must match with the name defined in Schema and cannot be overriden
   ~~~
   query($productId: String!) {
    product(id: $productId) { // id is the variableKeyName and should match exactly with the name in Schema
      name
    }
   }
   ~~~
   - Parameter inputValue: This is the argument required in the field
   - Parameter field: The parent field for InputValue
   - Parameter rootField: The top most field used for query
   */
  func operationVariableKeyName(
    with inputValue: InputValue,
    field: Field,
    rootField: Field
  ) throws -> String {
    let isRootArgument = field.name == rootField.name && field.type == rootField.type
    let codingKeyName = isRootArgument
      ? inputValue.name.camelCase
      : rootField.name + field.name.pascalCase + inputValue.name.pascalCase

    return codingKeyName
  }
}
