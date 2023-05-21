import MapKit
@testable import PoliceDataKit
import XCTest

final class StopAndSearchServiceTests: XCTestCase {

    var service: StopAndSearchService!
    var apiClient: MockAPIClient!
    var cache: StopAndSearchMockCache!
    var availableDataRegion: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = StopAndSearchMockCache()
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
        apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: .mock, date: date).path
        )
    }

    func testStopAndSearchesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        apiClient.add(response: .success(StopAndSearch.mocks))

        var resultError: StopAndSearchError?
        do {
            _ = try await service.stopAndSearches(at: coordinate, date: date)
        } catch let error as StopAndSearchError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testStopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(in: coordinates, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path
        )
    }

    func testStopAndSearchesAtLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearches(expectedResult, atLocation: streetID, date: date)

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testStopAndSearchesAtLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearches(atLocation: streetID, date: date)

        let cachedResult = await cache.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesWithNoLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearchesWithNoLocation(expectedResult, forPoliceForce: policeForceID, date: date)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testStopAndSearchesWithNoLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path
        )
    }

    func testStopAndSearchesForPoliceForceWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearches(expectedResult, forPoliceForce: policeForceID, date: date)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testStopAndSearchesForPoliceForceWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
