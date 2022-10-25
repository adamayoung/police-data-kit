@testable import UKPoliceData
import XCTest

final class PoliceOfficerTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI.decode(PoliceOfficer.self, fromResource: "police-officer")

        XCTAssertEqual(result, .mock)
    }

}
