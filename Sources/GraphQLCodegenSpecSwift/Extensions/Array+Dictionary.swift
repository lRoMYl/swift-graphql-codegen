//
//  File.swift
//
//
//  Created by Romy Cheah on 22/9/21.
//

import Foundation

public extension Array {
  func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
    var dict = [Key: Element]()

    for element in self {
      dict[selectKey(element)] = element
    }

    return dict
  }
}
