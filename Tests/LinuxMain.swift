import XCTest

import commandlinetoolTests

var tests = [XCTestCaseEntry]()
tests += commandlinetoolTests.allTests()
XCTMain(tests)
