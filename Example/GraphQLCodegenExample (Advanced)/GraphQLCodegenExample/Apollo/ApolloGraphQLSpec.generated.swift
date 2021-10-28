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
  private static let typename = "Query"

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
  private static let typename = "LaunchConnection"

  private let _cursor: Optional<String>
  func cursor() throws -> String {
    guard let value = _cursor else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._cursor.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _hasMore: Optional<Bool>
  func hasMore() throws -> Bool {
    guard let value = _hasMore else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._hasMore.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _launches: Optional<[LaunchApolloModel?]>
  func launches() throws -> [LaunchApolloModel?] {
    guard let value = _launches else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._launches.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _cursor = "cursor"
    case _hasMore = "hasMore"
    case _launches = "launches"
  }
}

struct LaunchApolloModel: Codable {
  private static let typename = "Launch"

  private let _id: Optional<String>
  func id() throws -> String {
    guard let value = _id else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._id.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _isBooked: Optional<Bool>
  func isBooked() throws -> Bool {
    guard let value = _isBooked else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._isBooked.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _mission: Optional<MissionApolloModel?>
  func mission() throws -> MissionApolloModel? {
    guard let value = _mission else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._mission.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _rocket: Optional<RocketApolloModel?>
  func rocket() throws -> RocketApolloModel? {
    guard let value = _rocket else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._rocket.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _site: Optional<String?>
  func site() throws -> String? {
    guard let value = _site else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._site.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _id = "id"
    case _isBooked = "isBooked"
    case _mission = "mission"
    case _rocket = "rocket"
    case _site = "site"
  }
}

struct MissionApolloModel: Codable {
  private static let typename = "Mission"

  private let _missionPatch: Optional<String?>
  func missionPatch() throws -> String? {
    guard let value = _missionPatch else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._missionPatch.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _name: Optional<String?>
  func name() throws -> String? {
    guard let value = _name else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._name.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _missionPatch = "missionPatch"
    case _name = "name"
  }
}

struct RocketApolloModel: Codable {
  private static let typename = "Rocket"

  private let _id: Optional<String>
  func id() throws -> String {
    guard let value = _id else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._id.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _name: Optional<String?>
  func name() throws -> String? {
    guard let value = _name else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._name.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _type: Optional<String?>
  func type() throws -> String? {
    guard let value = _type else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._type.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _id = "id"
    case _name = "name"
    case _type = "type"
  }
}

struct UserApolloModel: Codable {
  private static let typename = "User"

  private let _email: Optional<String>
  func email() throws -> String {
    guard let value = _email else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._email.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _id: Optional<String>
  func id() throws -> String {
    guard let value = _id else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._id.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _profileImage: Optional<String?>
  func profileImage() throws -> String? {
    guard let value = _profileImage else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._profileImage.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _trips: Optional<[LaunchApolloModel?]>
  func trips() throws -> [LaunchApolloModel?] {
    guard let value = _trips else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._trips.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _email = "email"
    case _id = "id"
    case _profileImage = "profileImage"
    case _trips = "trips"
  }
}

struct MutationApolloModel: Codable {
  private static let typename = "Mutation"

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
  private static let typename = "TripUpdateResponse"

  private let _launches: Optional<[LaunchApolloModel?]?>
  func launches() throws -> [LaunchApolloModel?]? {
    guard let value = _launches else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._launches.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _message: Optional<String?>
  func message() throws -> String? {
    guard let value = _message else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._message.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  private let _success: Optional<Bool>
  func success() throws -> Bool {
    guard let value = _success else {
      throw GraphQLResponseError.missingSelection(
        key: CodingKeys._success.rawValue,
        type: Self.typename
      )
    }

    return value
  }

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case _launches = "launches"
    case _message = "message"
    case _success = "success"
  }
}

struct SubscriptionApolloModel: Codable {
  private static let typename = "Subscription"

  let tripsBooked: Optional<Int?>

  // MARK: - CodingKeys

  private enum CodingKeys: String, CodingKey {
    case tripsBooked
  }
}

// MARK: - GraphQLRequesting

/// LaunchApolloQuery
struct LaunchApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["LaunchFragment"]

  // MARK: - Arguments

  let id: String

  let launchMissionPatchSize: PatchSizeApolloEnumModel?

  private enum CodingKeys: String, CodingKey {
    case id = "launchId"

    case launchMissionPatchSize
  }

  init(
    id: String,
    launchMissionPatchSize: PatchSizeApolloEnumModel?
  ) {
    self.id = id
    self.launchMissionPatchSize = launchMissionPatchSize
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

  let launchesMissionPatchSize: PatchSizeApolloEnumModel?

  private enum CodingKeys: String, CodingKey {
    /// The number of results to show. Must be >= 1. Default = 20
    case pageSize = "launchesPageSize"
    /// If you add a cursor here, it will only return results _after_ this cursor
    case after = "launchesAfter"

    case launchesMissionPatchSize
  }

  init(
    after: String?,
    launchesMissionPatchSize: PatchSizeApolloEnumModel?,
    pageSize: Int?
  ) {
    self.after = after
    self.launchesMissionPatchSize = launchesMissionPatchSize
    self.pageSize = pageSize
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

/// MeApolloQuery
struct MeApolloQuery: GraphQLRequesting {
  // MARK: - GraphQLRequestType

  let requestType: GraphQLRequestType = .query
  let rootSelectionKeys: Set<String> = ["UserFragment"]

  // MARK: - Arguments

  let meMissionPatchSize: PatchSizeApolloEnumModel?

  func encode(to _: Encoder) throws {}

  init(
    meMissionPatchSize: PatchSizeApolloEnumModel?
  ) {
    self.meMissionPatchSize = meMissionPatchSize
  }

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

  let launch: LaunchApolloQuery?
  let launches: LaunchesApolloQuery?
  let me: MeApolloQuery?
  let tripsBooked: TripsBookedApolloQuery?

  private var requests: [GraphQLRequesting] {
    let requests: [GraphQLRequesting?] = [
      launch,
      launches,
      me,
      tripsBooked
    ]

    return requests.compactMap { $0 }
  }

  init(
    launch: LaunchApolloQuery? = nil,
    launches: LaunchesApolloQuery? = nil,
    me: MeApolloQuery? = nil,
    tripsBooked: TripsBookedApolloQuery? = nil
  ) {
    self.launch = launch
    self.launches = launches
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

  let bookTripsMissionPatchSize: PatchSizeApolloEnumModel?

  private enum CodingKeys: String, CodingKey {
    case launchIds = "bookTripsLaunchIds"

    case bookTripsMissionPatchSize
  }

  init(
    bookTripsMissionPatchSize: PatchSizeApolloEnumModel?,
    launchIds: [String?]
  ) {
    self.bookTripsMissionPatchSize = bookTripsMissionPatchSize
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

  let cancelTripMissionPatchSize: PatchSizeApolloEnumModel?

  private enum CodingKeys: String, CodingKey {
    case launchId = "cancelTripLaunchId"

    case cancelTripMissionPatchSize
  }

  init(
    cancelTripMissionPatchSize: PatchSizeApolloEnumModel?,
    launchId: String
  ) {
    self.cancelTripMissionPatchSize = cancelTripMissionPatchSize
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

  let uploadProfileImageMissionPatchSize: PatchSizeApolloEnumModel?

  let file: String

  private enum CodingKeys: String, CodingKey {
    case uploadProfileImageMissionPatchSize

    case file = "uploadProfileImageFile"
  }

  init(
    file: String,
    uploadProfileImageMissionPatchSize: PatchSizeApolloEnumModel?
  ) {
    self.file = file
    self.uploadProfileImageMissionPatchSize = uploadProfileImageMissionPatchSize
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

struct LaunchQueryResponse: Codable {
  let launch: LaunchApolloModel?
}

struct LaunchesQueryResponse: Codable {
  let launches: LaunchConnectionApolloModel
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

enum LaunchConnectionSelection: String, GraphQLSelection {
  case cursor
  case hasMore
  case launches = """
  launches {
    ...LaunchFragment
  }
  """
}

enum LaunchSelection: String, GraphQLSelection {
  case id
  case isBooked
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
  case missionPatch
  case name
}

enum RocketSelection: String, GraphQLSelection {
  case id
  case name
  case type
}

enum UserSelection: String, GraphQLSelection {
  case email
  case id
  case profileImage
  case trips = """
  trips {
    ...LaunchFragment
  }
  """
}

enum TripUpdateResponseSelection: String, GraphQLSelection {
  case launches = """
  launches {
    ...LaunchFragment
  }
  """
  case message
  case success
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
    	\(launchConnection.declaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
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
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
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
  let launchConnectionSelections: Set<LaunchConnectionSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    launchConnectionSelections: Set<LaunchConnectionSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.launchConnectionSelections = launchConnectionSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
  }

  func declaration(with rootSelectionKeys: Set<String>) -> String {
    let launchSelectionsDeclaration = """
    fragment LaunchFragment on Launch {
    	\(launchSelections.declaration)
    }
    """

    let launchConnectionSelectionsDeclaration = """
    fragment LaunchConnectionFragment on LaunchConnection {
    	\(launchConnectionSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
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
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
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
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(rocketSelections.declaration)
    }
    """

    let userSelectionsDeclaration = """
    fragment UserFragment on User {
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
    	\(launchConnection.declaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
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
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
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
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(rocketSelections.declaration)
    }
    """

    let tripUpdateResponseSelectionsDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
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
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(rocketSelections.declaration)
    }
    """

    let tripUpdateResponseSelectionsDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
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
    	\(launchSelections.declaration)
    }
    """

    let missionSelectionsDeclaration = """
    fragment MissionFragment on Mission {
    	\(missionSelections.declaration)
    }
    """

    let rocketSelectionsDeclaration = """
    fragment RocketFragment on Rocket {
    	\(rocketSelections.declaration)
    }
    """

    let userSelectionsDeclaration = """
    fragment UserFragment on User {
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
    	\(launchConnection.declaration)
    }
    """

    let launchDeclaration = """
    fragment LaunchFragment on Launch {
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
    	\(rocket.declaration)
    }
    """

    let userDeclaration = """
    fragment UserFragment on User {
    	\(user.declaration)
    }
    """

    let tripUpdateResponseDeclaration = """
    fragment TripUpdateResponseFragment on TripUpdateResponse {
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
