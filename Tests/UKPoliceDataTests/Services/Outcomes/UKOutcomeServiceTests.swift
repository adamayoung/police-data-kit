@testable import UKPoliceData
import XCTest

final class UKOutcomeServiceTests: XCTestCase {

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

    func testStreetLevelOutcomesForStreetReturnsOutcomes() async throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path)
    }

    func testStreetLevelOutcomesForStreetWhenNoDateReturnsOutcomes() async throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(forStreet: streetID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).path)
    }

    func testStreetLevelOutcomesAtCoordinateReturnsOutcomes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date) .path)
    }

    func testStreetLevelOutcomesAtCoordinateWhenNoDateReturnsOutcomes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate) .path)
    }

    func testStreetLevelOutcomesInAreaReturnsOutcomes() async throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(inArea: coordinates, date: date)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath,
                       OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date) .path)
    }

    func testStreetLevelOutcomesInAreaWhenNoDateReturnsOutcomes() async throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try await service.streetLevelOutcomes(inArea: coordinates)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates) .path)
    }

    func testFetchCaseHistoryReturnCaseHistory() async throws {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        apiClient.response = expectedResult

        let result = try await service.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.caseHistory(crimeID: crimeID).path)
    }

}
