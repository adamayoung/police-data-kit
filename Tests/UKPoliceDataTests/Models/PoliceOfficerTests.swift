@testable import UKPoliceData
import XCTest

class PoliceOfficerTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceOfficer.self, fromResource: "police-officer", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
