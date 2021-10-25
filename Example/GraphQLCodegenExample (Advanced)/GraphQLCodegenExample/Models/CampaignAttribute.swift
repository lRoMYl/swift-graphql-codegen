//
//  File.swift
//  GraphQLCodegenExample
//
//  Created by Romy Cheah on 23/10/21.
//

import Foundation

struct CampaignAttribute {
  enum Source {
    case djini
    case unknown(String)
  }

  let id: String
  let name: String
  let customVariableNotInResponse: String
  let source: Source
  let responseSource: CampaignSourceEnumResponseModel
}

extension CampaignAttribute.Source {
  init(with rawValue: CampaignSourceEnumResponseModel) {
    switch rawValue {
    case .djini:
      self = .djini
    case let ._unknown(rawValue):
      self = .unknown(rawValue)
    }
  }
}
