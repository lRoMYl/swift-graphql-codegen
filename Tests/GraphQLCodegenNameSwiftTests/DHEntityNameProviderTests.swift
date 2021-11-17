//
//  File.swift
//  
//
//  Created by Romy Cheah on 14/10/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenNameSwift
import XCTest

final class DHEntityNameProviderTests: XCTestCase {
  func testSelectionNameForField() throws {
    let unionField = Field(
      name: "test",
      description: nil,
      args: [],
      type: .named(.union("SomeUnionName")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let interfaceField = Field(
      name: "test",
      description: nil,
      args: [],
      type: .named(.interface("SomeInterfaceName")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let enumField = Field(
      name: "test",
      description: nil,
      args: [],
      type: .named(.enum("SomeEnumName")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let scalarField = Field(
      name: "test",
      description: nil,
      args: [],
      type: .named(.scalar("SomeScalarName")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let objectField = Field(
      name: "test",
      description: nil,
      args: [],
      type: .named(.object("SomeObjectName")),
      isDeprecated: false,
      deprecationReason: nil
    )

    let entityNameProvider = DHEntityNameProvider(
      scalarMap: .default,
      entityNameMap: .default
    )

    XCTAssertNil(
      try entityNameProvider.selectionName(for: unionField),
      "Union should return nil for selection name"
    )
    XCTAssertNil(
      try entityNameProvider.selectionName(for: interfaceField),
      "Interface should return nil for selection name"
    )
    XCTAssertNil(
      try entityNameProvider.selectionName(for: enumField),
      "Enum should return nil for selection name"
    )
    XCTAssertNil(
      try entityNameProvider.selectionName(for: scalarField),
      "Scalar should return nil for selection name"
    )
    XCTAssert(
      try entityNameProvider.selectionName(for: objectField) == "SomeObjectNameSelection",
      "Return selection name with object name as prefix"
    )
  }

  func testSelectionVariableNameForObject() throws {
    let objectType = ObjectType(
      name: "ObjectName",
      description: nil,
      fields: [],
      interfaces: []
    )

    let entityNameProvider = DHEntityNameProvider(
      scalarMap: .default,
      entityNameMap: .default
    )

    let declarationForObjectType = try entityNameProvider.selectionsVariableName(for: objectType)
    let expectedDeclarationForObjectType = "objectNameSelections"

    XCTAssertEqual(declarationForObjectType, expectedDeclarationForObjectType)

    let objectTypeRef = ObjectTypeRef.named(.object("ObjectName"))

    let declarationForObjectTypeRef = try entityNameProvider.selectionsVariableName(for: objectTypeRef)
    let expectedDeclarationForObjectTypeRef = "objectNameSelections"

    XCTAssertEqual(declarationForObjectTypeRef, expectedDeclarationForObjectTypeRef)
  }
}
