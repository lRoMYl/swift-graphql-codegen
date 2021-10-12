// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - StarWarsEnumModel

/// One of the films in the Star Wars Trilogy
enum EpisodeStarWarsEnumModel: RawRepresentable, Codable {
  typealias RawValue = String

  /// Released in 1977.
  case newhope

  /// Released in 1980.
  case empire

  /// Released in 1983
  case jedi

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "NEWHOPE": self = .newhope
    case "EMPIRE": self = .empire
    case "JEDI": self = .jedi
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .newhope: return "NEWHOPE"
    case .empire: return "EMPIRE"
    case .jedi: return "JEDI"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: EpisodeStarWarsEnumModel, rhs: EpisodeStarWarsEnumModel) -> Bool {
    switch (lhs, rhs) {
    case (.newhope, .newhope): return true
    case (.empire, .empire): return true
    case (.jedi, .jedi): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

/// Language
enum LanguageStarWarsEnumModel: RawRepresentable, Codable {
  typealias RawValue = String

  case en

  case sl

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "EN": self = .en
    case "SL": self = .sl
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .en: return "EN"
    case .sl: return "SL"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: LanguageStarWarsEnumModel, rhs: LanguageStarWarsEnumModel) -> Bool {
    switch (lhs, rhs) {
    case (.en, .en): return true
    case (.sl, .sl): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

// MARK: - StarWarsModel

struct MutationStarWarsModel: Codable {
  let mutate: Bool

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case mutate
  }
}

struct DroidStarWarsModel: Codable {
  let appearsIn: [EpisodeStarWarsEnumModel]

  let id: String

  let name: String

  let primaryFunction: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case appearsIn
    case id
    case name
    case primaryFunction
  }
}

struct HumanStarWarsModel: Codable {
  /// The home planet of the human, or null if unknown.
  let homePlanet: String?

  let id: String

  let name: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case homePlanet
    case id
    case name
  }
}

struct QueryStarWarsModel: Codable {
  let character: CharacterUnionStarWarsUnionModel?

  let characters: [CharacterStarWarsInterfaceModel]

  let droid: DroidStarWarsModel?

  let droids: [DroidStarWarsModel]

  let greeting: String

  let human: HumanStarWarsModel?

  let humans: [HumanStarWarsModel]

  let luke: HumanStarWarsModel?

  let time: DateTimeInterval

  let whoami: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case character
    case characters
    case droid
    case droids
    case greeting
    case human
    case humans
    case luke
    case time
    case whoami
  }
}

struct SubscriptionStarWarsModel: Codable {
  /// Returns a random number every second. You should see it changing if your subscriptions work right.
  let number: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case number
  }
}

// MARK: - Input Objects

struct GreetingStarWarsInputModel: Codable {
  let language: LanguageStarWarsEnumModel?

  let name: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case language
    case name
  }
}

struct GreetingOptionsStarWarsInputModel: Codable {
  let prefix: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case prefix
  }
}

// MARK: - StarWarsInterfaceModel

enum CharacterStarWarsInterfaceModel: Codable {
  case droid(DroidStarWarsModel)
  case human(HumanStarWarsModel)

  enum Typename: String, Decodable {
    case droid = "Droid"
    case human = "Human"
  }

  private enum CodingKeys: String, CodingKey {
    case __typename
    case id
    case name
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let singleValueContainer = try decoder.singleValueContainer()
    let type = try container.decode(Typename.self, forKey: .__typename)

    switch type {
    case .droid:
      let value = try singleValueContainer.decode(DroidStarWarsModel.self)
      self = .droid(value)
    case .human:
      let value = try singleValueContainer.decode(HumanStarWarsModel.self)
      self = .human(value)
    }
  }

  func encode(to _: Encoder) throws {
    assertionFailure("Not implemented yet")
  }
}

// MARK: - StarWarsUnionModel

enum CharacterUnionStarWarsUnionModel: Codable {
  case human(HumanStarWarsModel)
  case droid(DroidStarWarsModel)

  enum Typename: String, Decodable {
    case human = "Human"
    case droid = "Droid"
  }

  private enum CodingKeys: String, CodingKey {
    case __typename
    case homePlanet
    case name
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let singleValueContainer = try decoder.singleValueContainer()
    let type = try container.decode(Typename.self, forKey: .__typename)

    switch type {
    case .human:
      let value = try singleValueContainer.decode(HumanStarWarsModel.self)
      self = .human(value)
    case .droid:
      let value = try singleValueContainer.decode(DroidStarWarsModel.self)
      self = .droid(value)
    }
  }

  func encode(to _: Encoder) throws {
    assertionFailure("Not implemented yet")
  }
}

// MARK: - GraphQLRequesting

// MARK: - HumanStarWarsQuery

struct HumanStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Arguments

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String
  ) {
    self.id = id
  }
}

// MARK: - DroidStarWarsQuery

struct DroidStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Arguments

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String
  ) {
    self.id = id
  }
}

// MARK: - CharacterStarWarsQuery

struct CharacterStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Arguments

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String
  ) {
    self.id = id
  }
}

// MARK: - LukeStarWarsQuery

struct LukeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - HumansStarWarsQuery

struct HumansStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - DroidsStarWarsQuery

struct DroidsStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - CharactersStarWarsQuery

struct CharactersStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - GreetingStarWarsQuery

struct GreetingStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Arguments

  let input: GreetingStarWarsInputModel?

  private enum CodingKeys: String, CodingKey {
    case input
  }

  init(
    input: GreetingStarWarsInputModel?
  ) {
    self.input = input
  }
}

// MARK: - WhoamiStarWarsQuery

struct WhoamiStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - TimeStarWarsQuery

struct TimeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - MutateStarWarsMutation

struct MutateStarWarsMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

// MARK: - NumberStarWarsSubscription

struct NumberStarWarsSubscription: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .subscription

  func encode(to _: Encoder) throws {}

  init(
  ) {}
}

struct HumanQueryResponse: Codable {
  let human: HumanStarWarsModel?
}

struct DroidQueryResponse: Codable {
  let droid: DroidStarWarsModel?
}

struct CharacterQueryResponse: Codable {
  let character: CharacterUnionStarWarsUnionModel?
}

struct LukeQueryResponse: Codable {
  let luke: HumanStarWarsModel?
}

struct HumansQueryResponse: Codable {
  let humans: [HumanStarWarsModel]
}

struct DroidsQueryResponse: Codable {
  let droids: [DroidStarWarsModel]
}

struct CharactersQueryResponse: Codable {
  let characters: [CharacterStarWarsInterfaceModel]
}

struct GreetingQueryResponse: Codable {
  let greeting: String
}

struct WhoamiQueryResponse: Codable {
  let whoami: String
}

struct TimeQueryResponse: Codable {
  let time: DateTimeInterval
}

struct MutateMutationResponse: Codable {
  let mutate: Bool
}

struct NumberSubscriptionResponse: Codable {
  let number: Int
}

// MARK: - GraphQLSelection

enum HumanSelection: String, GraphQLSelection {
  case homePlanet
  case name
}

// MARK: - Selections

struct HumanStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $id: ID!
  ) {
    human(
      id: $id
  	) {
  		...HumanFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = []
  ) {
    self.humanSelections = humanSelections
  }

  func declaration() -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	id
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
  }
}

// MARK: - Selections

struct DroidStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $id: ID!
  ) {
    droid(
      id: $id
  	) {
  		...DroidFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  init() {}

  func declaration() -> String {
    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	appearsIn
    	id
    	name
    	primaryFunction
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "DroidFragment")
  }
}

// MARK: - Selections

struct CharacterStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $id: ID!
  ) {
    character(
      id: $id
  	) {
  		...CharacterUnionFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = []
  ) {
    self.humanSelections = humanSelections
  }

  func declaration() -> String {
    let characterUnionSelectionsDeclaration = """
    fragment CharacterUnionFragment on CharacterUnion {
    	__typename
    	...HumanFragment
    	...DroidFragment
    }
    """

    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	appearsIn
    	id
    	name
    	primaryFunction
    }
    """

    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	id
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "CharacterUnionFragment": characterUnionSelectionsDeclaration,
      "DroidFragment": droidSelectionsDeclaration,
      "HumanFragment": humanSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CharacterUnionFragment")
  }
}

// MARK: - Selections

struct LukeStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    luke {
  		...HumanFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = []
  ) {
    self.humanSelections = humanSelections
  }

  func declaration() -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	id
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
  }
}

// MARK: - Selections

struct HumansStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    humans {
  		...HumanFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = []
  ) {
    self.humanSelections = humanSelections
  }

  func declaration() -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	id
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
  }
}

// MARK: - Selections

struct DroidsStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    droids {
  		...DroidFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  init() {}

  func declaration() -> String {
    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	appearsIn
    	id
    	name
    	primaryFunction
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "DroidFragment")
  }
}

// MARK: - Selections

struct CharactersStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    characters {
  		...CharacterFragment
  	}
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = []
  ) {
    self.humanSelections = humanSelections
  }

  func declaration() -> String {
    let characterSelectionsDeclaration = """
    fragment CharacterFragment on Character {
    	id
    	name
    	__typename
    	...DroidFragment
    	...HumanFragment
    }
    """

    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	appearsIn
    	id
    	name
    	primaryFunction
    }
    """

    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	id
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "CharacterFragment": characterSelectionsDeclaration,
      "DroidFragment": droidSelectionsDeclaration,
      "HumanFragment": humanSelectionsDeclaration
    ]

    return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "CharacterFragment")
  }
}

// MARK: - Selections

struct GreetingStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $input: Greeting
  ) {
    greeting(
      input: $input
  	)
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}

// MARK: - Selections

struct WhoamiStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    whoami
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}

// MARK: - Selections

struct TimeStarWarsQuerySelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query {
    time
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}

// MARK: - Selections

struct MutateStarWarsMutationSelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  mutation {
    mutate
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}

// MARK: - Selections

struct NumberStarWarsSubscriptionSelections: GraphQLSelections {
  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  subscription {
    number
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      declaration()
    )
  }

  func declaration() -> String {
    ""
  }
}
