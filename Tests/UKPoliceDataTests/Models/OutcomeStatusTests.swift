@testable import UKPoliceData
import XCTest

class OutcomeStatusTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeStatus() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(OutcomeStatus.self, fromResource: "outcome-status", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
