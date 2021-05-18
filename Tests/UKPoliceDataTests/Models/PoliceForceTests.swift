@testable import UKPoliceData
import XCTest

class PoliceForceTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceForce.self, fromResource: "police-force", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
