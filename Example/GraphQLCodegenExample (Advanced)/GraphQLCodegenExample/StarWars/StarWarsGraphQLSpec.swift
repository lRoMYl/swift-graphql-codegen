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
  let mutate: Optional<Bool>

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
  let character: Optional<CharacterUnionStarWarsUnionModel?>

  let characters: Optional<[CharacterStarWarsInterfaceModel]>

  let droid: Optional<DroidStarWarsModel?>

  let droids: Optional<[DroidStarWarsModel]>

  let greeting: Optional<String>

  let human: Optional<HumanStarWarsModel?>

  let humans: Optional<[HumanStarWarsModel]>

  let luke: Optional<HumanStarWarsModel?>

  let time: Optional<DateTimeInterval>

  let whoami: Optional<String>

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
  let number: Optional<Int>

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
    fatalError("Not implemented yet")
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
    fatalError("Not implemented yet")
  }
}

// MARK: - GraphQLRequesting

/// HumanStarWarsQuery
struct HumanStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["HumanFragment"]

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

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    human(
      id: \(id)
    ) {
       ...HumanFragment
    }
    """
  }
}

/// DroidStarWarsQuery
struct DroidStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["DroidFragment"]

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

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    droid(
      id: \(id)
    ) {
       ...DroidFragment
    }
    """
  }
}

/// CharacterStarWarsQuery
struct CharacterStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["CharacterUnionFragment"]

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

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    character(
      id: \(id)
    ) {
       ...CharacterUnionFragment
    }
    """
  }
}

/// LukeStarWarsQuery
struct LukeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["HumanFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    luke {
       ...HumanFragment
    }
    """
  }
}

/// HumansStarWarsQuery
struct HumansStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["HumanFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    humans {
       ...HumanFragment
    }
    """
  }
}

/// DroidsStarWarsQuery
struct DroidsStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["DroidFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    droids {
       ...DroidFragment
    }
    """
  }
}

/// CharactersStarWarsQuery
struct CharactersStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["CharacterFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    characters {
       ...CharacterFragment
    }
    """
  }
}

/// GreetingStarWarsQuery
struct GreetingStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = []

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

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    greeting(
      input: \(input)
    )
    """
  }
}

/// WhoamiStarWarsQuery
struct WhoamiStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    whoami
    """
  }
}

/// TimeStarWarsQuery
struct TimeStarWarsQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    time
    """
  }
}

struct StarWarsQuery: GraphQLRequesting {
  let requestType: GraphQLRequestType = .query
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let human: HumanStarWarsQuery?
  let droid: DroidStarWarsQuery?
  let character: CharacterStarWarsQuery?
  let luke: LukeStarWarsQuery?
  let humans: HumansStarWarsQuery?
  let droids: DroidsStarWarsQuery?
  let characters: CharactersStarWarsQuery?
  let greeting: GreetingStarWarsQuery?
  let whoami: WhoamiStarWarsQuery?
  let time: TimeStarWarsQuery?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      human,
      droid,
      character,
      luke,
      humans,
      droids,
      characters,
      greeting,
      whoami,
      time
    ]

    return requests.compactMap { $0 }
  }

  init(
    human: HumanStarWarsQuery? = nil,
    droid: DroidStarWarsQuery? = nil,
    character: CharacterStarWarsQuery? = nil,
    luke: LukeStarWarsQuery? = nil,
    humans: HumansStarWarsQuery? = nil,
    droids: DroidsStarWarsQuery? = nil,
    characters: CharactersStarWarsQuery? = nil,
    greeting: GreetingStarWarsQuery? = nil,
    whoami: WhoamiStarWarsQuery? = nil,
    time: TimeStarWarsQuery? = nil
  ) {
    self.human = human
    self.droid = droid
    self.character = character
    self.luke = luke
    self.humans = humans
    self.droids = droids
    self.characters = characters
    self.greeting = greeting
    self.whoami = whoami
    self.time = time
  }

  func encode(to encoder: Encoder) throws {
    try requests.forEach {
      try $0.encode(to: encoder)
    }
  }

  func operationDefinition() -> String {
    requests
      .map { $0.operationDefinition() }
      .joined(separator: "\n")
  }
}

/// MutateStarWarsMutation
struct MutateStarWarsMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    mutate
    """
  }
}

struct StarWarsMutation: GraphQLRequesting {
  let requestType: GraphQLRequestType = .mutation
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let mutate: MutateStarWarsMutation?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      mutate
    ]

    return requests.compactMap { $0 }
  }

  init(
    mutate: MutateStarWarsMutation? = nil
  ) {
    self.mutate = mutate
  }

  func encode(to encoder: Encoder) throws {
    try requests.forEach {
      try $0.encode(to: encoder)
    }
  }

  func operationDefinition() -> String {
    requests
      .map { $0.operationDefinition() }
      .joined(separator: "\n")
  }
}

/// NumberStarWarsSubscription
struct NumberStarWarsSubscription: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .subscription
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    number
    """
  }
}

struct StarWarsSubscription: GraphQLRequesting {
  let requestType: GraphQLRequestType = .subscription
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let number: NumberStarWarsSubscription?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      number
    ]

    return requests.compactMap { $0 }
  }

  init(
    number: NumberStarWarsSubscription? = nil
  ) {
    self.number = number
  }

  func encode(to encoder: Encoder) throws {
    try requests.forEach {
      try $0.encode(to: encoder)
    }
  }

  func operationDefinition() -> String {
    requests
      .map { $0.operationDefinition() }
      .joined(separator: "\n")
  }
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

enum DroidSelection: GraphQLSelection {
  static let requiredDeclaration = """
  appearsIn
  id
  name
  primaryFunction
  """
}

enum HumanSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  id
  """

  case homePlanet
  case name
}

struct StarWarsQuerySelections: GraphQLSelections {
  let droid: Set<DroidSelection>
  let human: Set<HumanSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    droid: Set<DroidSelection> = .allFields,
    human: Set<HumanSelection> = .allFields
  ) {
    self.droid = droid
    self.human = human
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let droidDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let humanDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(human.declaration)
    }
    """

    let characterDeclaration = """
    fragment CharacterFragment on Character {
    	__typename
    	...DroidFragment
    	...HumanFragment
    }
    """

    let characterUnionDeclaration = """
    fragment CharacterUnionFragment on CharacterUnion {
    	__typename
    	...HumanFragment
    	...DroidFragment
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidDeclaration,
      "HumanFragment": humanDeclaration,
      "CharacterFragment": characterDeclaration,
      "CharacterUnionFragment": characterUnionDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct HumanStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct DroidStarWarsQuerySelections: GraphQLSelections {
  init() {}

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct CharacterStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let characterUnionSelectionsDeclaration = """
    fragment CharacterUnionFragment on CharacterUnion {
    	__typename
    	...HumanFragment
    	...DroidFragment
    }
    """

    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "CharacterUnionFragment": characterUnionSelectionsDeclaration,
      "DroidFragment": droidSelectionsDeclaration,
      "HumanFragment": humanSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct LukeStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct HumansStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "HumanFragment": humanSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct DroidsStarWarsQuerySelections: GraphQLSelections {
  init() {}

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct CharactersStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let characterSelectionsDeclaration = """
    fragment CharacterFragment on Character {
    	__typename
    	...DroidFragment
    	...HumanFragment
    }
    """

    let droidSelectionsDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let humanSelectionsDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(humanSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "CharacterFragment": characterSelectionsDeclaration,
      "DroidFragment": droidSelectionsDeclaration,
      "HumanFragment": humanSelectionsDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct GreetingStarWarsQuerySelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

// MARK: - Selections

struct WhoamiStarWarsQuerySelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

// MARK: - Selections

struct TimeStarWarsQuerySelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

struct StarWarsMutationSelections: GraphQLSelections {
  let droid: Set<DroidSelection>
  let human: Set<HumanSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    droid: Set<DroidSelection> = .allFields,
    human: Set<HumanSelection> = .allFields
  ) {
    self.droid = droid
    self.human = human
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let droidDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let humanDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(human.declaration)
    }
    """

    let characterDeclaration = """
    fragment CharacterFragment on Character {
    	__typename
    	...DroidFragment
    	...HumanFragment
    }
    """

    let characterUnionDeclaration = """
    fragment CharacterUnionFragment on CharacterUnion {
    	__typename
    	...HumanFragment
    	...DroidFragment
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidDeclaration,
      "HumanFragment": humanDeclaration,
      "CharacterFragment": characterDeclaration,
      "CharacterUnionFragment": characterUnionDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct MutateStarWarsMutationSelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

struct StarWarsSubscriptionSelections: GraphQLSelections {
  let droid: Set<DroidSelection>
  let human: Set<HumanSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    droid: Set<DroidSelection> = .allFields,
    human: Set<HumanSelection> = .allFields
  ) {
    self.droid = droid
    self.human = human
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let droidDeclaration = """
    fragment DroidFragment on Droid {
    	\(DroidSelection.requiredDeclaration)
    }
    """

    let humanDeclaration = """
    fragment HumanFragment on Human {
    	\(HumanSelection.requiredDeclaration)
    	\(human.declaration)
    }
    """

    let characterDeclaration = """
    fragment CharacterFragment on Character {
    	__typename
    	...DroidFragment
    	...HumanFragment
    }
    """

    let characterUnionDeclaration = """
    fragment CharacterUnionFragment on CharacterUnion {
    	__typename
    	...HumanFragment
    	...DroidFragment
    }
    """

    let selectionDeclarationMap = [
      "DroidFragment": droidDeclaration,
      "HumanFragment": humanDeclaration,
      "CharacterFragment": characterDeclaration,
      "CharacterUnionFragment": characterUnionDeclaration
    ]

    let fragmentMaps = rootSelectionKeys
      .map {
        declaration(
          selectionDeclarationMap: selectionDeclarationMap,
          rootSelectionKey: $0
        )
      }
      .reduce([String: String]()) { old, new in
        old.merging(new, uniquingKeysWith: { _, new in new })
      }

    return fragmentMaps.values.joined(separator: "\n")
  }
}

// MARK: - Selections

struct NumberStarWarsSubscriptionSelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}
