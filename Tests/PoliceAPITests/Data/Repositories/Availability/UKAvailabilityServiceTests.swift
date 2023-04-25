@testable import PoliceAPI
import XCTest

final class UKAvailabilityRepositoryTests: XCTestCase {

    var service: UKAvailabilityRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKAvailabilityRepository(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSetDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.path)
    }

    func testAvailableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSetDataModel.mocks
        let cacheKey = AvailableDataSetsCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSetDataModel.mocks
        let cacheKey = AvailableDataSetsCachingKey()
        apiClient.response = .success(expectedResult)
        _ = try await service.availableDataSets()

        let cachedResult = await cache.object(for: cacheKey, type: [DataSetDataModel].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
