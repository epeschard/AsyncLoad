import XCTest
@testable import AsyncLoad

final class AsyncLoadTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AsyncLoad().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
