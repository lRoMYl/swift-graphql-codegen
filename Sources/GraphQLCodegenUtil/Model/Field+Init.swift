//
//  File.swift
//  
//
//  Created by Romy Cheah on 23/10/21.
//

import GraphQLAST

public extension Field {
  init(with objectType: ObjectType) {
    self = Field(
      name: objectType.name,
      description: objectType.description,
      args: [],
      type: .named(.object(objectType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )
  }

  init(with unionType: UnionType) {
    self = Field(
      name: unionType.name,
      description: unionType.description,
      args: [],
      type: .named(.union(unionType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )
  }

  init(with interfaceType: InterfaceType) {
    self = Field(
      name: interfaceType.name,
      description: interfaceType.description,
      args: [],
      type: .named(.interface(interfaceType.name)),
      isDeprecated: false,
      deprecationReason: nil
    )
  }
}
