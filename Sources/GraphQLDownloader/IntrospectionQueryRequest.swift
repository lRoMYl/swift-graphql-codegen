//
//  File.swift
//  
//
//  Created by Romy Cheah on 20/9/21.
//

import Foundation

public struct IntroSpectionRequest: Encodable {
  let operationName = "IntrospectionQuery"
  let query = """
  query IntrospectionQuery($includeDeprecated: Boolean = true) {
      __schema {
          queryType { name }
          mutationType { name }
          subscriptionType { name }
          types {
          ...FullType
          }
      }
  }

  fragment FullType on __Type {
      kind
      name
      description
      fields(includeDeprecated: $includeDeprecated) {
          ...Field
      }
      inputFields {
          ...InputValue
      }
      interfaces {
          ...TypeRef
      }
      enumValues(includeDeprecated: $includeDeprecated) {
          ...EnumValue
      }
      possibleTypes {
          ...TypeRef
      }
  }

  fragment Field on __Field {
      name
      description
      args {
          ...InputValue
      }
      type {
          ...TypeRef
      }
      isDeprecated
      deprecationReason
  }

  fragment InputValue on __InputValue {
      name
      description
      type {
          ...TypeRef
      }
      defaultValue
  }

  fragment EnumValue on __EnumValue {
      name
      description
      isDeprecated
      deprecationReason
  }



  fragment TypeRef on __Type {
      kind
      name
      ofType {
          kind
          name
          ofType {
              kind
              name
              ofType {
                  kind
                  name
                  ofType {
                      kind
                      name
                      ofType {
                          kind
                          name
                          ofType {
                              kind
                              name
                              ofType {
                                  kind
                                  name
                              }
                          }
                      }
                  }
              }
          }
      }
  }
  """

  public init() {}
}
