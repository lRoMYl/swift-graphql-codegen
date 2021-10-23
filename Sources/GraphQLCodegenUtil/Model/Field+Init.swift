//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/10/21.
//

import GraphQLAST

extension Field {
  public init(with objectType: ObjectType) {
    self = Field(
      name: objectType.name,
      description: objectType.description,
      args: [],
      type: .named(.object(objectType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )
  }
}
