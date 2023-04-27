@testable import PoliceAPI
import XCTest

final class PoliceOfficerDataModelTests: XCTestCase {

    func testDecodeReturnsPoliceOfficer() throws {
        let result = try JSONDecoder.policeDataAPI.decode(PoliceOfficerDataModel.self, fromResource: "police-officer")

        XCTAssertEqual(result, .mock)
    }

}
