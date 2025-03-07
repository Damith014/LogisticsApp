import XCTest
@testable import LogisticsApp

final class LogisticsAppTests: XCTestCase {
    func testFormattedString() {
        XCTAssertEqual(1.345.formattedString(), "1.34")
    }
}
