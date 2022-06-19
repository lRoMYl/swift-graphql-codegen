// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation
// MARK: - StarWarsEnumModel

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

// MARK: - StarWarsModel

struct DroidStarWarsModel: Decodable {
  private let internalId: Optional<String>
  private let internalName: Optional<String>

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  func name() throws -> String {
    try value(for: \Self.internalName, codingKey: CodingKeys.internalName)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
    internalName = try container.decodeOptionalIfPresent(String.self, forKey: .internalName)
  }

  private enum CodingKeys: String, CodingKey {
    case internalId = "id"
    case internalName = "name"
  }
}

struct HumanStarWarsModel: Decodable {
  private let internalId: Optional<String>

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
  }

  private enum CodingKeys: String, CodingKey {
    case internalId = "id"
  }
}

struct QueryStarWarsModel: Decodable {
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

struct MutationStarWarsModel: Decodable {
  let mutate: Optional<Bool>

  private enum CodingKeys: String, CodingKey {
    case mutate
  }
}

struct SubscriptionStarWarsModel: Decodable {
  let number: Optional<Int>

  private enum CodingKeys: String, CodingKey {
    case number
  }
}

// MARK: - Input Objects

struct GreetingOptionsStarWarsInputModel: Codable {
  let prefix: String?

  private enum CodingKeys: String, CodingKey {
    case prefix
  }
}

struct GreetingStarWarsInputModel: Codable {
  let language: LanguageStarWarsEnumModel?
  let name: String

  private enum CodingKeys: String, CodingKey {
    case language
    case name
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
    case id
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

// MARK: - GraphQLRequestParameter

/// CharactersStarWarsQuery
struct CharactersStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "characters"
  let rootSelectionKeys: Set<String> = ["CharactersCharacterFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    characters {
       ...CharactersCharacterFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// CharacterStarWarsQuery
struct CharacterStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "character"
  let rootSelectionKeys: Set<String> = ["CharacterCharacterUnionFragment"]

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id = "characterId"
  }

  init(
    id: String
  ) {
    self.id = id
  }

  let requestQuery: String = {
    """
    character(
      id: $characterId
    ) {
       ...CharacterCharacterUnionFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$characterId", "$characterId: ID!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// TimeStarWarsQuery
struct TimeStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "time"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    time
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// DroidStarWarsQuery
struct DroidStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "droid"
  let rootSelectionKeys: Set<String> = ["DroidDroidFragment"]

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id = "droidId"
  }

  init(
    id: String
  ) {
    self.id = id
  }

  let requestQuery: String = {
    """
    droid(
      id: $droidId
    ) {
       ...DroidDroidFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$droidId", "$droidId: ID!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// DroidsStarWarsQuery
struct DroidsStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "droids"
  let rootSelectionKeys: Set<String> = ["DroidsDroidFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    droids {
       ...DroidsDroidFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// HumanStarWarsQuery
struct HumanStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "human"
  let rootSelectionKeys: Set<String> = ["HumanHumanFragment"]

  /// id of the character
  let id: String

  private enum CodingKeys: String, CodingKey {
    /// id of the character
    case id = "humanId"
  }

  init(
    id: String
  ) {
    self.id = id
  }

  let requestQuery: String = {
    """
    human(
      id: $humanId
    ) {
       ...HumanHumanFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$humanId", "$humanId: ID!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// HumansStarWarsQuery
struct HumansStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "humans"
  let rootSelectionKeys: Set<String> = ["HumansHumanFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    humans {
       ...HumansHumanFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// LukeStarWarsQuery
struct LukeStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "luke"
  let rootSelectionKeys: Set<String> = ["LukeHumanFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    luke {
       ...LukeHumanFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// GreetingStarWarsQuery
struct GreetingStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "greeting"
  let rootSelectionKeys: Set<String> = []

  let input: GreetingStarWarsInputModel?

  private enum CodingKeys: String, CodingKey {
    case input = "greetingInput"
  }

  init(
    input: GreetingStarWarsInputModel?
  ) {
    self.input = input
  }

  let requestQuery: String = {
    """
    greeting(
      input: $greetingInput
    )
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$greetingInput", "$greetingInput: Greeting")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

/// WhoamiStarWarsQuery
struct WhoamiStarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "whoami"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    whoami
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

struct StarWarsQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = ""
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let character: CharacterStarWarsQuery?
  let characters: CharactersStarWarsQuery?
  let droid: DroidStarWarsQuery?
  let droids: DroidsStarWarsQuery?
  let greeting: GreetingStarWarsQuery?
  let human: HumanStarWarsQuery?
  let humans: HumansStarWarsQuery?
  let luke: LukeStarWarsQuery?
  let time: TimeStarWarsQuery?
  let whoami: WhoamiStarWarsQuery?

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
      character,
      characters,
      droid,
      droids,
      greeting,
      human,
      humans,
      luke,
      time,
      whoami
    ]

    return requests.compactMap { $0 }
  }

  init(
    character: CharacterStarWarsQuery? = nil,
    characters: CharactersStarWarsQuery? = nil,
    droid: DroidStarWarsQuery? = nil,
    droids: DroidsStarWarsQuery? = nil,
    greeting: GreetingStarWarsQuery? = nil,
    human: HumanStarWarsQuery? = nil,
    humans: HumansStarWarsQuery? = nil,
    luke: LukeStarWarsQuery? = nil,
    time: TimeStarWarsQuery? = nil,
    whoami: WhoamiStarWarsQuery? = nil
  ) {
    self.character = character
    self.characters = characters
    self.droid = droid
    self.droids = droids
    self.greeting = greeting
    self.human = human
    self.humans = humans
    self.luke = luke
    self.time = time
    self.whoami = whoami
  }

  func encode(to encoder: Encoder) throws {
    try requests.forEach {
      try $0.encode(to: encoder)
    }
  }

  var requestQuery: String {
    requests
      .map { $0.requestQuery }
      .joined(separator: "\n")
  }

  var requestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.requestArguments)
    }
  }

  var subRequestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.subRequestArguments)
    }
  }

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    requests.map {
      selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
    }.joined(separator: "\n")
  }
}

/// MutateStarWarsMutation
struct MutateStarWarsMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = "mutate"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    mutate
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

struct StarWarsMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = ""
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let mutate: MutateStarWarsMutation?

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
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

  var requestQuery: String {
    requests
      .map { $0.requestQuery }
      .joined(separator: "\n")
  }

  var requestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.requestArguments)
    }
  }

  var subRequestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.subRequestArguments)
    }
  }

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    requests.map {
      selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
    }.joined(separator: "\n")
  }
}

/// NumberStarWarsSubscription
struct NumberStarWarsSubscription: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .subscription
  let requestName: String = "number"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    number
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
  ]

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    selections.requestFragments(for: requestName, rootSelectionKeys: rootSelectionKeys)
  }
}

struct StarWarsSubscription: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .subscription
  let requestName: String = ""
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let number: NumberStarWarsSubscription?

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
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

  var requestQuery: String {
    requests
      .map { $0.requestQuery }
      .joined(separator: "\n")
  }

  var requestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.requestArguments)
    }
  }

  var subRequestArguments: [(key: String, value: String)] {
    requests.reduce(into: [(key: String, value: String)]()) { result, element in
      result.append(contentsOf: element.subRequestArguments)
    }
  }

  func requestArguments(with selections: GraphQLSelections) -> String {
    let requestFragments = self.requestFragments(with: selections)
    var selectedSubRequestArguments = [(key: String, value: String)]()
    subRequestArguments.forEach {
      if requestFragments.contains($0.key) {
        selectedSubRequestArguments.append($0)
      }
    }
    let arguments = requestArguments + selectedSubRequestArguments
    return arguments.isEmpty
      ? ""
      : " (\(arguments.map { $0.value }.joined(separator: ",\n")))"
  }

  func requestFragments(with selections: GraphQLSelections) -> String {
    requests.map {
      selections.requestFragments(for: $0.requestName, rootSelectionKeys: rootSelectionKeys)
    }.joined(separator: "\n")
  }
}

struct CharacterQueryResponse: Decodable {
  let character: CharacterUnionStarWarsUnionModel?
}

struct CharactersQueryResponse: Decodable {
  let characters: [CharacterStarWarsInterfaceModel]
}

struct DroidQueryResponse: Decodable {
  let droid: DroidStarWarsModel?
}

struct DroidsQueryResponse: Decodable {
  let droids: [DroidStarWarsModel]
}

struct GreetingQueryResponse: Decodable {
  let greeting: String
}

struct HumanQueryResponse: Decodable {
  let human: HumanStarWarsModel?
}

struct HumansQueryResponse: Decodable {
  let humans: [HumanStarWarsModel]
}

struct LukeQueryResponse: Decodable {
  let luke: HumanStarWarsModel?
}

struct TimeQueryResponse: Decodable {
  let time: DateTimeInterval
}

struct WhoamiQueryResponse: Decodable {
  let whoami: String
}

struct MutateMutationResponse: Decodable {
  let mutate: Bool
}

struct NumberSubscriptionResponse: Decodable {
  let number: Int
}

// MARK: - GraphQLSelection

enum DroidSelection: String, GraphQLSelection {
  case id
  case name
}

enum HumanSelection: String, GraphQLSelection {
  case id
}

// MARK: - Selections

struct StarWarsQuerySelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>
  let humanSelections: Set<HumanSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields,
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        requestFragment(
          requestName: requestName,
          typeName: "Character",
          possibleTypeNames: [
            "Droid",
            "Human"
          ]
        ),
        requestFragment(
          requestName: requestName,
          typeName: "CharacterUnion",
          possibleTypeNames: [
            "Human",
            "Droid"
          ]
        ),
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid"),
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct CharacterStarWarsQuerySelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>
  let humanSelections: Set<HumanSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields,
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        requestFragment(
          requestName: requestName,
          typeName: "CharacterUnion",
          possibleTypeNames: [
            "Human",
            "Droid"
          ]
        ),
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid"),
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct CharactersStarWarsQuerySelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>
  let humanSelections: Set<HumanSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields,
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        requestFragment(
          requestName: requestName,
          typeName: "Character",
          possibleTypeNames: [
            "Droid",
            "Human"
          ]
        ),
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid"),
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct DroidStarWarsQuerySelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct DroidsStarWarsQuerySelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct GreetingStarWarsQuerySelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}

struct HumanStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct HumansStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct LukeStarWarsQuerySelections: GraphQLSelections {
  let humanSelections: Set<HumanSelection>

  init(
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct TimeStarWarsQuerySelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}

struct WhoamiStarWarsQuerySelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}

struct StarWarsMutationSelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>
  let humanSelections: Set<HumanSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields,
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        requestFragment(
          requestName: requestName,
          typeName: "Character",
          possibleTypeNames: [
            "Droid",
            "Human"
          ]
        ),
        requestFragment(
          requestName: requestName,
          typeName: "CharacterUnion",
          possibleTypeNames: [
            "Human",
            "Droid"
          ]
        ),
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid"),
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct MutateStarWarsMutationSelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}

struct StarWarsSubscriptionSelections: GraphQLSelections {
  let droidSelections: Set<DroidSelection>
  let humanSelections: Set<HumanSelection>

  init(
    droidSelections: Set<DroidSelection> = .allFields,
    humanSelections: Set<HumanSelection> = .allFields
  ) {
    self.droidSelections = droidSelections
    self.humanSelections = humanSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        requestFragment(
          requestName: requestName,
          typeName: "Character",
          possibleTypeNames: [
            "Droid",
            "Human"
          ]
        ),
        requestFragment(
          requestName: requestName,
          typeName: "CharacterUnion",
          possibleTypeNames: [
            "Human",
            "Droid"
          ]
        ),
        droidSelections.requestFragment(requestName: requestName, typeName: "Droid"),
        humanSelections.requestFragment(requestName: requestName, typeName: "Human")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct NumberStarWarsSubscriptionSelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}