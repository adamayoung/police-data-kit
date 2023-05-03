import MapKit
@testable import PoliceDataKit
import XCTest

final class StopAndSearchServiceTests: XCTestCase {

    var service: StopAndSearchService!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        service = StopAndSearchService(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    override func tearDown() {
        service = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStopAndSearchesAtCoordinateReturnsStopAndSearches() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(StopAndSearch.mocks)

        let result = try await service.stopAndSearches(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: .mock, date: date).path
        )
    }

    func testStopAndSearchesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        apiClient.response = .success(StopAndSearch.mocks)

        var resultError: StopAndSearchError?
        do {
            _ = try await service.stopAndSearches(at: coordinate, date: date)
        } catch let error as StopAndSearchError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(StopAndSearch.mocks)

        let result = try await service.stopAndSearches(in: coordinates, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(StopAndSearch.mocks)

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesAtLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(StopAndSearch.mocks)
        _ = try await service.stopAndSearches(atLocation: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(StopAndSearch.mocks)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesWithNoLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(StopAndSearch.mocks)
        _ = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(StopAndSearch.mocks)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesForPoliceForceWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(StopAndSearch.mocks)
        _ = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
