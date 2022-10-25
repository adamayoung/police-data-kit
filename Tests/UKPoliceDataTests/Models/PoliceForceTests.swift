@testable import UKPoliceData
import XCTest

final class PoliceForceTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI.decode(PoliceForce.self, fromResource: "police-force")

        XCTAssertEqual(result, .mock)
    }

}
