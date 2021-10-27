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
      id: try campaignAttribute.id(),
      name: try campaignAttribute.name(),
      /*
       If you have a shared mapping logic across the app and some fields might or might not be selected,
       you can opt to not handle the error throw by using try? if you deemed this value is not so critical
       for the app.

       The error mechanism is in place but it's up to the developer to decide how to manage the error handling.

       However, I would suggest to at least use a do-try block and print the error before assigning the default value.
       */
      description: (try? campaignAttribute.description()) ?? "",
      customVariableNotInResponse: "",
      source: CampaignAttribute.Source(with: try campaignAttribute.source()),
      responseSource: try campaignAttribute.source()
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
