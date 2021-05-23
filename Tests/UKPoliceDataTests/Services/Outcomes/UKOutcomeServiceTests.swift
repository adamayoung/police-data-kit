@testable import UKPoliceData
import XCTest

class UKOutcomeServiceTests: XCTestCase {

    var service: UKOutcomeService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKOutcomeService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testFetchStreetLevelOutcomesForStreetReturnsOutcomes() {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(forStreet: streetID, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url)
    }

    func testFetchStreetLevelOutcomesForStreetWhenNoDateReturnsOutcomes() {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(forStreet: streetID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url)
    }

    func testFetchStreetLevelOutcomesAtCoordinateReturnsOutcomes() {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(atCoordinate: coordinate, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date) .url)
    }

    func testFetchStreetLevelOutcomesAtCoordinateWhenNoDateReturnsOutcomes() {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate) .url)
    }

    func testFetchStreetLevelOutcomesInAreaReturnsOutcomes() {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(inArea: coordinates, date: date) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date) .url)
    }

    func testFetchStreetLevelOutcomesInAreaWhenNoDateReturnsOutcomes() {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchStreetLevelOutcomes(inArea: coordinates) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates) .url)
    }

    func testFetchCaseHistoryReturnCaseHistory() {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchCaseHistory(forCrime: crimeID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.caseHistory(crimeID: crimeID).url)
    }

}
