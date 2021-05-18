@testable import UKPoliceData
import XCTest

class NeighbourhoodPriorityTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNotActionReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-no-action", withExtension: "json")

        XCTAssertEqual(result, .mockNoAction)
    }

}
