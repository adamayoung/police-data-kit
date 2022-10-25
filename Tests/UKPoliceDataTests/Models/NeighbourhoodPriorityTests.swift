@testable import UKPoliceData
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

    func testDecodeWhenIssueContainsHTMLReturnsNeighbourhoodPriorityIssueWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriority.mockWithHTML.issue

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-html")
        let result = priority.issue

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodeWhenActionContainsHTMLReturnsNeighbourhoodPriorityActionWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriority.mockWithHTML.action

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-html")
        let result = priority.action

        XCTAssertEqual(result, expectedResult)
    }

}
