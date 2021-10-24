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

// MARK: - MapperError

enum StarWarsMapperError: Error, LocalizedError {
  case missingData(context: String)

  var errorDescription: String? {
    switch self {
    case let .missingData(context):
      return "\(Self.self): \(context)"
    }
  }
}

// MARK: - SelectionMock

extension EpisodeStarWarsEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension LanguageStarWarsEnumModel {
  static func selectionMock() -> Self { ._unknown("") }
}

extension CharacterStarWarsInterfaceModel {
  static func selectionMock() -> Self {
    .droid(.selectionMock())
  }
}

extension CharacterUnionStarWarsUnionModel {
  static func selectionMock() -> Self {
    .human(.selectionMock())
  }
}

extension MutationStarWarsModel {
  static func selectionMock() -> Self {
    MutationStarWarsModel(
      mutate: .selectionMock()
    )
  }
}

extension DroidStarWarsModel {
  static func selectionMock() -> Self {
    DroidStarWarsModel(
      id: .selectionMock(),
      name: .selectionMock()
    )
  }
}

extension HumanStarWarsModel {
  static func selectionMock() -> Self {
    HumanStarWarsModel(
      id: .selectionMock()
    )
  }
}

extension QueryStarWarsModel {
  static func selectionMock() -> Self {
    QueryStarWarsModel(
      character: .selectionMock(),
      characters: [.selectionMock()],
      droid: .selectionMock(),
      droids: [.selectionMock()],
      greeting: .selectionMock(),
      human: .selectionMock(),
      humans: [.selectionMock()],
      luke: .selectionMock(),
      time: .selectionMock(),
      whoami: .selectionMock()
    )
  }
}

extension SubscriptionStarWarsModel {
  static func selectionMock() -> Self {
    SubscriptionStarWarsModel(
      number: .selectionMock()
    )
  }
}

// MARK: - SelectionDecoder

class HumanQueryResponseSelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: HumanStarWarsModel
  private let populateSelections: Bool

  init(response: HumanStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      humanSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }
}

class DroidQueryResponseSelectionDecoder {
  private(set) var droidSelections = Set<DroidSelection>()
  private let response: DroidStarWarsModel
  private let populateSelections: Bool

  init(response: DroidStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      droidSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }

  func name() throws -> String {
    if populateSelections {
      droidSelections.insert(.name)
    }

    guard let value = response.name else {
      throw StarWarsMapperError.missingData(context: "name not found")
    }

    return value
  }
}

class LukeQueryResponseSelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: HumanStarWarsModel
  private let populateSelections: Bool

  init(response: HumanStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      humanSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }
}

class HumansQueryResponseSelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: HumanStarWarsModel
  private let populateSelections: Bool

  init(response: HumanStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      humanSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }
}

class DroidsQueryResponseSelectionDecoder {
  private(set) var droidSelections = Set<DroidSelection>()
  private let response: DroidStarWarsModel
  private let populateSelections: Bool

  init(response: DroidStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      droidSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }

  func name() throws -> String {
    if populateSelections {
      droidSelections.insert(.name)
    }

    guard let value = response.name else {
      throw StarWarsMapperError.missingData(context: "name not found")
    }

    return value
  }
}

class DroidSelectionDecoder {
  private(set) var droidSelections = Set<DroidSelection>()
  private let response: DroidStarWarsModel
  private let populateSelections: Bool

  init(response: DroidStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      droidSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }

  func name() throws -> String {
    if populateSelections {
      droidSelections.insert(.name)
    }

    guard let value = response.name else {
      throw StarWarsMapperError.missingData(context: "name not found")
    }

    return value
  }
}

class HumanSelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: HumanStarWarsModel
  private let populateSelections: Bool

  init(response: HumanStarWarsModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func id() throws -> String {
    if populateSelections {
      humanSelections.insert(.id)
    }

    guard let value = response.id else {
      throw StarWarsMapperError.missingData(context: "id not found")
    }

    return value
  }
}

// MARK: - Mappers

struct HumanQueryMapper<T> {
  typealias MapperBlock = (HumanQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: HumanStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = HumanQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = HumanStarWarsQuerySelections(
      humanSelections: decoder.humanSelections
    )
  }

  func map(response: HumanStarWarsModel) throws -> T {
    try block(HumanQueryResponseSelectionDecoder(response: response))
  }
}

struct DroidQueryMapper<T> {
  typealias MapperBlock = (DroidQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: DroidStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = DroidQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = DroidStarWarsQuerySelections(
      droidSelections: decoder.droidSelections
    )
  }

  func map(response: DroidStarWarsModel) throws -> T {
    try block(DroidQueryResponseSelectionDecoder(response: response))
  }
}

struct LukeQueryMapper<T> {
  typealias MapperBlock = (LukeQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LukeStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LukeQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = LukeStarWarsQuerySelections(
      humanSelections: decoder.humanSelections
    )
  }

  func map(response: HumanStarWarsModel) throws -> T {
    try block(LukeQueryResponseSelectionDecoder(response: response))
  }
}

struct HumansQueryMapper<T> {
  typealias MapperBlock = (HumansQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: HumansStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = HumansQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = HumansStarWarsQuerySelections(
      humanSelections: decoder.humanSelections
    )
  }

  func map(response: HumanStarWarsModel) throws -> T {
    try block(HumansQueryResponseSelectionDecoder(response: response))
  }
}

struct DroidsQueryMapper<T> {
  typealias MapperBlock = (DroidsQueryResponseSelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: DroidsStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = DroidsQueryResponseSelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = DroidsStarWarsQuerySelections(
      droidSelections: decoder.droidSelections
    )
  }

  func map(response: DroidStarWarsModel) throws -> T {
    try block(DroidsQueryResponseSelectionDecoder(response: response))
  }
}
