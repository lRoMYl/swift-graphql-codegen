//
//  File.swift
//  
//
//  Created by Romy Cheah on 22/10/21.
//

import Foundation
import GraphQLAST
import GraphQLCodegenNameSwift
import GraphQLCodegenUtil

enum SelectionMockGeneratorError: Error {
  case emptyPossibleTypes
}

struct SelectionMockGenerator: Generating {
  private let entityNameProvider: EntityNameProviding

  init(entityNameProvider: EntityNameProviding) {
    self.entityNameProvider = entityNameProvider
  }

  func code(schema: Schema) throws -> String {
    let comment = "// MARK: - SelectionMock\n"
    let enums = try schema.enums.map { enumType in
      try selectionMock(type: enumType)
    }.lines

    let interfaces = try schema.interfaces.map { interfaceType in
      try selectionMock(type: interfaceType)
    }.lines

    let unions = try schema.unions.map { unionType in
      try selectionMock(type: unionType)
    }.lines

    let objects = try schema.objects.map { objectType in
      try selectionMock(type: objectType)
    }.lines

    let codes = [
      comment,
      enums,
      interfaces,
      unions,
      objects
    ]

    return codes.lines
  }
}

private extension SelectionMockGenerator {
  func selectionMock(type: EnumType) throws -> String {
    return """
    extension \(try entityNameProvider.name(for: type)) {
      static func selectionMock() -> Self { ._unknown("") }
    }
    """
  }

  func selectionMock(type: InterfaceType) throws -> String {
    guard let firstPossibleType = type.possibleTypes.first else {
      throw SelectionMockGeneratorError.emptyPossibleTypes
    }

    return """
    extension \(try entityNameProvider.name(for: type)) {
      static func selectionMock() -> Self {
        .\(firstPossibleType.name.camelCase)(.selectionMock())
      }
    }
    """
  }

  func selectionMock(type: UnionType) throws -> String {
    guard let firstPossibleType = type.possibleTypes.first else {
      throw SelectionMockGeneratorError.emptyPossibleTypes
    }

    return """
    extension \(try entityNameProvider.name(for: type)) {
      static func selectionMock() -> Self {
        .\(firstPossibleType.name.camelCase)(.selectionMock())
      }
    }
    """
  }

  func selectionMock(type: ObjectType) throws -> String {
    let name = try entityNameProvider.name(for: type)
    let sortedFields = type.fields.sorted(by: { $0.name < $1.name })

    let memberwiseIntializer = try sortedFields.map {
      "\($0.name.camelCase): \(try mockDeclaration(typeRef: $0.type))"
    }.joined(separator: ",\n")

    return """
    extension \(name) {
      static func selectionMock() -> Self {
        \(name)(
          \(memberwiseIntializer)
        )
      }
    }
    """
  }

  func mockDeclaration(typeRef: OutputTypeRef) throws -> String {
    switch typeRef {
    case let .list(objectRef):
      return "[\(try mockDeclaration(typeRef: objectRef))]"
    case let .nonNull(objectRef):
      return try mockDeclaration(typeRef: objectRef)
    case .named:
      return ".selectionMock()"
    }
  }
}
