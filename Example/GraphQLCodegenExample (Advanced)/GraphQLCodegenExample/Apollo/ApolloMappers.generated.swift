// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

// MARK: - Primitive Selection Mock

private extension Bool {
  static func selectionMock() -> Self { false }
}

private extension Double {
  static func selectionMock() -> Self { 0 }
}

private extension Int {
  static func selectionMock() -> Self { 0 }
}

private extension String {
  static func selectionMock() -> Self { "" }
}

// MARK: - Extensions

private extension Optional {
  func unwrapOrFail(context: String = "") throws -> Wrapped {
    guard let value = self else {
      throw GroceriesMapperError.missingData(context: context)
    }

    return value
  }
}

// MARK: - MapperError

enum ApolloMapperError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

// MARK: - SelectionMock

extension PatchSizeApolloEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension CacheControlScopeApolloEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension QueryApolloModel {
  static func selectionMock() -> Self {
    QueryApolloModel(
      launch: .selectionMock(),
      launches: .selectionMock(),
      me: .selectionMock(),
      tripsBooked: .selectionMock()
    )
  }
}

extension LaunchConnectionApolloModel {
  static func selectionMock() -> Self {
    LaunchConnectionApolloModel(
      cursor: .selectionMock(),
      hasMore: .selectionMock(),
      launches: [.selectionMock()]
    )
  }
}

extension LaunchApolloModel {
  static func selectionMock() -> Self {
    LaunchApolloModel(
      id: .selectionMock(),
      isBooked: .selectionMock(),
      mission: .selectionMock(),
      rocket: .selectionMock(),
      site: .selectionMock()
    )
  }
}

extension MissionApolloModel {
  static func selectionMock() -> Self {
    MissionApolloModel(
      missionPatch: .selectionMock(),
      name: .selectionMock()
    )
  }
}

extension RocketApolloModel {
  static func selectionMock() -> Self {
    RocketApolloModel(
      id: .selectionMock(),
      name: .selectionMock(),
      type: .selectionMock()
    )
  }
}

extension UserApolloModel {
  static func selectionMock() -> Self {
    UserApolloModel(
      email: .selectionMock(),
      id: .selectionMock(),
      profileImage: .selectionMock(),
      trips: [.selectionMock()]
    )
  }
}

extension MutationApolloModel {
  static func selectionMock() -> Self {
    MutationApolloModel(
      bookTrips: .selectionMock(),
      cancelTrip: .selectionMock(),
      login: .selectionMock(),
      uploadProfileImage: .selectionMock()
    )
  }
}

extension TripUpdateResponseApolloModel {
  static func selectionMock() -> Self {
    TripUpdateResponseApolloModel(
      launches: [.selectionMock()],
      message: .selectionMock(),
      success: .selectionMock()
    )
  }
}

extension SubscriptionApolloModel {
  static func selectionMock() -> Self {
    SubscriptionApolloModel(
      tripsBooked: .selectionMock()
    )
  }
}

// MARK: - SelectionDecoder

class LaunchesQuerySelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var launchConnectionSelections = Set<LaunchConnectionSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchConnectionApolloModel
  private let populateSelections: Bool

  init(response: LaunchConnectionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func cursor() throws -> String {
    insert(selection: .cursor)

    let value = try response.cursor.unwrapOrFail(context: "cursor not found")

    return value
  }

  func hasMore() throws -> Bool {
    insert(selection: .hasMore)

    let value = try response.hasMore.unwrapOrFail(context: "hasMore not found")

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    insert(selection: .launches)

    let values = try response.launches.unwrapOrFail(context: "launches not found")

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        launchSelections = decoder.launchSelections
        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections

        return result
      } else {
        return nil
      }
    }
  }

  private func insert(selection: LaunchConnectionSelection) {
    if populateSelections {
      launchConnectionSelections.insert(selection)
    }
  }
}

class LaunchQuerySelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchApolloModel
  private let populateSelections: Bool

  init(response: LaunchApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func isBooked() throws -> Bool {
    insert(selection: .isBooked)

    let value = try response.isBooked.unwrapOrFail(context: "isBooked not found")

    return value
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    insert(selection: .mission)

    let value = try response.mission.unwrapOrFail(context: "mission not found")

    if let value = value {
      let decoder = MissionSelectionDecoder(
        response: value,
        populateSelections: populateSelections
      )
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    insert(selection: .rocket)

    let value = try response.rocket.unwrapOrFail(context: "rocket not found")

    if let value = value {
      let decoder = RocketSelectionDecoder(
        response: value,
        populateSelections: populateSelections
      )
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func site() throws -> String? {
    insert(selection: .site)

    let value = try response.site.unwrapOrFail(context: "site not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  private func insert(selection: LaunchSelection) {
    if populateSelections {
      launchSelections.insert(selection)
    }
  }
}

class MeQuerySelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var userSelections = Set<UserSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func email() throws -> String {
    insert(selection: .email)

    let value = try response.email.unwrapOrFail(context: "email not found")

    return value
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func profileImage() throws -> String? {
    insert(selection: .profileImage)

    let value = try response.profileImage.unwrapOrFail(context: "profileImage not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    insert(selection: .trips)

    let values = try response.trips.unwrapOrFail(context: "trips not found")

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }

  private func insert(selection: UserSelection) {
    if populateSelections {
      userSelections.insert(selection)
    }
  }
}

class BookTripsMutationSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .launches)

    let values = try response.launches.unwrapOrFail(context: "launches not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }

  func message() throws -> String? {
    insert(selection: .message)

    let value = try response.message.unwrapOrFail(context: "message not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func success() throws -> Bool {
    insert(selection: .success)

    let value = try response.success.unwrapOrFail(context: "success not found")

    return value
  }

  private func insert(selection: TripUpdateResponseSelection) {
    if populateSelections {
      tripUpdateResponseSelections.insert(selection)
    }
  }
}

class CancelTripMutationSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .launches)

    let values = try response.launches.unwrapOrFail(context: "launches not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }

  func message() throws -> String? {
    insert(selection: .message)

    let value = try response.message.unwrapOrFail(context: "message not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func success() throws -> Bool {
    insert(selection: .success)

    let value = try response.success.unwrapOrFail(context: "success not found")

    return value
  }

  private func insert(selection: TripUpdateResponseSelection) {
    if populateSelections {
      tripUpdateResponseSelections.insert(selection)
    }
  }
}

class UploadProfileImageMutationSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var userSelections = Set<UserSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func email() throws -> String {
    insert(selection: .email)

    let value = try response.email.unwrapOrFail(context: "email not found")

    return value
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func profileImage() throws -> String? {
    insert(selection: .profileImage)

    let value = try response.profileImage.unwrapOrFail(context: "profileImage not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    insert(selection: .trips)

    let values = try response.trips.unwrapOrFail(context: "trips not found")

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }

  private func insert(selection: UserSelection) {
    if populateSelections {
      userSelections.insert(selection)
    }
  }
}

class LaunchConnectionSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var launchConnectionSelections = Set<LaunchConnectionSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchConnectionApolloModel
  private let populateSelections: Bool

  init(response: LaunchConnectionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func cursor() throws -> String {
    insert(selection: .cursor)

    let value = try response.cursor.unwrapOrFail(context: "cursor not found")

    return value
  }

  func hasMore() throws -> Bool {
    insert(selection: .hasMore)

    let value = try response.hasMore.unwrapOrFail(context: "hasMore not found")

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    insert(selection: .launches)

    let values = try response.launches.unwrapOrFail(context: "launches not found")

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        launchSelections = decoder.launchSelections
        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections

        return result
      } else {
        return nil
      }
    }
  }

  private func insert(selection: LaunchConnectionSelection) {
    if populateSelections {
      launchConnectionSelections.insert(selection)
    }
  }
}

class LaunchSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: LaunchApolloModel
  private let populateSelections: Bool

  init(response: LaunchApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func isBooked() throws -> Bool {
    insert(selection: .isBooked)

    let value = try response.isBooked.unwrapOrFail(context: "isBooked not found")

    return value
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    insert(selection: .mission)

    let value = try response.mission.unwrapOrFail(context: "mission not found")

    if let value = value {
      let decoder = MissionSelectionDecoder(
        response: value,
        populateSelections: populateSelections
      )
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    insert(selection: .rocket)

    let value = try response.rocket.unwrapOrFail(context: "rocket not found")

    if let value = value {
      let decoder = RocketSelectionDecoder(
        response: value,
        populateSelections: populateSelections
      )
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func site() throws -> String? {
    insert(selection: .site)

    let value = try response.site.unwrapOrFail(context: "site not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  private func insert(selection: LaunchSelection) {
    if populateSelections {
      launchSelections.insert(selection)
    }
  }
}

class MissionSelectionDecoder {
  private(set) var missionSelections = Set<MissionSelection>()
  private let response: MissionApolloModel
  private let populateSelections: Bool

  init(response: MissionApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func missionPatch() throws -> String? {
    insert(selection: .missionPatch)

    let value = try response.missionPatch.unwrapOrFail(context: "missionPatch not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func name() throws -> String? {
    insert(selection: .name)

    let value = try response.name.unwrapOrFail(context: "name not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  private func insert(selection: MissionSelection) {
    if populateSelections {
      missionSelections.insert(selection)
    }
  }
}

class RocketSelectionDecoder {
  private(set) var rocketSelections = Set<RocketSelection>()
  private let response: RocketApolloModel
  private let populateSelections: Bool

  init(response: RocketApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func name() throws -> String? {
    insert(selection: .name)

    let value = try response.name.unwrapOrFail(context: "name not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func type() throws -> String? {
    insert(selection: .type)

    let value = try response.type.unwrapOrFail(context: "type not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  private func insert(selection: RocketSelection) {
    if populateSelections {
      rocketSelections.insert(selection)
    }
  }
}

class UserSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var userSelections = Set<UserSelection>()
  private let response: UserApolloModel
  private let populateSelections: Bool

  init(response: UserApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func email() throws -> String {
    insert(selection: .email)

    let value = try response.email.unwrapOrFail(context: "email not found")

    return value
  }

  func id() throws -> String {
    insert(selection: .id)

    let value = try response.id.unwrapOrFail(context: "id not found")

    return value
  }

  func profileImage() throws -> String? {
    insert(selection: .profileImage)

    let value = try response.profileImage.unwrapOrFail(context: "profileImage not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    insert(selection: .trips)

    let values = try response.trips.unwrapOrFail(context: "trips not found")

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(
          response: value,
          populateSelections: populateSelections
        )
        let result = try mapper(decoder)

        missionSelections = decoder.missionSelections
        rocketSelections = decoder.rocketSelections
        launchSelections = decoder.launchSelections

        return result
      } else {
        return nil
      }
    }
  }

  private func insert(selection: UserSelection) {
    if populateSelections {
      userSelections.insert(selection)
    }
  }
}

class TripUpdateResponseSelectionDecoder {
  private(set) var launchSelections = Set<LaunchSelection>()
  private(set) var missionSelections = Set<MissionSelection>()
  private(set) var rocketSelections = Set<RocketSelection>()
  private(set) var tripUpdateResponseSelections = Set<TripUpdateResponseSelection>()
  private let response: TripUpdateResponseApolloModel
  private let populateSelections: Bool

  init(response: TripUpdateResponseApolloModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    insert(selection: .launches)

    let values = try response.launches.unwrapOrFail(context: "launches not found")

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(
            response: value,
            populateSelections: populateSelections
          )
          let result = try mapper(decoder)

          launchSelections = decoder.launchSelections
          missionSelections = decoder.missionSelections
          rocketSelections = decoder.rocketSelections

          return result
        } else {
          return nil
        }
      }
    } else {
      return nil
    }
  }

  func message() throws -> String? {
    insert(selection: .message)

    let value = try response.message.unwrapOrFail(context: "message not found")

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func success() throws -> Bool {
    insert(selection: .success)

    let value = try response.success.unwrapOrFail(context: "success not found")

    return value
  }

  private func insert(selection: TripUpdateResponseSelection) {
    if populateSelections {
      tripUpdateResponseSelections.insert(selection)
    }
  }
}

// MARK: - Mappers

struct LaunchesQueryMapper<T> {
  typealias MapperBlock = (LaunchesQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LaunchesApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LaunchesQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = LaunchesApolloQuerySelections(
      launchSelections: decoder.launchSelections,
      launchConnectionSelections: decoder.launchConnectionSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections
    )
  }

  func map(response: LaunchConnectionApolloModel) throws -> T {
    try block(LaunchesQuerySelectionDecoder(response: response))
  }
}

struct LaunchQueryMapper<T> {
  typealias MapperBlock = (LaunchQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LaunchApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LaunchQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = LaunchApolloQuerySelections(
      launchSelections: decoder.launchSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections
    )
  }

  func map(response: LaunchApolloModel) throws -> T {
    try block(LaunchQuerySelectionDecoder(response: response))
  }
}

struct MeQueryMapper<T> {
  typealias MapperBlock = (MeQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: MeApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = MeQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = MeApolloQuerySelections(
      launchSelections: decoder.launchSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections,
      userSelections: decoder.userSelections
    )
  }

  func map(response: UserApolloModel) throws -> T {
    try block(MeQuerySelectionDecoder(response: response))
  }
}

struct BookTripsMutationMapper<T> {
  typealias MapperBlock = (BookTripsMutationSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: BookTripsApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = BookTripsMutationSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = BookTripsApolloMutationSelections(
      launchSelections: decoder.launchSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections,
      tripUpdateResponseSelections: decoder.tripUpdateResponseSelections
    )
  }

  func map(response: TripUpdateResponseApolloModel) throws -> T {
    try block(BookTripsMutationSelectionDecoder(response: response))
  }
}

struct CancelTripMutationMapper<T> {
  typealias MapperBlock = (CancelTripMutationSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CancelTripApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CancelTripMutationSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = CancelTripApolloMutationSelections(
      launchSelections: decoder.launchSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections,
      tripUpdateResponseSelections: decoder.tripUpdateResponseSelections
    )
  }

  func map(response: TripUpdateResponseApolloModel) throws -> T {
    try block(CancelTripMutationSelectionDecoder(response: response))
  }
}

struct UploadProfileImageMutationMapper<T> {
  typealias MapperBlock = (UploadProfileImageMutationSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: UploadProfileImageApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = UploadProfileImageMutationSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = UploadProfileImageApolloMutationSelections(
      launchSelections: decoder.launchSelections,
      missionSelections: decoder.missionSelections,
      rocketSelections: decoder.rocketSelections,
      userSelections: decoder.userSelections
    )
  }

  func map(response: UserApolloModel) throws -> T {
    try block(UploadProfileImageMutationSelectionDecoder(response: response))
  }
}
