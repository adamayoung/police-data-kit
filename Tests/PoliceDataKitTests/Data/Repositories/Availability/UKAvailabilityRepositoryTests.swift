@testable import PoliceDataKit
import XCTest

final class UKAvailabilityRepositoryTests: XCTestCase {

    var repository: UKAvailabilityRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        repository = UKAvailabilityRepository(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        repository = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSetDataModel.mocks.map(DataSet.init)
        apiClient.response = .success(DataSetDataModel.mocks)

        let result = try await repository.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, AvailabilityEndpoint.dataSets.path)
    }

    func testAvailableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSetDataModel.mocks.map(DataSet.init)
        let cacheKey = AvailableDataSetsCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSetDataModel.mocks.map(DataSet.init)
        let cacheKey = AvailableDataSetsCachingKey()
        apiClient.response = .success(DataSetDataModel.mocks)
        _ = try await repository.availableDataSets()

        let cachedResult = await cache.object(for: cacheKey, type: [DataSet].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
