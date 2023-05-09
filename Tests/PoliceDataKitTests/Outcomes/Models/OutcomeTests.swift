@testable import PoliceDataKit
import XCTest

final class OutcomeTests: XCTestCase {

    func testDecodeReturnsOutcome() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Outcome.self, fromResource: "outcome")

        XCTAssertEqual(result, .mock)
    }

}
