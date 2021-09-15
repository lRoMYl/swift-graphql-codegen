//
//  Codable.swift
//  Grapqhl Codegen
//
//  Created by Romy Cheah on 9/9/21.
//

import Foundation

protocol Structure {
  var fields: [Field] { get }
  var possibleTypes: [ObjectTypeRef] { get }
}

extension Structure {
  /// Returns a list of fields shared between all types in the interface.
  func allFields(objects: [ObjectType]) -> [Field] {
    var shared: [Field] = fields

    for object in objects {
      // Skip object if it's not inside possible types.
      guard possibleTypes.contains(where: { $0.name == object.name }) else { continue }
      // Append fields otherwise.
      for field in object.fields {
        // Make suer fields are unique.
        shared.append(field)
      }
    }

    return shared.unique(by: { $0.name }).sorted(by: {$0.name < $1.name})
  }
}
