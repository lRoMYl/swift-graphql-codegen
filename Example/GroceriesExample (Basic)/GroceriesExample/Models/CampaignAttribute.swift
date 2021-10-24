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

/// Using custom decoder
extension CampaignAttribute {
  init(from decoder: CampaignAttributeSelectionDecoder) throws {
    self.id = try decoder.id()
    self.name = try decoder.name()
    self.customVariableNotInResponse = ""
    self.source = try decoder.source(mapper: { CampaignAttribute.Source(with: $0) } )
    self.responseSource = try decoder.source(mapper: { $0 } )
  }
}

/// Using manual mapping
extension CampaignAttribute {
  init(with attribute: CampaignAttributeResponseModel) {
    self.id = attribute.id ?? ""
    self.name = attribute.name ?? ""
    self.customVariableNotInResponse = ""
    self.source = attribute.source.map { CampaignAttribute.Source(with: $0) } ?? .unknown("")
    self.responseSource = attribute.source ?? ._unknown("")
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
