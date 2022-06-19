// @generated
// Do not edit this generated file
// swiftlint:disable all
// swiftformat:disable all

import Foundation
// MARK: - ApolloEnumModel

/// PatchSize
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

// MARK: - ApolloModel

struct LaunchApolloModel: Decodable {
  private let internalId: Optional<String>
  private let internalIsBooked: Optional<Bool>
  private let internalMission: Optional<MissionApolloModel?>
  private let internalRocket: Optional<RocketApolloModel?>
  private let internalSite: Optional<String?>

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  func isBooked() throws -> Bool {
    try value(for: \Self.internalIsBooked, codingKey: CodingKeys.internalIsBooked)
  }

  func mission() throws -> MissionApolloModel? {
    try value(for: \Self.internalMission, codingKey: CodingKeys.internalMission)
  }

  func rocket() throws -> RocketApolloModel? {
    try value(for: \Self.internalRocket, codingKey: CodingKeys.internalRocket)
  }

  func site() throws -> String? {
    try value(for: \Self.internalSite, codingKey: CodingKeys.internalSite)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
    internalIsBooked = try container.decodeOptionalIfPresent(Bool.self, forKey: .internalIsBooked)
    internalMission = try container.decodeOptionalIfPresent(MissionApolloModel?.self, forKey: .internalMission)
    internalRocket = try container.decodeOptionalIfPresent(RocketApolloModel?.self, forKey: .internalRocket)
    internalSite = try container.decodeOptionalIfPresent(String?.self, forKey: .internalSite)
  }

  private enum CodingKeys: String, CodingKey {
    case internalId = "id"
    case internalIsBooked = "isBooked"
    case internalMission = "mission"
    case internalRocket = "rocket"
    case internalSite = "site"
  }
}

struct LaunchConnectionApolloModel: Decodable {
  private let internalCursor: Optional<String>
  private let internalHasMore: Optional<Bool>
  private let internalLaunches: Optional<[LaunchApolloModel?]>

  func cursor() throws -> String {
    try value(for: \Self.internalCursor, codingKey: CodingKeys.internalCursor)
  }

  func hasMore() throws -> Bool {
    try value(for: \Self.internalHasMore, codingKey: CodingKeys.internalHasMore)
  }

  func launches() throws -> [LaunchApolloModel?] {
    try value(for: \Self.internalLaunches, codingKey: CodingKeys.internalLaunches)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalCursor = try container.decodeOptionalIfPresent(String.self, forKey: .internalCursor)
    internalHasMore = try container.decodeOptionalIfPresent(Bool.self, forKey: .internalHasMore)
    internalLaunches = try container.decodeOptionalIfPresent([LaunchApolloModel?].self, forKey: .internalLaunches)
  }

  private enum CodingKeys: String, CodingKey {
    case internalCursor = "cursor"
    case internalHasMore = "hasMore"
    case internalLaunches = "launches"
  }
}

struct MissionApolloModel: Decodable {
  private let internalMissionPatch: Optional<String?>
  private let internalName: Optional<String?>

  func missionPatch() throws -> String? {
    try value(for: \Self.internalMissionPatch, codingKey: CodingKeys.internalMissionPatch)
  }

  func name() throws -> String? {
    try value(for: \Self.internalName, codingKey: CodingKeys.internalName)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalMissionPatch = try container.decodeOptionalIfPresent(String?.self, forKey: .internalMissionPatch)
    internalName = try container.decodeOptionalIfPresent(String?.self, forKey: .internalName)
  }

  private enum CodingKeys: String, CodingKey {
    case internalMissionPatch = "missionPatch"
    case internalName = "name"
  }
}

struct MutationApolloModel: Decodable {
  let bookTrips: Optional<TripUpdateResponseApolloModel>
  let cancelTrip: Optional<TripUpdateResponseApolloModel>
  let login: Optional<UserApolloModel?>

  private enum CodingKeys: String, CodingKey {
    case bookTrips
    case cancelTrip
    case login
  }
}

struct QueryApolloModel: Decodable {
  let launch: Optional<LaunchApolloModel?>
  let launches: Optional<LaunchConnectionApolloModel>
  let me: Optional<UserApolloModel?>
  let totalTripsBooked: Optional<Int?>

  private enum CodingKeys: String, CodingKey {
    case launch
    case launches
    case me
    case totalTripsBooked
  }
}

struct RocketApolloModel: Decodable {
  private let internalId: Optional<String>
  private let internalName: Optional<String?>
  private let internalType: Optional<String?>

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  func name() throws -> String? {
    try value(for: \Self.internalName, codingKey: CodingKeys.internalName)
  }

  func type() throws -> String? {
    try value(for: \Self.internalType, codingKey: CodingKeys.internalType)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
    internalName = try container.decodeOptionalIfPresent(String?.self, forKey: .internalName)
    internalType = try container.decodeOptionalIfPresent(String?.self, forKey: .internalType)
  }

  private enum CodingKeys: String, CodingKey {
    case internalId = "id"
    case internalName = "name"
    case internalType = "type"
  }
}

struct SubscriptionApolloModel: Decodable {
  let tripsBooked: Optional<Int?>

  private enum CodingKeys: String, CodingKey {
    case tripsBooked
  }
}

struct TripUpdateResponseApolloModel: Decodable {
  private let internalLaunches: Optional<[LaunchApolloModel?]?>
  private let internalMessage: Optional<String?>
  private let internalSuccess: Optional<Bool>

  func launches() throws -> [LaunchApolloModel?]? {
    try value(for: \Self.internalLaunches, codingKey: CodingKeys.internalLaunches)
  }

  func message() throws -> String? {
    try value(for: \Self.internalMessage, codingKey: CodingKeys.internalMessage)
  }

  func success() throws -> Bool {
    try value(for: \Self.internalSuccess, codingKey: CodingKeys.internalSuccess)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalLaunches = try container.decodeOptionalIfPresent([LaunchApolloModel?]?.self, forKey: .internalLaunches)
    internalMessage = try container.decodeOptionalIfPresent(String?.self, forKey: .internalMessage)
    internalSuccess = try container.decodeOptionalIfPresent(Bool.self, forKey: .internalSuccess)
  }

  private enum CodingKeys: String, CodingKey {
    case internalLaunches = "launches"
    case internalMessage = "message"
    case internalSuccess = "success"
  }
}

struct UserApolloModel: Decodable {
  private let internalEmail: Optional<String>
  private let internalId: Optional<String>
  private let internalProfileImage: Optional<String?>
  private let internalToken: Optional<String?>
  private let internalTrips: Optional<[LaunchApolloModel?]>

  func email() throws -> String {
    try value(for: \Self.internalEmail, codingKey: CodingKeys.internalEmail)
  }

  func id() throws -> String {
    try value(for: \Self.internalId, codingKey: CodingKeys.internalId)
  }

  func profileImage() throws -> String? {
    try value(for: \Self.internalProfileImage, codingKey: CodingKeys.internalProfileImage)
  }

  func token() throws -> String? {
    try value(for: \Self.internalToken, codingKey: CodingKeys.internalToken)
  }

  func trips() throws -> [LaunchApolloModel?] {
    try value(for: \Self.internalTrips, codingKey: CodingKeys.internalTrips)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    internalEmail = try container.decodeOptionalIfPresent(String.self, forKey: .internalEmail)
    internalId = try container.decodeOptionalIfPresent(String.self, forKey: .internalId)
    internalProfileImage = try container.decodeOptionalIfPresent(String?.self, forKey: .internalProfileImage)
    internalToken = try container.decodeOptionalIfPresent(String?.self, forKey: .internalToken)
    internalTrips = try container.decodeOptionalIfPresent([LaunchApolloModel?].self, forKey: .internalTrips)
  }

  private enum CodingKeys: String, CodingKey {
    case internalEmail = "email"
    case internalId = "id"
    case internalProfileImage = "profileImage"
    case internalToken = "token"
    case internalTrips = "trips"
  }
}




// MARK: - GraphQLRequestParameter

/// TotalTripsBookedApolloQuery
struct TotalTripsBookedApolloQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "totalTripsBooked"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    totalTripsBooked
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

/// LaunchApolloQuery
struct LaunchApolloQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "launch"
  let rootSelectionKeys: Set<String> = ["LaunchLaunchFragment"]

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

  let requestQuery: String = {
    """
    launch(
      id: $launchId
    ) {
       ...LaunchLaunchFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$launchId", "$launchId: ID!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$launchMissionPatchSize", "$launchMissionPatchSize: PatchSize")
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

/// LaunchesApolloQuery
struct LaunchesApolloQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "launches"
  let rootSelectionKeys: Set<String> = ["LaunchesLaunchConnectionFragment"]

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

  let requestQuery: String = {
    """
    launches(
      pageSize: $launchesPageSize
      after: $launchesAfter
    ) {
       ...LaunchesLaunchConnectionFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$launchesPageSize", "$launchesPageSize: Int"),
    ("$launchesAfter", "$launchesAfter: String")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$launchesMissionPatchSize", "$launchesMissionPatchSize: PatchSize")
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

/// MeApolloQuery
struct MeApolloQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = "me"
  let rootSelectionKeys: Set<String> = ["MeUserFragment"]

  let meMissionPatchSize: PatchSizeApolloEnumModel?

  func encode(to _: Encoder) throws {}

  init(
    meMissionPatchSize: PatchSizeApolloEnumModel?
  ) {
    self.meMissionPatchSize = meMissionPatchSize
  }

  let requestQuery: String = {
    """
    me {
       ...MeUserFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$meMissionPatchSize", "$meMissionPatchSize: PatchSize")
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

struct ApolloQuery: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .query
  let requestName: String = ""
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
  let totalTripsBooked: TotalTripsBookedApolloQuery?

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
      launch,
      launches,
      me,
      totalTripsBooked
    ]

    return requests.compactMap { $0 }
  }

  init(
    launch: LaunchApolloQuery? = nil,
    launches: LaunchesApolloQuery? = nil,
    me: MeApolloQuery? = nil,
    totalTripsBooked: TotalTripsBookedApolloQuery? = nil
  ) {
    self.launch = launch
    self.launches = launches
    self.me = me
    self.totalTripsBooked = totalTripsBooked
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

/// BookTripsApolloMutation
struct BookTripsApolloMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = "bookTrips"
  let rootSelectionKeys: Set<String> = ["BookTripsTripUpdateResponseFragment"]

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

  let requestQuery: String = {
    """
    bookTrips(
      launchIds: $bookTripsLaunchIds
    ) {
       ...BookTripsTripUpdateResponseFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$bookTripsLaunchIds", "$bookTripsLaunchIds: [ID]!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$bookTripsMissionPatchSize", "$bookTripsMissionPatchSize: PatchSize")
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

/// CancelTripApolloMutation
struct CancelTripApolloMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = "cancelTrip"
  let rootSelectionKeys: Set<String> = ["CancelTripTripUpdateResponseFragment"]

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

  let requestQuery: String = {
    """
    cancelTrip(
      launchId: $cancelTripLaunchId
    ) {
       ...CancelTripTripUpdateResponseFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$cancelTripLaunchId", "$cancelTripLaunchId: ID!")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$cancelTripMissionPatchSize", "$cancelTripMissionPatchSize: PatchSize")
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

/// LoginApolloMutation
struct LoginApolloMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = "login"
  let rootSelectionKeys: Set<String> = ["LoginUserFragment"]

  let email: String?
  let loginMissionPatchSize: PatchSizeApolloEnumModel?

  private enum CodingKeys: String, CodingKey {
    case email = "loginEmail"

    case loginMissionPatchSize
  }

  init(
    email: String?,
    loginMissionPatchSize: PatchSizeApolloEnumModel?
  ) {
    self.email = email
    self.loginMissionPatchSize = loginMissionPatchSize
  }

  let requestQuery: String = {
    """
    login(
      email: $loginEmail
    ) {
       ...LoginUserFragment
    }
    """
  }()

  let requestArguments: [(key: String, value: String)] = [
    ("$loginEmail", "$loginEmail: String")
  ]

  let subRequestArguments: [(key: String, value: String)] = [
    ("$loginMissionPatchSize", "$loginMissionPatchSize: PatchSize")
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

struct ApolloMutation: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .mutation
  let requestName: String = ""
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

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
      bookTrips,
      cancelTrip,
      login
    ]

    return requests.compactMap { $0 }
  }

  init(
    bookTrips: BookTripsApolloMutation? = nil,
    cancelTrip: CancelTripApolloMutation? = nil,
    login: LoginApolloMutation? = nil
  ) {
    self.bookTrips = bookTrips
    self.cancelTrip = cancelTrip
    self.login = login
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

/// TripsBookedApolloSubscription
struct TripsBookedApolloSubscription: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .subscription
  let requestName: String = "tripsBooked"
  let rootSelectionKeys: Set<String> = []

  func encode(to _: Encoder) throws {}

  init(
  ) {}

  let requestQuery: String = {
    """
    tripsBooked
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

struct ApolloSubscription: GraphQLRequestParameter {
  let requestType: GraphQLRequestType = .subscription
  let requestName: String = ""
  var rootSelectionKeys: Set<String> {
    return requests.reduce(into: Set<String>()) { result, request in
      request.rootSelectionKeys.forEach {
        result.insert($0)
      }
    }
  }

  let tripsBooked: TripsBookedApolloSubscription?

  private var requests: [GraphQLRequestParameter] {
    let requests: [GraphQLRequestParameter?] = [
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

struct LaunchQueryResponse: Decodable {
  let launch: LaunchApolloModel?
}

struct LaunchesQueryResponse: Decodable {
  let launches: LaunchConnectionApolloModel
}

struct MeQueryResponse: Decodable {
  let me: UserApolloModel?
}

struct TotalTripsBookedQueryResponse: Decodable {
  let totalTripsBooked: Int?
}

struct BookTripsMutationResponse: Decodable {
  let bookTrips: TripUpdateResponseApolloModel
}

struct CancelTripMutationResponse: Decodable {
  let cancelTrip: TripUpdateResponseApolloModel
}

struct LoginMutationResponse: Decodable {
  let login: UserApolloModel?
}

struct TripsBookedSubscriptionResponse: Decodable {
  let tripsBooked: Int?
}

// MARK: - GraphQLSelection

enum LaunchSelection: String, GraphQLSelection {
  case id
  case isBooked
  case mission = """
  mission {
    ...%@MissionFragment
  }
  """
  case rocket = """
  rocket {
    ...%@RocketFragment
  }
  """
  case site
}

enum LaunchConnectionSelection: String, GraphQLSelection {
  case cursor
  case hasMore
  case launches = """
  launches {
    ...%@LaunchFragment
  }
  """
}

enum MissionSelection: String, GraphQLSelection {
  case missionPatch = """
  missionPatch(
    size: $%@MissionPatchSize
  )
  """
  case name
}

enum RocketSelection: String, GraphQLSelection {
  case id
  case name
  case type
}

enum TripUpdateResponseSelection: String, GraphQLSelection {
  case launches = """
  launches {
    ...%@LaunchFragment
  }
  """
  case message
  case success
}

enum UserSelection: String, GraphQLSelection {
  case email
  case id
  case profileImage
  case token
  case trips = """
  trips {
    ...%@LaunchFragment
  }
  """
}

// MARK: - Selections

struct ApolloQuerySelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let launchConnectionSelections: Set<LaunchConnectionSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let tripUpdateResponseSelections: Set<TripUpdateResponseSelection>
  let userSelections: Set<UserSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    launchConnectionSelections: Set<LaunchConnectionSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    tripUpdateResponseSelections: Set<TripUpdateResponseSelection> = .allFields,
    userSelections: Set<UserSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.launchConnectionSelections = launchConnectionSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.tripUpdateResponseSelections = tripUpdateResponseSelections
    self.userSelections = userSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        launchConnectionSelections.requestFragment(requestName: requestName, typeName: "LaunchConnection"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        tripUpdateResponseSelections.requestFragment(requestName: requestName, typeName: "TripUpdateResponse"),
        userSelections.requestFragment(requestName: requestName, typeName: "User")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        launchConnectionSelections.requestFragment(requestName: requestName, typeName: "LaunchConnection"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        userSelections.requestFragment(requestName: requestName, typeName: "User")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct TotalTripsBookedApolloQuerySelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}

struct ApolloMutationSelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let launchConnectionSelections: Set<LaunchConnectionSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let tripUpdateResponseSelections: Set<TripUpdateResponseSelection>
  let userSelections: Set<UserSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    launchConnectionSelections: Set<LaunchConnectionSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    tripUpdateResponseSelections: Set<TripUpdateResponseSelection> = .allFields,
    userSelections: Set<UserSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.launchConnectionSelections = launchConnectionSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.tripUpdateResponseSelections = tripUpdateResponseSelections
    self.userSelections = userSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        launchConnectionSelections.requestFragment(requestName: requestName, typeName: "LaunchConnection"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        tripUpdateResponseSelections.requestFragment(requestName: requestName, typeName: "TripUpdateResponse"),
        userSelections.requestFragment(requestName: requestName, typeName: "User")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        tripUpdateResponseSelections.requestFragment(requestName: requestName, typeName: "TripUpdateResponse")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        tripUpdateResponseSelections.requestFragment(requestName: requestName, typeName: "TripUpdateResponse")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct LoginApolloMutationSelections: GraphQLSelections {
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

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        userSelections.requestFragment(requestName: requestName, typeName: "User")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct ApolloSubscriptionSelections: GraphQLSelections {
  let launchSelections: Set<LaunchSelection>
  let launchConnectionSelections: Set<LaunchConnectionSelection>
  let missionSelections: Set<MissionSelection>
  let rocketSelections: Set<RocketSelection>
  let tripUpdateResponseSelections: Set<TripUpdateResponseSelection>
  let userSelections: Set<UserSelection>

  init(
    launchSelections: Set<LaunchSelection> = .allFields,
    launchConnectionSelections: Set<LaunchConnectionSelection> = .allFields,
    missionSelections: Set<MissionSelection> = .allFields,
    rocketSelections: Set<RocketSelection> = .allFields,
    tripUpdateResponseSelections: Set<TripUpdateResponseSelection> = .allFields,
    userSelections: Set<UserSelection> = .allFields
  ) {
    self.launchSelections = launchSelections
    self.launchConnectionSelections = launchConnectionSelections
    self.missionSelections = missionSelections
    self.rocketSelections = rocketSelections
    self.tripUpdateResponseSelections = tripUpdateResponseSelections
    self.userSelections = userSelections
  }

  func requestFragments(for requestName: String, rootSelectionKeys: Set<String>) -> String {
    let requestName = requestName.prefix(1).uppercased() + requestName.dropFirst()

    let selectionDeclarationMap = Dictionary(
      uniqueKeysWithValues: [
        launchSelections.requestFragment(requestName: requestName, typeName: "Launch"),
        launchConnectionSelections.requestFragment(requestName: requestName, typeName: "LaunchConnection"),
        missionSelections.requestFragment(requestName: requestName, typeName: "Mission"),
        rocketSelections.requestFragment(requestName: requestName, typeName: "Rocket"),
        tripUpdateResponseSelections.requestFragment(requestName: requestName, typeName: "TripUpdateResponse"),
        userSelections.requestFragment(requestName: requestName, typeName: "User")
      ].map { ($0.key, $0.value) }
    )

    let fragments = nestedRequestFragments(
      selectionDeclarationMap: selectionDeclarationMap,
      rootSelectionKeys: rootSelectionKeys
    )

    return fragments.joined(separator: "\n\n")
  }
}

struct TripsBookedApolloSubscriptionSelections: GraphQLSelections {
  func requestFragments(for _: String, rootSelectionKeys _: Set<String>) -> String {
    ""
  }
}