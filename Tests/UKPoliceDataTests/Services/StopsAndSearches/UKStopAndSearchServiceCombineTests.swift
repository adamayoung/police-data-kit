#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKStopAndSearchServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
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

    func testStopAndSearchesAtCoordinatePublisherReturnsStopAndSearches() throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                    date: date).url)
    }

    func testStopAndSearchesAtCoordinatePublisherWhenNoDateReturnsStopAndSearches() throws {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).url)
    }

    func testStopAndSearchesAtLocationPublisherReturnsStopAndSearches() throws {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesPublisher(atLocation: streetID, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).url)
    }

    func testStopAndSearchesAtLocationPublisherWhenNoDateReturnsStopAndSearches() throws {
        let streetID = 123456
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesPublisher(atLocation: streetID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID).url)
    }

}
#endif
