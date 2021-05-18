@testable import UKPoliceData
import XCTest

class OutcomeTests: XCTestCase {

    func testDecodeReturnsOutcome() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Outcome.self, fromResource: "outcome", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
