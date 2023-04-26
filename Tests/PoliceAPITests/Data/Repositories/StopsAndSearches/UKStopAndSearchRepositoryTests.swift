import CoreLocation
@testable import PoliceAPI
import XCTest

final class UKStopAndSearchRepositoryTests: XCTestCase {

    var repository: UKStopAndSearchRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: CoordinateRegionDataModel!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        repository = UKStopAndSearchRepository(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    override func tearDown() {
        repository = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStopAndSearchesAtCoordinateReturnsStopAndSearches() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .mock)
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearches(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: .mock, date: date).path
        )
    }

    func testStopAndSearchesAtCoordinateWhenCoordinateOutsideOfAvailableDataRegionReturnsNil() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .outsideAvailableDataRegion)
        let date = Date()
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearches(at: coordinate, date: date)

        XCTAssertNil(result)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let boundary = [CLLocationCoordinate2D](dataModel: .mock)
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearches(in: boundary, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: .mock, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesAtLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(StopAndSearchDataModel.mocks)
        _ = try await repository.stopAndSearches(atLocation: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesWithNoLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(StopAndSearchDataModel.mocks)
        _ = try await repository.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        apiClient.response = .success(StopAndSearchDataModel.mocks)

        let result = try await repository.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesForPoliceForceWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearchDataModel.mocks.map(StopAndSearch.init)
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(StopAndSearchDataModel.mocks)
        _ = try await repository.stopAndSearches(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
