@testable import PoliceAPI
import XCTest

final class UKStopAndSearchServiceTests: XCTestCase {

    var service: UKStopAndSearchService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKStopAndSearchService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testStopAndSearchesAtCoordinateReturnsStopAndSearches() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                    date: date).path)
    }

    func testStopAndSearchesAtCoordinateWhenNoDateReturnsStopAndSearches() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).path)
    }

    func testStopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let coordinates = Coordinate.mocks
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(inArea: coordinates, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).path)
    }

    func testStopAndSearchesInAreaWhenNoDateReturnsStopAndSearches() async throws {
        let coordinates = Coordinate.mocks
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(inArea: coordinates)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates).path)
    }

    func testStopAndSearchesAtLocationReturnsStopAndSearches() async throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path)
    }

    func testStopAndSearchesAtLocationWhenNoDateReturnsStopAndSearches() async throws {
        let streetID = 123456
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(atLocation: streetID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID).path)
    }

    func testStopAndSearchesWithNoLocationReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID,
                                                                             date: date).path)
    }

    func testStopAndSearchesWithNoLocationWhenNoDateReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID).path)
    }

    func testStopAndSearchesForPoliceForceReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID,
                                                                            date: date).path)
    }

    func testStopAndSearchesForPoliceForceWhenNoDateReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID).path)
    }

}
