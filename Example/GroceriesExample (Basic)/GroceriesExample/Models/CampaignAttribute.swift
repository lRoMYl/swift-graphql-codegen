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
  let description: String
  let customVariableNotInResponse: String
  let source: Source
  let responseSource: CampaignSourceEnumResponseModel
}

extension CampaignAttribute {
  init(with campaignAttribute: CampaignAttributeResponseModel) throws {
    self = CampaignAttribute(
      id: try campaignAttribute.id,
      name: try campaignAttribute.name,
      description: (try? campaignAttribute.description) ?? "",
      customVariableNotInResponse: "",
      source: CampaignAttribute.Source(with: try campaignAttribute.source),
      responseSource: try campaignAttribute.source
    )
  }
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
