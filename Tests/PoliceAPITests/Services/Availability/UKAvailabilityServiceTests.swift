@testable import PoliceAPI
import XCTest

final class UKAvailabilityTests: XCTestCase {

    var service: UKAvailabilityService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKAvailabilityService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSet.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.path)
    }

    func testAvailableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSet.mocks
        let cacheKey = AvailableDataSetsCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSet.mocks
        let cacheKey = AvailableDataSetsCachingKey()
        apiClient.response = .success(expectedResult)
        _ = try await service.availableDataSets()

        let cachedResult = await cache.object(for: cacheKey, type: [DataSet].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
