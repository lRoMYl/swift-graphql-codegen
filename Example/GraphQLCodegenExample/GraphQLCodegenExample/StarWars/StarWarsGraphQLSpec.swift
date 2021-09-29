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

// MARK: - StarWarsObjects

struct MutationStarWarsObjects: Codable {
  let mutate: Bool

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case mutate
  }
}

struct DroidStarWarsObjects: Codable {
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

struct HumanStarWarsObjects: Codable {
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

struct QueryStarWarsObjects: Codable {
  let character: CharacterUnionStarWarsUnions?

  let characters: [CharacterStarWarsInterfaces]

  let droid: DroidStarWarsObjects?

  let droids: [DroidStarWarsObjects]

  let greeting: String

  let human: HumanStarWarsObjects?

  let humans: [HumanStarWarsObjects]

  let luke: HumanStarWarsObjects?

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

struct SubscriptionStarWarsObjects: Codable {
  /// Returns a random number every second. You should see it changing if your subscriptions work right.

  let number: Int

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case number
  }
}

// MARK: - Input Objects

struct GreetingStarWarsInputObjects: Codable {
  let language: LanguageStarWarsEnums?

  let name: String

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case language
    case name
  }
}

struct GreetingOptionsStarWarsInputObjects: Codable {
  let prefix: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case prefix
  }
}

// MARK: - StarWarsInterfaces

struct CharacterStarWarsInterfaces: Codable {}

// MARK: - StarWarsUnions

struct CharacterUnionStarWarsUnions: Codable {}

// MARK: - GraphQLRequestParameter

// MARK: - StarWarsQueries

// MARK: - HumanStarWarsQueries

struct HumanStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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
      case appearsIn
      case homePlanet
      case id
      case infoURL
      case name
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {\(humanSelections.declaration)
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

// MARK: - DroidStarWarsQueries

struct DroidStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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
      case appearsIn
      case id
      case name
      case primaryFunction
    }

    init(
      droidSelections: Set<DroidSelection> = []
    ) {
      self.droidSelections = droidSelections
    }

    func declaration() -> String {
      let droidSelectionsDeclaration = """
      fragment DroidFragment on Droid {\(droidSelections.declaration)
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

// MARK: - CharacterStarWarsQueries

struct CharacterStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

// MARK: - LukeStarWarsQueries

struct LukeStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case appearsIn
      case homePlanet
      case id
      case infoURL
      case name
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {\(humanSelections.declaration)
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

// MARK: - HumansStarWarsQueries

struct HumansStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let humanSelections: Set<HumanSelection>

    enum HumanSelection: String, GraphQLSelection {
      case appearsIn
      case homePlanet
      case id
      case infoURL
      case name
    }

    init(
      humanSelections: Set<HumanSelection> = []
    ) {
      self.humanSelections = humanSelections
    }

    func declaration() -> String {
      let humanSelectionsDeclaration = """
      fragment HumanFragment on Human {\(humanSelections.declaration)
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

// MARK: - DroidsStarWarsQueries

struct DroidsStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let droidSelections: Set<DroidSelection>

    enum DroidSelection: String, GraphQLSelection {
      case appearsIn
      case id
      case name
      case primaryFunction
    }

    init(
      droidSelections: Set<DroidSelection> = []
    ) {
      self.droidSelections = droidSelections
    }

    func declaration() -> String {
      let droidSelectionsDeclaration = """
      fragment DroidFragment on Droid {\(droidSelections.declaration)
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

// MARK: - CharactersStarWarsQueries

struct CharactersStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

  // MARK: - Selections

  let selections: Selections

  struct Selections: GraphQLSelections {
    let characterSelections: Set<CharacterSelection>

    enum CharacterSelection: String, GraphQLSelection {
      case id
      case name
    }

    init(
      characterSelections: Set<CharacterSelection> = []
    ) {
      self.characterSelections = characterSelections
    }

    func declaration() -> String {
      let characterSelectionsDeclaration = """
      fragment CharacterFragment on Character {\(characterSelections.declaration)
      }
      """

      let selectionDeclarationMap = [
        "CharacterFragment": characterSelectionsDeclaration
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

// MARK: - GreetingStarWarsQueries

struct GreetingStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  let input: GreetingStarWarsInputObjects?

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
    input: GreetingStarWarsInputObjects?,
    selections: Selections = .init()
  ) {
    self.input = input
    self.selections = selections
  }
}

// MARK: - WhoamiStarWarsQueries

struct WhoamiStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

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

// MARK: - TimeStarWarsQueries

struct TimeStarWarsQueries: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

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

// MARK: - StarWarsMutations

// MARK: - MutateStarWarsMutations

struct MutateStarWarsMutations: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

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

// MARK: - StarWarsSubscriptions

// MARK: - NumberStarWarsSubscriptions

struct NumberStarWarsSubscriptions: GraphQLRequestParameter {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .subscription

  // MARK: - Operation Defintion

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

  // MARK: - Arguments

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