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

class HumanQuerySelectionDecoder {
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

class DroidQuerySelectionDecoder {
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

class CharacterQuerySelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private(set) var droidSelections = Set<DroidSelection>()
  private let response: CharacterUnionStarWarsUnionModel
  private let populateSelections: Bool

  init(response: CharacterUnionStarWarsUnionModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func characterUnion<T>(
    droidMapper: (DroidSelectionDecoder) throws -> T,
    humanMapper: (HumanSelectionDecoder) throws -> T
  ) throws -> T? {
    switch response {
    case let .droid(droid):
      let decoder = DroidSelectionDecoder(response: droid)
      return try droidMapper(decoder)
    case let .human(human):
      let decoder = HumanSelectionDecoder(response: human)
      return try humanMapper(decoder)
    }
  }
}

class LukeQuerySelectionDecoder {
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

class HumansQuerySelectionDecoder {
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

class DroidsQuerySelectionDecoder {
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

class CharactersQuerySelectionDecoder {
  private(set) var droidSelections = Set<DroidSelection>()
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: CharacterStarWarsInterfaceModel
  private let populateSelections: Bool

  init(response: CharacterStarWarsInterfaceModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func character<T>(
    droidMapper: (DroidSelectionDecoder) throws -> T,
    humanMapper: (HumanSelectionDecoder) throws -> T
  ) throws -> T? {
    switch response {
    case let .droid(droid):
      let decoder = DroidSelectionDecoder(response: droid)
      return try droidMapper(decoder)
    case let .human(human):
      let decoder = HumanSelectionDecoder(response: human)
      return try humanMapper(decoder)
    }
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

class CharacterUnionUnionSelectionDecoder {
  private(set) var humanSelections = Set<HumanSelection>()
  private(set) var droidSelections = Set<DroidSelection>()
  private let response: CharacterUnionStarWarsUnionModel
  private let populateSelections: Bool

  init(response: CharacterUnionStarWarsUnionModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func characterUnion<T>(
    droidMapper: (DroidSelectionDecoder) throws -> T,
    humanMapper: (HumanSelectionDecoder) throws -> T
  ) throws -> T? {
    switch response {
    case let .droid(droid):
      let decoder = DroidSelectionDecoder(response: droid)
      return try droidMapper(decoder)
    case let .human(human):
      let decoder = HumanSelectionDecoder(response: human)
      return try humanMapper(decoder)
    }
  }
}

class CharacterInterfaceSelectionDecoder {
  private(set) var droidSelections = Set<DroidSelection>()
  private(set) var humanSelections = Set<HumanSelection>()
  private let response: CharacterStarWarsInterfaceModel
  private let populateSelections: Bool

  init(response: CharacterStarWarsInterfaceModel, populateSelections: Bool = false) {
    self.response = response
    self.populateSelections = populateSelections
  }

  func character<T>(
    droidMapper: (DroidSelectionDecoder) throws -> T,
    humanMapper: (HumanSelectionDecoder) throws -> T
  ) throws -> T? {
    switch response {
    case let .droid(droid):
      let decoder = DroidSelectionDecoder(response: droid)
      return try droidMapper(decoder)
    case let .human(human):
      let decoder = HumanSelectionDecoder(response: human)
      return try humanMapper(decoder)
    }
  }
}

// MARK: - Mappers

struct HumanQueryMapper<T> {
  typealias MapperBlock = (HumanQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: HumanStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = HumanQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(HumanQuerySelectionDecoder(response: response))
  }
}

struct DroidQueryMapper<T> {
  typealias MapperBlock = (DroidQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: DroidStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = DroidQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(DroidQuerySelectionDecoder(response: response))
  }
}

struct CharacterQueryMapper<T> {
  typealias MapperBlock = (CharacterQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CharacterStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CharacterQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = CharacterStarWarsQuerySelections(
    )
  }

  func map(response: CharacterUnionStarWarsUnionModel) throws -> T {
    try block(CharacterQuerySelectionDecoder(response: response))
  }
}

struct LukeQueryMapper<T> {
  typealias MapperBlock = (LukeQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: LukeStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = LukeQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(LukeQuerySelectionDecoder(response: response))
  }
}

struct HumansQueryMapper<T> {
  typealias MapperBlock = (HumansQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: HumansStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = HumansQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(HumansQuerySelectionDecoder(response: response))
  }
}

struct DroidsQueryMapper<T> {
  typealias MapperBlock = (DroidsQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: DroidsStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = DroidsQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

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
    try block(DroidsQuerySelectionDecoder(response: response))
  }
}

struct CharactersQueryMapper<T> {
  typealias MapperBlock = (CharactersQuerySelectionDecoder) throws -> T
  private let block: MapperBlock

  let selections: CharactersStarWarsQuerySelections

  init(_ block: @escaping MapperBlock) {
    self.block = block

    let decoder = CharactersQuerySelectionDecoder(response: .selectionMock(), populateSelections: true)

    do {
      _ = try block(decoder)
    } catch {
      assertionFailure("Failed to mock serialization")
    }

    selections = CharactersStarWarsQuerySelections(
    )
  }

  func map(response: CharacterStarWarsInterfaceModel) throws -> T {
    try block(CharactersQuerySelectionDecoder(response: response))
  }
}
