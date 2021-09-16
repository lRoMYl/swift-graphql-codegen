import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DHGraphQLCodegenSwiftTests.allTests),
    ]
}
#endif
