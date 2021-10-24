// @generated
// Do not edit this generated file
// swiftlint:disable all

import ApiClient
import Foundation
import RxSwift

// MARK: - Primitive Selection Mock

private extension Int {
  static func selectionMock() -> Self { 0 }
}

private extension Bool {
  static func selectionMock() -> Self { false }
}

private extension String {
  static func selectionMock() -> Self { "" }
}

private extension Double {
  static func selectionMock() -> Self { 0 }
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
      tripsBooked: .selectionMock(),
      launch: .selectionMock(),
      launches: .selectionMock(),
      me: .selectionMock()
    )
  }
}

extension LaunchConnectionApolloModel {
  static func selectionMock() -> Self {
    LaunchConnectionApolloModel(
      hasMore: .selectionMock(),
      launches: [.selectionMock()],
      cursor: .selectionMock()
    )
  }
}

extension LaunchApolloModel {
  static func selectionMock() -> Self {
    LaunchApolloModel(
      isBooked: .selectionMock(),
      id: .selectionMock(),
      mission: .selectionMock(),
      rocket: .selectionMock(),
      site: .selectionMock()
    )
  }
}

extension MissionApolloModel {
  static func selectionMock() -> Self {
    MissionApolloModel(
      name: .selectionMock(),
      missionPatch: .selectionMock()
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
      id: .selectionMock(),
      trips: [.selectionMock()],
      email: .selectionMock(),
      profileImage: .selectionMock()
    )
  }
}

extension MutationApolloModel {
  static func selectionMock() -> Self {
    MutationApolloModel(
      login: .selectionMock(),
      bookTrips: .selectionMock(),
      cancelTrip: .selectionMock(),
      uploadProfileImage: .selectionMock()
    )
  }
}

extension TripUpdateResponseApolloModel {
  static func selectionMock() -> Self {
    TripUpdateResponseApolloModel(
      success: .selectionMock(),
      launches: [.selectionMock()],
      message: .selectionMock()
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

class LaunchesQueryResponseSelectionDecoder {
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
    if populateSelections {
      launchConnectionSelections.insert(.cursor)
    }

    guard let value = response.cursor else {
      throw ApolloMapperError.missingData(context: "cursor not found")
    }

    return value
  }

  func hasMore() throws -> Bool {
    if populateSelections {
      launchConnectionSelections.insert(.hasMore)
    }

    guard let value = response.hasMore else {
      throw ApolloMapperError.missingData(context: "hasMore not found")
    }

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      launchConnectionSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloMapperError.missingData(context: "launches not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
}

class LaunchQueryResponseSelectionDecoder {
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
    if populateSelections {
      launchSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func site() throws -> String? {
    if populateSelections {
      launchSelections.insert(.site)
    }

    guard let value = response.site else {
      throw ApolloMapperError.missingData(context: "site not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.mission)
    }

    guard let value = response.mission else {
      throw ApolloMapperError.missingData(context: "mission not found")
    }

    if let value = value {
      let decoder = MissionSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.rocket)
    }

    guard let value = response.rocket else {
      throw ApolloMapperError.missingData(context: "rocket not found")
    }

    if let value = value {
      let decoder = RocketSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func isBooked() throws -> Bool {
    if populateSelections {
      launchSelections.insert(.isBooked)
    }

    guard let value = response.isBooked else {
      throw ApolloMapperError.missingData(context: "isBooked not found")
    }

    return value
  }
}

class MeQueryResponseSelectionDecoder {
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

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloMapperError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloMapperError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloMapperError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
}

class BookTripsMutationResponseSelectionDecoder {
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

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloMapperError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloMapperError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloMapperError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
}

class CancelTripMutationResponseSelectionDecoder {
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

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloMapperError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloMapperError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloMapperError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
}

class UploadProfileImageMutationResponseSelectionDecoder {
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

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloMapperError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloMapperError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloMapperError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
    if populateSelections {
      launchConnectionSelections.insert(.cursor)
    }

    guard let value = response.cursor else {
      throw ApolloMapperError.missingData(context: "cursor not found")
    }

    return value
  }

  func hasMore() throws -> Bool {
    if populateSelections {
      launchConnectionSelections.insert(.hasMore)
    }

    guard let value = response.hasMore else {
      throw ApolloMapperError.missingData(context: "hasMore not found")
    }

    return value
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      launchConnectionSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloMapperError.missingData(context: "launches not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
    if populateSelections {
      launchSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func site() throws -> String? {
    if populateSelections {
      launchSelections.insert(.site)
    }

    guard let value = response.site else {
      throw ApolloMapperError.missingData(context: "site not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func mission<T>(mapper: (MissionSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.mission)
    }

    guard let value = response.mission else {
      throw ApolloMapperError.missingData(context: "mission not found")
    }

    if let value = value {
      let decoder = MissionSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      missionSelections = decoder.missionSelections

      return result
    } else {
      return nil
    }
  }

  func rocket<T>(mapper: (RocketSelectionDecoder) throws -> T) throws -> T? {
    if populateSelections {
      launchSelections.insert(.rocket)
    }

    guard let value = response.rocket else {
      throw ApolloMapperError.missingData(context: "rocket not found")
    }

    if let value = value {
      let decoder = RocketSelectionDecoder(response: value, populateSelections: populateSelections)
      let result = try mapper(decoder)

      rocketSelections = decoder.rocketSelections

      return result
    } else {
      return nil
    }
  }

  func isBooked() throws -> Bool {
    if populateSelections {
      launchSelections.insert(.isBooked)
    }

    guard let value = response.isBooked else {
      throw ApolloMapperError.missingData(context: "isBooked not found")
    }

    return value
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

  func name() throws -> String? {
    if populateSelections {
      missionSelections.insert(.name)
    }

    guard let value = response.name else {
      throw ApolloMapperError.missingData(context: "name not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func missionPatch() throws -> String? {
    if populateSelections {
      missionSelections.insert(.missionPatch)
    }

    guard let value = response.missionPatch else {
      throw ApolloMapperError.missingData(context: "missionPatch not found")
    }

    if let value = value {
      return value
    } else {
      return nil
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
    if populateSelections {
      rocketSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func name() throws -> String? {
    if populateSelections {
      rocketSelections.insert(.name)
    }

    guard let value = response.name else {
      throw ApolloMapperError.missingData(context: "name not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func type() throws -> String? {
    if populateSelections {
      rocketSelections.insert(.type)
    }

    guard let value = response.type else {
      throw ApolloMapperError.missingData(context: "type not found")
    }

    if let value = value {
      return value
    } else {
      return nil
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

  func id() throws -> String {
    if populateSelections {
      userSelections.insert(.id)
    }

    guard let value = response.id else {
      throw ApolloMapperError.missingData(context: "id not found")
    }

    return value
  }

  func email() throws -> String {
    if populateSelections {
      userSelections.insert(.email)
    }

    guard let value = response.email else {
      throw ApolloMapperError.missingData(context: "email not found")
    }

    return value
  }

  func profileImage() throws -> String? {
    if populateSelections {
      userSelections.insert(.profileImage)
    }

    guard let value = response.profileImage else {
      throw ApolloMapperError.missingData(context: "profileImage not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func trips<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?] {
    if populateSelections {
      userSelections.insert(.trips)
    }

    guard let values = response.trips else {
      throw ApolloMapperError.missingData(context: "trips not found")
    }

    return try values.compactMap { value in
      if let value = value {
        let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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

  func success() throws -> Bool {
    if populateSelections {
      tripUpdateResponseSelections.insert(.success)
    }

    guard let value = response.success else {
      throw ApolloMapperError.missingData(context: "success not found")
    }

    return value
  }

  func message() throws -> String? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.message)
    }

    guard let value = response.message else {
      throw ApolloMapperError.missingData(context: "message not found")
    }

    if let value = value {
      return value
    } else {
      return nil
    }
  }

  func launches<T>(mapper: (LaunchSelectionDecoder) throws -> T) throws -> [T?]? {
    if populateSelections {
      tripUpdateResponseSelections.insert(.launches)
    }

    guard let values = response.launches else {
      throw ApolloMapperError.missingData(context: "launches not found")
    }

    if let values = values {
      return try values.compactMap { value in
        if let value = value {
          let decoder = LaunchSelectionDecoder(response: value, populateSelections: populateSelections)
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
}

// MARK: - Mappers

struct LaunchesQueryMapper<T> {
  typealias MapperBlock = (LaunchesQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LaunchesApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LaunchesQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(LaunchesQueryResponseSelectionDecoder(response: response))
  }
}

struct LaunchQueryMapper<T> {
  typealias MapperBlock = (LaunchQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LaunchApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LaunchQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(LaunchQueryResponseSelectionDecoder(response: response))
  }
}

struct MeQueryMapper<T> {
  typealias MapperBlock = (MeQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: MeApolloQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = MeQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(MeQueryResponseSelectionDecoder(response: response))
  }
}

struct BookTripsMutationMapper<T> {
  typealias MapperBlock = (BookTripsMutationResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: BookTripsApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = BookTripsMutationResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(BookTripsMutationResponseSelectionDecoder(response: response))
  }
}

struct CancelTripMutationMapper<T> {
  typealias MapperBlock = (CancelTripMutationResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CancelTripApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CancelTripMutationResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(CancelTripMutationResponseSelectionDecoder(response: response))
  }
}

struct UploadProfileImageMutationMapper<T> {
  typealias MapperBlock = (UploadProfileImageMutationResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: UploadProfileImageApolloMutationSelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = UploadProfileImageMutationResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(UploadProfileImageMutationResponseSelectionDecoder(response: response))
  }
}
