#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKOutcomeServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
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

    func testStreetLevelOutcomesForStreetPublisherReturnsOutcomes() throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(forStreet: streetID,
                                                                               date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url)
    }

    func testStreetLevelOutcomesForStreetPublisherWhenNoDateReturnsOutcomes() throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(forStreet: streetID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url)
    }

    func testStreetLevelOutcomesAtCoordinatePublisherReturnsOutcomes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(atCoordinate: coordinate, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date) .url)
    }

    func testStreetLevelOutcomesAtCoordinatePublisherWhenNoDateReturnsOutcomes() throws {
        let coordinate = Coordinate.mock
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate) .url)
    }

    func testStreetLevelOutcomesInAreaPublisherReturnsOutcomes() throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(inArea: coordinates, date: date),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date) .url)
    }

    func testStreetLevelOutcomesInAreaPublisherWhenNoDateReturnsOutcomes() throws {
        let coordinates = Coordinate.mocks
        let expectedResult = Outcome.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.streetLevelOutcomesPublisher(inArea: coordinates),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates) .url)
    }

}
#endif
