@testable import PoliceAPI
import XCTest

final class UKStopAndSearchServiceTests: XCTestCase {

    var service: UKStopAndSearchService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKStopAndSearchService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStopAndSearchesAtCoordinateReturnsStopAndSearches() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStopAndSearchesAtCoordinateWhenNoDateReturnsStopAndSearches() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testStopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let boundary = Boundary.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(inArea: boundary, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: date).path
        )
    }

    func testStopAndSearchesInAreaWhenNoDateReturnsStopAndSearches() async throws {
        let boundary = Boundary.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(inArea: boundary)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: Date()).path
        )
    }

    func testStopAndSearchesAtLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenNoDateReturnsStopAndSearches() async throws {
        let streetID = 123456
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(atLocation: streetID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: Date()).path
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

    func testStopAndSearchesAtLocationWhenNotCachedAndReturnsCachedStopAndSearchesShouldCacheResult() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.stopAndSearches(atLocation: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesWithNoLocationWhenNoDateReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: Date()).path
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

    func testStopAndSearchesWithNoLocationWhenNotCachedAndReturnsCachedStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesForPoliceForceWhenNoDateReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(
            apiClient.lastPath,
            StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: Date()).path
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

    func testStopAndSearchesForPoliceForceWhenNotCachedAndReturnsCachedStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
