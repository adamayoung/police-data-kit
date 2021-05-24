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

    func testDecodeWhenIssueContainsHTMLReturnsNeighbourhoodPriorityIssueWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriority.mockWithHTML.issue

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-html", withExtension: "json")
        let result = priority.issue

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodeWhenActionContainsHTMLReturnsNeighbourhoodPriorityActionWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriority.mockWithHTML.action

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-html", withExtension: "json")
        let result = priority.action

        XCTAssertEqual(result, expectedResult)
    }

}
