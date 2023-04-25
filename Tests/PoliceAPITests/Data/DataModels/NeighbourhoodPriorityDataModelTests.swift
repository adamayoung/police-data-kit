@testable import PoliceAPI
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

    func testDecodeWhenIssueContainsHTMLReturnsNeighbourhoodPriorityIssueWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriorityDataModel.mockWithHTML.issue

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriorityDataModel.self, fromResource: "neighbourhood-priority-html")
        let result = priority.issue

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodeWhenActionContainsHTMLReturnsNeighbourhoodPriorityActionWithoutHTML() throws {
        let expectedResult = NeighbourhoodPriorityDataModel.mockWithHTML.action

        let priority = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriorityDataModel.self, fromResource: "neighbourhood-priority-html")
        let result = priority.action

        XCTAssertEqual(result, expectedResult)
    }

}
