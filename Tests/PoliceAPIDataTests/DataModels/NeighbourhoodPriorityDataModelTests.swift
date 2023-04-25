@testable import PoliceAPIData
import XCTest

final class NeighbourhoodPriorityDataModelTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriorityDataModel.self, fromResource: "neighbourhood-priority")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNotActionReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriorityDataModel.self, fromResource: "neighbourhood-priority-no-action")

        XCTAssertEqual(result, .mockNoAction)
    }

}
