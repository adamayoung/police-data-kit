@testable import UKPoliceData
import XCTest

class OutcomesEndpointTests: XCTestCase {

    func testStreetLevelOutcomesForStreetEndpointReturnsURL() {
        let streetID = 12345
        let dateString = "2021-03"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/outcomes-at-location?location_id=\(streetID)&date=\(dateString)")!

        let url = OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesForStreetEndpointWhenNoDateReturnsURL() {
        let streetID = 12345
        let expectedURL = URL(string: "/outcomes-at-location?location_id=\(streetID)")!

        let url = OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let url = OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)")!

        let url = OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesInAreaEndpointReturnsURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))&date=\(dateString)"
        )!

        let url = OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesInAreaEndpointWhenNoDateReturnsURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let expectedURL = URL(string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))")!

        let url = OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCaseHistoryReturnsURL() {
        let crimeID = CaseHistory.mock.crime.crimeID
        let expectedURL = URL(string: "/outcomes-for-crime/\(crimeID)")!

        let url = OutcomesEndpoint.caseHistory(crimeID: crimeID).url

        XCTAssertEqual(url, expectedURL)
    }

}
