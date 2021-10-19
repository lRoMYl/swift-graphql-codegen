// @generated
// Do not edit this generated file
// swiftlint:disable all

import Foundation

// MARK: - ApolloEnumModel

enum PatchSizeApolloEnumModel: RawRepresentable, Codable {
  typealias RawValue = String

  case small

  case large

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "SMALL": self = .small
    case "LARGE": self = .large
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .small: return "SMALL"
    case .large: return "LARGE"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: PatchSizeApolloEnumModel, rhs: PatchSizeApolloEnumModel) -> Bool {
    switch (lhs, rhs) {
    case (.small, .small): return true
    case (.large, .large): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

enum CacheControlScopeApolloEnumModel: RawRepresentable, Codable {
  typealias RawValue = String

  case `public`

  case `private`

  /// Auto generated constant for unknown enum values
  case _unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
    case "PUBLIC": self = .public
    case "PRIVATE": self = .private
    default: self = ._unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
    case .public: return "PUBLIC"
    case .private: return "PRIVATE"
    case let ._unknown(value): return value
    }
  }

  static func == (lhs: CacheControlScopeApolloEnumModel, rhs: CacheControlScopeApolloEnumModel) -> Bool {
    switch (lhs, rhs) {
    case (.public, .public): return true
    case (.private, .private): return true
    case let (._unknown(lhsValue), ._unknown(rhsValue)): return lhsValue == rhsValue
    default: return false
    }
  }
}

// MARK: - ApolloModel

struct QueryApolloModel: Codable {
  let launch: Optional<LaunchApolloModel?>

  let launches: Optional<LaunchConnectionApolloModel>

  let me: Optional<UserApolloModel?>

  let tripsBooked: Optional<Int?>

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case launch
    case launches
    case me
    case tripsBooked
  }
}

struct LaunchConnectionApolloModel: Codable {
  let cursor: String

  let hasMore: Bool

  let launches: [LaunchApolloModel?]

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case cursor
    case hasMore
    case launches
  }
}

struct LaunchApolloModel: Codable {
  let id: String

  let isBooked: Bool

  let mission: MissionApolloModel?

  let rocket: RocketApolloModel?

  let site: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case id
    case isBooked
    case mission
    case rocket
    case site
  }
}

struct MissionApolloModel: Codable {
  let missionPatch: String?

  let name: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case missionPatch
    case name
  }
}

struct RocketApolloModel: Codable {
  let id: String

  let name: String?

  let type: String?

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case type
  }
}

struct UserApolloModel: Codable {
  let email: String

  let id: String

  let profileImage: String?

  let trips: [LaunchApolloModel?]

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case email
    case id
    case profileImage
    case trips
  }
}

struct MutationApolloModel: Codable {
  let bookTrips: Optional<TripUpdateResponseApolloModel>

  let cancelTrip: Optional<TripUpdateResponseApolloModel>

  let login: Optional<String?>

  let uploadProfileImage: Optional<UserApolloModel?>

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case bookTrips
    case cancelTrip
    case login
    case uploadProfileImage
  }
}

struct TripUpdateResponseApolloModel: Codable {
  let launches: [LaunchApolloModel?]?

  let message: String?

  let success: Bool

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case launches
    case message
    case success
  }
}

struct SubscriptionApolloModel: Codable {
  let tripsBooked: Optional<Int?>

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case tripsBooked
  }
}

// MARK: - GraphQLRequesting

/// LaunchesApolloQuery
struct LaunchesApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["LaunchConnectionFragment"]

  // MARK: - Arguments

  /// The number of results to show. Must be >= 1. Default = 20
  let pageSize: Int?
  /// If you add a cursor here, it will only return results _after_ this cursor
  let after: String?

  private enum CodingKeys: String, CodingKey {
    /// The number of results to show. Must be >= 1. Default = 20
    case pageSize = "launchesPageSize"
    /// If you add a cursor here, it will only return results _after_ this cursor
    case after = "launchesAfter"
  }

  init(
    pageSize: Int?,
    after: String?
  ) {
    self.pageSize = pageSize
    self.after = after
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    launches(
      pageSize: $launchesPageSize
      after: $launchesAfter
    ) {
       ...LaunchConnectionFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $launchesPageSize: Int
    $launchesAfter: String
    """
  }
}

/// LaunchApolloQuery
struct LaunchApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["LaunchFragment"]

  // MARK: - Arguments

  let id: String

  private enum CodingKeys: String, CodingKey {
    case id = "launchId"
  }

  init(
    id: String
  ) {
    self.id = id
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    launch(
      id: $launchId
    ) {
       ...LaunchFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $launchId: ID!
    """
  }
}

/// MeApolloQuery
struct MeApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["UserFragment"]

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    me {
       ...UserFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    """
  }
}

/// TripsBookedApolloQuery
struct TripsBookedApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    tripsBooked
    """
  }

  func operationArguments() -> String {
    """
    """
  }
}

struct ApolloQuery: GraphQLRequesting {
  let requestType: GraphQLRequestType = .query
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let launches: LaunchesApolloQuery?
  let launch: LaunchApolloQuery?
  let me: MeApolloQuery?
  let tripsBooked: TripsBookedApolloQuery?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      launches,
      launch,
      me,
      tripsBooked
    ]

    return requests.compactMap { $0 }
  }

  init(
    launches: LaunchesApolloQuery? = nil,
    launch: LaunchApolloQuery? = nil,
    me: MeApolloQuery? = nil,
    tripsBooked: TripsBookedApolloQuery? = nil
  ) {
    self.launches = launches
    self.launch = launch
    self.me = me
    self.tripsBooked = tripsBooked
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

  func operationArguments() -> String {
    requests
      .map { $0.operationArguments() }
      .joined(separator: "\n")
  }
}

/// BookTripsApolloMutation
struct BookTripsApolloMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation
  let rootSelectionKeys: Set<String> = ["TripUpdateResponseFragment"]

  // MARK: - Arguments

  let launchIds: [String?]

  private enum CodingKeys: String, CodingKey {
    case launchIds = "bookTripsLaunchIds"
  }

  init(
    launchIds: [String?]
  ) {
    self.launchIds = launchIds
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    bookTrips(
      launchIds: $bookTripsLaunchIds
    ) {
       ...TripUpdateResponseFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $bookTripsLaunchIds: [ID]!
    """
  }
}

/// CancelTripApolloMutation
struct CancelTripApolloMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation
  let rootSelectionKeys: Set<String> = ["TripUpdateResponseFragment"]

  // MARK: - Arguments

  let launchId: String

  private enum CodingKeys: String, CodingKey {
    case launchId = "cancelTripLaunchId"
  }

  init(
    launchId: String
  ) {
    self.launchId = launchId
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    cancelTrip(
      launchId: $cancelTripLaunchId
    ) {
       ...TripUpdateResponseFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $cancelTripLaunchId: ID!
    """
  }
}

/// LoginApolloMutation
struct LoginApolloMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation
  let rootSelectionKeys: Set<String> = []

  // MARK: - Arguments

  let email: String?

  private enum CodingKeys: String, CodingKey {
    case email = "loginEmail"
  }

  init(
    email: String?
  ) {
    self.email = email
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    login(
      email: $loginEmail
    )
    """
  }

  func operationArguments() -> String {
    """
    $loginEmail: String
    """
  }
}

/// UploadProfileImageApolloMutation
struct UploadProfileImageApolloMutation: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .mutation
  let rootSelectionKeys: Set<String> = ["UserFragment"]

  // MARK: - Arguments

  let file: String

  private enum CodingKeys: String, CodingKey {
    case file = "uploadProfileImageFile"
  }

  init(
    file: String
  ) {
    self.file = file
  }

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    uploadProfileImage(
      file: $uploadProfileImageFile
    ) {
       ...UserFragment
    }
    """
  }

  func operationArguments() -> String {
    """
    $uploadProfileImageFile: Upload!
    """
  }
}

struct ApolloMutation: GraphQLRequesting {
  let requestType: GraphQLRequestType = .mutation
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let bookTrips: BookTripsApolloMutation?
  let cancelTrip: CancelTripApolloMutation?
  let login: LoginApolloMutation?
  let uploadProfileImage: UploadProfileImageApolloMutation?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      bookTrips,
      cancelTrip,
      login,
      uploadProfileImage
    ]

    return requests.compactMap { $0 }
  }

  init(
    bookTrips: BookTripsApolloMutation? = nil,
    cancelTrip: CancelTripApolloMutation? = nil,
    login: LoginApolloMutation? = nil,
    uploadProfileImage: UploadProfileImageApolloMutation? = nil
  ) {
    self.bookTrips = bookTrips
    self.cancelTrip = cancelTrip
    self.login = login
    self.uploadProfileImage = uploadProfileImage
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

  func operationArguments() -> String {
    requests
      .map { $0.operationArguments() }
      .joined(separator: "\n")
  }
}

/// TripsBookedApolloSubscription
struct TripsBookedApolloSubscription: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .subscription
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  // MARK: - Operation Definition

  func operationDefinition() -> String {
    return """
    tripsBooked
    """
  }

  func operationArguments() -> String {
    """
    """
  }
}

struct ApolloSubscription: GraphQLRequesting {
  let requestType: GraphQLRequestType = .subscription
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let tripsBooked: TripsBookedApolloSubscription?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      tripsBooked
    ]

    return requests.compactMap { $0 }
  }

  init(
    tripsBooked: TripsBookedApolloSubscription? = nil
  ) {
    self.tripsBooked = tripsBooked
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

  func operationArguments() -> String {
    requests
      .map { $0.operationArguments() }
      .joined(separator: "\n")
  }
}

struct LaunchesQueryResponse: Codable {
  let launches: LaunchConnectionApolloModel
}

struct LaunchQueryResponse: Codable {
  let launch: LaunchApolloModel?
}

struct MeQueryResponse: Codable {
  let me: UserApolloModel?
}

struct TripsBookedQueryResponse: Codable {
  let tripsBooked: Int?
}

struct BookTripsMutationResponse: Codable {
  let bookTrips: TripUpdateResponseApolloModel
}

struct CancelTripMutationResponse: Codable {
  let cancelTrip: TripUpdateResponseApolloModel
}

struct LoginMutationResponse: Codable {
  let login: String?
}

struct UploadProfileImageMutationResponse: Codable {
  let uploadProfileImage: UserApolloModel?
}

struct TripsBookedSubscriptionResponse: Codable {
  let tripsBooked: Int?
}

// MARK: - GraphQLSelection

enum LaunchConnectionSelection: GraphQLSelection {
  static let requiredDeclaration = """
  cursor
  hasMore
  launches
  """
}

enum LaunchSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  id
  isBooked
  """

  case mission = """
  mission {
    ...MissionFragment
  }
  """
  case rocket = """
  rocket {
    ...RocketFragment
  }
  """
  case site
}

enum MissionSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  """

  case missionPatch
  case name
}

enum RocketSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  id
  """

  case name
  case type
}

enum UserSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  email
  id
  trips
  """

  case profileImage
}

enum TripUpdateResponseSelection: String, GraphQLSelection {
  static let requiredDeclaration = """
  success
  """

  case launches = """
  launches {
    ...LaunchFragment
  }
  """
  case message
}

struct ApolloQuerySelections: GraphQLSelections {
  let launch: Set<LaunchSelection>
  let launchConnection: Set<LaunchConnectionSelection>
  let mission: Set<MissionSelection>
  let rocket: Set<RocketSelection>
  let tripUpdateResponse: Set<TripUpdateResponseSelection>
  let user: Set<UserSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    launch: Set<LaunchSelection> = .allFields,
    launchConnection: Set<LaunchConnectionSelection> = .allFields,
    mission: Set<MissionSelection> = .allFields,
    rocket: Set<RocketSelection> = .allFields,
    tripUpdateResponse: Set<TripUpdateResponseSelection> = .allFields,
    user: Set<UserSelection> = .allFields
  ) {
    self.launch = launch
    self.launchConnection = launchConnection
    self.mission = mission
    self.rocket = rocket
    self.tripUpdateResponse = tripUpdateResponse
    self.user = user
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchConnectionDeclaration = """
    fragment LaunchConnectionFragment on LaunchConnection {
    	\(LaunchConnectionSelection.requiredDeclaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launch.declaration)
    }
    """

    let missionDeclaration = """
    fragment MissionFragment on Mission {
    	\(mission.declaration)
    }
    """

    let rocketDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(UserSelection.requiredDeclaration)
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
    	\(TripUpdateResponseSelection.requiredDeclaration)
    	\(tripUpdateResponse.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchConnectionFragment": launchConnectionDeclaration,
      "LaunchFragment": launchDeclaration,
      "MissionFragment": missionDeclaration,
      "RocketFragment": rocketDeclaration,
      "UserFragment": userDeclaration,
      "TripUpdateResponseFragment": tripUpdateResponseDeclaration
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

struct LaunchesApolloQuerySelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>

  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let launchConnectionSelectionsDeclaration = """
    fragment LaunchConnectionFragment on LaunchConnection {
    	\(LaunchConnectionSelection.requiredDeclaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "LaunchConnectionFragment": launchConnectionSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration
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

struct LaunchApolloQuerySelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration
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

struct MeApolloQuerySelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let userSelections: Set<UserSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    userSelections: Set<UserSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.userSelections = userSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let userSelectionsDeclaration = """
    fragment UserFragment on User {
    	\(UserSelection.requiredDeclaration)
    	\(userSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration,
      "UserFragment": userSelectionsDeclaration
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

struct TripsBookedApolloQuerySelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

struct ApolloMutationSelections: GraphQLSelections {
  let launch: Set<LaunchSelection>
  let launchConnection: Set<LaunchConnectionSelection>
  let mission: Set<MissionSelection>
  let rocket: Set<RocketSelection>
  let tripUpdateResponse: Set<TripUpdateResponseSelection>
  let user: Set<UserSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    launch: Set<LaunchSelection> = .allFields,
    launchConnection: Set<LaunchConnectionSelection> = .allFields,
    mission: Set<MissionSelection> = .allFields,
    rocket: Set<RocketSelection> = .allFields,
    tripUpdateResponse: Set<TripUpdateResponseSelection> = .allFields,
    user: Set<UserSelection> = .allFields
  ) {
    self.launch = launch
    self.launchConnection = launchConnection
    self.mission = mission
    self.rocket = rocket
    self.tripUpdateResponse = tripUpdateResponse
    self.user = user
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchConnectionDeclaration = """
    fragment LaunchConnectionFragment on LaunchConnection {
    	\(LaunchConnectionSelection.requiredDeclaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launch.declaration)
    }
    """

    let missionDeclaration = """
    fragment MissionFragment on Mission {
    	\(mission.declaration)
    }
    """

    let rocketDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(UserSelection.requiredDeclaration)
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
    	\(TripUpdateResponseSelection.requiredDeclaration)
    	\(tripUpdateResponse.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchConnectionFragment": launchConnectionDeclaration,
      "LaunchFragment": launchDeclaration,
      "MissionFragment": missionDeclaration,
      "RocketFragment": rocketDeclaration,
      "UserFragment": userDeclaration,
      "TripUpdateResponseFragment": tripUpdateResponseDeclaration
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

struct BookTripsApolloMutationSelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let tripUpdateResponseSelections: Set<TripUpdateResponseSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    tripUpdateResponseSelections: Set<TripUpdateResponseSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.tripUpdateResponseSelections = tripUpdateResponseSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let tripUpdateResponseSelectionsDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
    	\(TripUpdateResponseSelection.requiredDeclaration)
    	\(tripUpdateResponseSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration,
      "TripUpdateResponseFragment": tripUpdateResponseSelectionsDeclaration
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

struct CancelTripApolloMutationSelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let tripUpdateResponseSelections: Set<TripUpdateResponseSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    tripUpdateResponseSelections: Set<TripUpdateResponseSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.tripUpdateResponseSelections = tripUpdateResponseSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let tripUpdateResponseSelectionsDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
    	\(TripUpdateResponseSelection.requiredDeclaration)
    	\(tripUpdateResponseSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration,
      "TripUpdateResponseFragment": tripUpdateResponseSelectionsDeclaration
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

struct LoginApolloMutationSelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}

// MARK: - Selections

struct UploadProfileImageApolloMutationSelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let userSelections: Set<UserSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    userSelections: Set<UserSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.userSelections = userSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(MissionSelection.requiredDeclaration)
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocketSelections.declaration)
    }
    """

    let userSelectionsDeclaration = """
    fragment UserFragment on User {
    	\(UserSelection.requiredDeclaration)
    	\(userSelections.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchFragment": launchSelectionsDeclaration,
      "MissionFragment": missionSelectionsDeclaration,
      "RocketFragment": rocketSelectionsDeclaration,
      "UserFragment": userSelectionsDeclaration
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

struct ApolloSubscriptionSelections: GraphQLSelections {
  let launch: Set<LaunchSelection>
  let launchConnection: Set<LaunchConnectionSelection>
  let mission: Set<MissionSelection>
  let rocket: Set<RocketSelection>
  let tripUpdateResponse: Set<TripUpdateResponseSelection>
  let user: Set<UserSelection>

  private let operationDefinitionFormat: String = "%@"

  func operationDefinition(with rootSelectionKeys: Set<String>) -> String {
    String(
      format: operationDefinitionFormat,
      declaration(with: rootSelectionKeys)
    )
  }

  init(
    launch: Set<LaunchSelection> = .allFields,
    launchConnection: Set<LaunchConnectionSelection> = .allFields,
    mission: Set<MissionSelection> = .allFields,
    rocket: Set<RocketSelection> = .allFields,
    tripUpdateResponse: Set<TripUpdateResponseSelection> = .allFields,
    user: Set<UserSelection> = .allFields
  ) {
    self.launch = launch
    self.launchConnection = launchConnection
    self.mission = mission
    self.rocket = rocket
    self.tripUpdateResponse = tripUpdateResponse
    self.user = user
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchConnectionDeclaration = """
    fragment LaunchConnectionFragment on LaunchConnection {
    	\(LaunchConnectionSelection.requiredDeclaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
    	\(LaunchSelection.requiredDeclaration)
    	\(launch.declaration)
    }
    """

    let missionDeclaration = """
    fragment MissionFragment on Mission {
    	\(mission.declaration)
    }
    """

    let rocketDeclaration = """
    fragment RocketFragment on Rocket {
    	\(RocketSelection.requiredDeclaration)
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(UserSelection.requiredDeclaration)
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
    	\(TripUpdateResponseSelection.requiredDeclaration)
    	\(tripUpdateResponse.declaration)
    }
    """

    let selectionDeclarationMap = [
      "LaunchConnectionFragment": launchConnectionDeclaration,
      "LaunchFragment": launchDeclaration,
      "MissionFragment": missionDeclaration,
      "RocketFragment": rocketDeclaration,
      "UserFragment": userDeclaration,
      "TripUpdateResponseFragment": tripUpdateResponseDeclaration
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

struct TripsBookedApolloSubscriptionSelections: GraphQLSelections {
  func declaration(with _: Set<String>) -> String {
    ""
  }
}
