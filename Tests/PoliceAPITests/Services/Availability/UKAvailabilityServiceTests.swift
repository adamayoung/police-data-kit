@testable import PoliceAPI
import XCTest

final class UKAvailabilityTests: XCTestCase {

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

    func testAvailableDataSetsReturnsDataSets() async throws {
        let expectedResult = DataSet.mocks
        apiClient.response = expectedResult

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.path)
    }

}
