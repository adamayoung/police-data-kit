@testable import UKPoliceData
import XCTest

class UKStopAndSearchesServiceTests: XCTestCase {

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

    func testfetchStopAndSearchesByAreaReturnsStopAndSearches() {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = [StopAndSearch.mock]
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStopAndSearchesByArea(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                    date: date).url)
    }

    func testfetchStopAndSearchesByAreaWhenNoDateReturnsStopAndSearches() {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStopAndSearchesByArea(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).url)
    }

}
