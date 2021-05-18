@testable import UKPoliceData
import XCTest

class OutcomeCrimeTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCrime() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(OutcomeCrime.self, fromResource: "outcome-crime", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
