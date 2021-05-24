@testable import UKPoliceData
import XCTest

class UKStopAndSearchServiceTests: XCTestCase {

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

    func testFetchAllInAreaReturnsStopAndSearches() {
        let coordinates = Coordinate.mocks
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(inArea: coordinates, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).url)
    }

    func testFetchAllInAreaWhenNoDateReturnsStopAndSearches() {
        let coordinates = Coordinate.mocks
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(inArea: coordinates) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates).url)
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

    func testFetchAllWithNoLocationReturnsStopAndSearches() {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAllWithNoLocation(forPoliceForce: policeForceID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID,
                                                                             date: date).url)
    }

    func testFetchAllWithNoLocationWhenNoDateReturnsStopAndSearches() {
        let policeForceID = "cleveland"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAllWithNoLocation(forPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID).url)
    }

    func testFetchAllForPoliceForceReturnsStopAndSearches() {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(forPoliceForce: policeForceID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID,
                                                                            date: date).url)
    }

    func testFetchAllForPoliceForceWhenNoDateReturnsStopAndSearches() {
        let policeForceID = "avon-and-somerset"
        let expectedResult = StopAndSearch.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(forPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID).url)
    }

}
