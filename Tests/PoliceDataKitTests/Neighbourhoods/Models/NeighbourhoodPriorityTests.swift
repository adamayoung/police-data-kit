@testable import PoliceDataKit
import XCTest

final class NeighbourhoodPriorityTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNotActionReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-no-action")

        XCTAssertEqual(result, .mockNoAction)
    }

}
