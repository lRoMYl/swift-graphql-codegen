//
//  Character.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 24/10/21.
//

import Foundation

enum CharacterUnion {
  case droid(Droid)
  case human(Human)

  init?(from decoder: CharacterQuerySelectionDecoder) throws {
    guard let characterUnion = try decoder.characterUnion(
      droidMapper: { decoder in
        try CharacterUnion.droid(Droid(from: decoder))
      },
      humanMapper: { decoder in
        try CharacterUnion.human(Human(from: decoder))
      }
    ) else {
      return nil
    }

    self = characterUnion
  }
}
