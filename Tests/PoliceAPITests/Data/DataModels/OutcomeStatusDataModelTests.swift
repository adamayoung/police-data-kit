@testable import PoliceAPI
import XCTest

final class OutcomeStatusDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeStatus() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeStatusDataModel.self, fromResource: "outcome-status")

        XCTAssertEqual(result, .mock)
    }

}
