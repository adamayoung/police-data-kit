#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKAvailabilityServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
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

    func testAvailableDataSetsPublisherReturnsDataSets() throws {
        let expectedResult = DataSet.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.availableDataSetsPublisher(), storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.url)
    }

}
#endif
