// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - StarWarsEnums

/// One of the films in the Star Wars Trilogy
enum EpisodeStarWarsEnums: RawRepresentable, Codable {
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

  static func == (lhs: EpisodeStarWarsEnums, rhs: EpisodeStarWarsEnums) -> Bool {
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
enum LanguageStarWarsEnums: RawRepresentable, Codable {
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

  static func == (lhs: LanguageStarWarsEnums, rhs: LanguageStarWarsEnums) -> Bool {
    switch (lhs, rhs) {
    case (.en, .en): return true
    case (.sl, .sl): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

// MARK: - StarWarsObject

struct MutationStarWarsObject: Codable {
  let mutate: Bool

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case mutate
  }
}

struct DroidStarWarsObject: Codable {
  let appearsIn: [EpisodeStarWarsEnums]

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

struct HumanStarWarsObject: Codable {
  let appearsIn: [EpisodeStarWarsEnums]

  /// The home planet of the human, or null if unknown.
  let homePlanet: String?

  let id: String

  let infoUrl: String?

  let name: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case appearsIn
    case homePlanet
    case id
    case infoUrl = "infoURL"
    case name
  }
}

struct QueryStarWarsObject: Codable {
  let character: CharacterUnionStarWarsUnions?

  let characters: [CharacterStarWarsInterface]

  let droid: DroidStarWarsObject?

  let droids: [DroidStarWarsObject]

  let greeting: String

  let human: HumanStarWarsObject?

  let humans: [HumanStarWarsObject]

  let luke: HumanStarWarsObject?

  let time: String

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

struct SubscriptionStarWarsObject: Codable {
  /// Returns a random number every second. You should see it changing if your subscriptions work right.
  let number: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case number
  }
}

// MARK: - Input Objects

struct GreetingStarWarsInputObject: Codable {
  let language: LanguageStarWarsEnums?

  let name: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case language
    case name
  }
}

struct GreetingOptionsStarWarsInputObject: Codable {
  let prefix: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case prefix
  }
}

// MARK: - StarWarsInterface

struct CharacterStarWarsInterface: Codable {
  enum Object {
    case droid(DroidStarWarsObject)
    case human(HumanStarWarsObject)
  }

  enum ObjectType: String, Decodable {
    case droid = "Droid"
    case human = "Human"
  }

  let __typename: ObjectType
  let data: Object

  enum CodingKeys: String, CodingKey {
    case __typename
    case data
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let singleContainer = try decoder.singleValueContainer()

    __typename = try container.decode(ObjectType.self, forKey: .__typename)

    switch __typename {
    case .droid:
      data = .droid(try singleContainer.decode(DroidStarWarsObject.self))
    case .human:
      data = .human(try singleContainer.decode(HumanStarWarsObject.self))
    }
  }

  func encode(to _: Encoder) throws {
    fatalError("Not implemented")
  }
}

// MARK: - StarWarsUnions

struct CharacterUnionStarWarsUnions: Codable {}

// MARK: - GraphQLRequesting

// MARK: - HumanStarWarsQuery

struct HumanStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Arguments

  /// id of the character
  let id: String

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case homePlanet
      case infoURL
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {
      	appearsIn
      	id
      	name
      	\(humanSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "HumanFragment": humanSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
    }
  }

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String,
    selections: Selections = .init()
  ) {
    self.id = id
    self.selections = selections
  }
}

// MARK: - DroidStarWarsQuery

struct DroidStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Arguments

  /// id of the character
  let id: String

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let droidSelections: Set<DroidSelection>

    enum DroidSelection: String, GraphQLSelection {
      case all = ""
    }

    init(
      droidSelections: Set<DroidSelection> = []
    ) {
      self.droidSelections = droidSelections
    }

    func declaration() -> String {
      let droidSelectionsDeclaration = """
      fragment DroidFragment on Droid {
      	appearsIn
      	id
      	name
      	primaryFunction
      	\(droidSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "DroidFragment": droidSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "DroidFragment")
    }
  }

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String,
    selections: Selections = .init()
  ) {
    self.id = id
    self.selections = selections
  }
}

// MARK: - CharacterStarWarsQuery

struct CharacterStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Definition

  private let operationDefinitionFormat: String = """
  query(
    $id: ID!
  ) {
    character(
      id: $id
  	)
  }

  %1$@
  """

  var operationDefinition: String {
    String(
      format: operationDefinitionFormat,
      selections.declaration()
    )
  }

  // MARK: - Arguments

  /// id of the character
  let id: String

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id
  }

  init(
    id: String,
    selections: Selections = .init()
  ) {
    self.id = id
    self.selections = selections
  }
}

// MARK: - LukeStarWarsQuery

struct LukeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case homePlanet
      case infoURL
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {
      	appearsIn
      	id
      	name
      	\(humanSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "HumanFragment": humanSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - HumansStarWarsQuery

struct HumansStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case homePlanet
      case infoURL
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {
      	appearsIn
      	id
      	name
      	\(humanSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "HumanFragment": humanSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "HumanFragment")
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - DroidsStarWarsQuery

struct DroidsStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let droidSelections: Set<DroidSelection>

    enum DroidSelection: String, GraphQLSelection {
      case all = ""
    }

    init(
      droidSelections: Set<DroidSelection> = []
    ) {
      self.droidSelections = droidSelections
    }

    func declaration() -> String {
      let droidSelectionsDeclaration = """
      fragment DroidFragment on Droid {
      	appearsIn
      	id
      	name
      	primaryFunction
      	\(droidSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "DroidFragment": droidSelectionsDeclaration
      ]

      return declaration(selectionDeclarationMap: selectionDeclarationMap, rootSelectionKey: "DroidFragment")
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - CharactersStarWarsQuery

struct CharactersStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let characterSelections: Set<CharacterSelection>

    enum CharacterSelection: String, GraphQLSelection {
      case all = ""
    }

    let droidSelections: Set<DroidSelection>

    enum DroidSelection: String, GraphQLSelection {
      case all = ""
    }

    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case homePlanet
      case infoURL
    }

    init(
      characterSelections: Set<CharacterSelection> = [],
      droidSelections: Set<DroidSelection> = [],
      humanSelections: Set<HumanSelection> = []
    ) {
      self.characterSelections = characterSelections
      self.droidSelections = droidSelections
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let characterSelectionsDeclaration = """
      fragment CharacterFragment on Character {
      	id
      	name
      	\(characterSelections.declaration)
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
      	\(droidSelections.declaration)
      }
      """

      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {
      	appearsIn
      	id
      	name
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

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - GreetingStarWarsQuery

struct GreetingStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Arguments

  let input: GreetingStarWarsInputObject?

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  private enum CodingKeys: String, CodingKey {
    case input
  }

  init(
    input: GreetingStarWarsInputObject?,
    selections: Selections = .init()
  ) {
    self.input = input
    self.selections = selections
  }
}

// MARK: - WhoamiStarWarsQuery

struct WhoamiStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - TimeStarWarsQuery

struct TimeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - MutateStarWarsMutation

struct MutateStarWarsMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

// MARK: - NumberStarWarsSubscription

struct NumberStarWarsSubscription: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .subscription

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
      selections.declaration()
    )
  }

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    func declaration() -> String {
      ""
    }
  }

  func encode(to _: Encoder) throws {}

  init(
    selections: Selections = .init()
  ) {
    self.selections = selections
  }
}

struct HumanQueryResponse: GraphQLResponseData {
  let human: HumanStarWarsObject?
}

struct DroidQueryResponse: GraphQLResponseData {
  let droid: DroidStarWarsObject?
}

struct CharacterQueryResponse: GraphQLResponseData {
  let character: CharacterUnionStarWarsUnions?
}

struct LukeQueryResponse: GraphQLResponseData {
  let luke: HumanStarWarsObject?
}

struct HumansQueryResponse: GraphQLResponseData {
  let humans: [HumanStarWarsObject]
}

struct DroidsQueryResponse: GraphQLResponseData {
  let droids: [DroidStarWarsObject]
}

struct CharactersQueryResponse: GraphQLResponseData {
  let characters: [CharacterStarWarsInterface]
}

struct GreetingQueryResponse: GraphQLResponseData {
  let greeting: String
}

struct WhoamiQueryResponse: GraphQLResponseData {
  let whoami: String
}

struct TimeQueryResponse: GraphQLResponseData {
  let time: String
}

struct MutateMutationResponse: GraphQLResponseData {
  let mutate: Bool
}

struct NumberSubscriptionResponse: GraphQLResponseData {
  let number: Int
}
