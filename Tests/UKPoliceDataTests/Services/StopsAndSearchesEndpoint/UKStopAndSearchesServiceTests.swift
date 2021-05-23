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

    func testFetchAllAtCoordinateReturnsStopAndSearches() {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                    date: date).url)
    }

    func testFetchAllAtCoordinateWhenNoDateReturnsStopAndSearches() {
        let coordinate = Coordinate.mock
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).url)
    }

    func testFetchAllAtLocationReturnsStopAndSearches() {
        let streetID = 123456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(atLocation: streetID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).url)
    }

    func testFetchAllAtLocationWhenNoDateReturnsStopAndSearches() {
        let streetID = 123456
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(atLocation: streetID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID).url)
    }

}
