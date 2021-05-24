@testable import UKPoliceData
import XCTest

class UKAvailabilityTests: XCTestCase {

    var service: UKAvailabilityService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKAvailabilityService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testFetchAvailableDataSetsReturnsDataSets() {
        let expectedResult = DataSet.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAvailableDataSets { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.url)
    }

}
