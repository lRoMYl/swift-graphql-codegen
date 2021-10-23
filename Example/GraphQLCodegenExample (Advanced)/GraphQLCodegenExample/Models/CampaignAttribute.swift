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

extension CampaignAttribute {
  init(
    from decoder: CampaignAttributeSelectionDecoder
  ) throws {
    self.id = try decoder.id()
    self.name = try decoder.name()

    // Domain model might have fields that are not in the response, decide the default value here
    self.customVariableNotInResponse = ""

    // Application/Domain enum mapping
    self.source = try decoder.source(mapper: { CampaignAttribute.Source(with: $0) } )

    // Sometimes, we use the response enum directly and treat it as a primitive without additional mapping
    self.responseSource = try decoder.source(mapper: { $0 } )
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
