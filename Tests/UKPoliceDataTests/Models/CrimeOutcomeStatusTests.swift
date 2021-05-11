@testable import UKPoliceData
import XCTest

final class CrimeOutcomeStatusTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeStatus() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CrimeOutcomeStatus.self, fromResource: "crime-outcome-status", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
