@testable import PoliceAPI
import XCTest

final class OutcomesEndpointTests: XCTestCase {

    func testStreetLevelOutcomesForStreetEndpointReturnsURL() {
        let streetID = 12345
        let dateString = "2021-03"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/outcomes-at-location?location_id=\(streetID)&date=\(dateString)")!

        let path = OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesForStreetEndpointWhenNoDateReturnsURL() {
        let streetID = 12345
        let expectedPath = URL(string: "/outcomes-at-location?location_id=\(streetID)")!

        let path = OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let path = OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedPath = URL(string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)")!

        let path = OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesInAreaEndpointReturnsURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))&date=\(dateString)"
        )!

        let path = OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesInAreaEndpointWhenNoDateReturnsURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let expectedPath = URL(string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))")!

        let path = OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCaseHistoryReturnsURL() {
        let crimeID = CaseHistory.mock.crime.crimeID
        let expectedPath = URL(string: "/outcomes-for-crime/\(crimeID)")!

        let path = OutcomesEndpoint.caseHistory(crimeID: crimeID).path

        XCTAssertEqual(path, expectedPath)
    }

}
