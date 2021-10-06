import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(GraphQLCodegenTests.allTests)
  ]
}
#endif
