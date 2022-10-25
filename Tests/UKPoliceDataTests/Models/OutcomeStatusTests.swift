@testable import UKPoliceData
import XCTest

final class OutcomeStatusTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeStatus() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeStatus.self, fromResource: "outcome-status")

        XCTAssertEqual(result, .mock)
    }

}
