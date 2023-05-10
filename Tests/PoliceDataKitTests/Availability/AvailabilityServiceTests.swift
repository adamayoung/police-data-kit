@testable import PoliceDataKit
import XCTest

final class AvailabilityServiceTests: XCTestCase {

    var service: AvailabilityService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
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
        let cacheKey = AvailableDataSetsCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSet.mocks
        let cacheKey = AvailableDataSetsCachingKey()
        apiClient.add(response: .success(DataSet.mocks))
        _ = try await service.availableDataSets()

        let cachedResult = await cache.object(for: cacheKey, type: [DataSet].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
