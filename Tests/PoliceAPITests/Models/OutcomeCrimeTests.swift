@testable import PoliceAPI
import XCTest

final class OutcomeCrimeTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCrime() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeCrime.self, fromResource: "outcome-crime")

        XCTAssertEqual(result, .mock)
    }

}
