@testable import PoliceAPIData
import XCTest

final class PoliceForceDataModelTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI.decode(PoliceForceDataModel.self, fromResource: "police-force")

        XCTAssertEqual(result, .mock)
    }

}
