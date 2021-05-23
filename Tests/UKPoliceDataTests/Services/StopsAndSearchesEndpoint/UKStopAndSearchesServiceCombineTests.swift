#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKStopAndSearchesServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    var service: UKStopAndSearchesService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKStopAndSearchesService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testStopAndSearchesByAreaPublisherReturnsStopAndSearches() throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesByAreaPublisher(atCoordinate: coordinate,
                                                                                   date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                    date: date).url)
    }

    func testStopAndSearchesByAreaPublisherWhenNoDateReturnsStopAndSearches() throws {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.stopAndSearchesByAreaPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).url)
    }

}
#endif
