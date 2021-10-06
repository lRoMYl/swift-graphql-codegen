//
//  File.swift
//
//
//  Created by Romy Cheah on 21/9/21.
//

import CryptoKit
import Foundation

extension Data {
  func md5String() throws -> String {
    let digest = Insecure.MD5.hash(data: self)

    return digest.map {
      String(format: "%02hhx", $0)
    }.joined()
  }
}
