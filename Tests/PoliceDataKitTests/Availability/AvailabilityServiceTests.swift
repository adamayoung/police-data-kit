@testable import PoliceDataKit
import XCTest

final class AvailabilityServiceTests: XCTestCase {

    var service: AvailabilityService!
    var apiClient: MockAPIClient!
    var cache: AvailabilityMockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = AvailabilityMockCache()
        service = AvailabilityService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSet.mocks
        apiClient.add(response: .success(DataSet.mocks))

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, AvailabilityEndpoint.dataSets.path)
    }

    func testAvailableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSet.mocks
        await cache.setAvailableDataSets(expectedResult)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSet.mocks
        apiClient.add(response: .success(DataSet.mocks))
        _ = try await service.availableDataSets()

        let cachedResult = await cache.availableDataSets()

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
