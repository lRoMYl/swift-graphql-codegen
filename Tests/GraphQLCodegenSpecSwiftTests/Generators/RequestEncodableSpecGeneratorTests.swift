//
//  File.swift
//  
//
//  Created by Romy Cheah on 16/11/21.
//

@testable import GraphQLAST
@testable import GraphQLCodegenConfig
@testable import GraphQLCodegenNameSwift
@testable import GraphQLCodegenSpecSwift
import XCTest

final class RequestEncodableSpecGeneratorTests: XCTestCase {
  func testEncodingDeclaraition() throws {
    let generator = RequestEncodableGenerator(
      selectionMap: nil,
      scalarMap: .default,
      entityNameProvider: EntityNameProvider(scalarMap: .default, entityNameMap: .default)
    )

    let starWarsSchema = try Schema.schema(from: "StarWarsTestSchema")
    guard let droidField = starWarsSchema.query.type.fields.first(where: { $0.name == "droid" }) else {
      XCTFail("droid query not found")
      return
    }

    let declaration = try generator.encodingDeclaration(field: droidField, schema: starWarsSchema).format()
    let expectedDeclaration = try """
    private enum CodingKeys: String, CodingKey {
      /// id of the character
      case id = "droidId"
    }
    """.format()

    XCTAssertEqual(
      declaration,
      expectedDeclaration,
      """
      Check if the generated codingKey have proper collision handling, by using a combination of
      (field name + variable name), in this case `droidId` = field `droid`, variable name `id`
      """
    )
  }
}
