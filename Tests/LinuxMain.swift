import XCTest

import AsyncLoadTests

var tests = [XCTestCaseEntry]()
tests += AsyncLoadTests.allTests()
XCTMain(tests)
