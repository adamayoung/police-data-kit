@testable import UKPoliceData
import XCTest

class CrimesEndpointTests: XCTestCase {

    func testStreetLevelCrimesAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelCrimesAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let url = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelCrimesInCustomAreaEndpointReturnURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/crimes-street/all-crime?poly=\(coordinatePairs.joined(separator: ":"))&date=\(dateString)"
        )!

        let url = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelCrimesInCustomAreaEndpointWhenNoDateReturnURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let expectedURL = URL(
            string: "/crimes-street/all-crime?poly=\(coordinatePairs.joined(separator: ":"))"
        )!

        let url = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesForStreetEndpointReturnsURL() {
        let streetID = 12345
        let dateString = "2021-03"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/outcomes-at-location?location_id=\(streetID)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesForStreetEndpointWhenNoDateReturnsURL() {
        let streetID = 12345
        let expectedURL = URL(
            string: "/outcomes-at-location?location_id=\(streetID)"
        )!

        let url = CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(
            string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let url = CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate).url

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

        let url = CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStreetLevelOutcomesInAreaEndpointWhenNoDateReturnsURL() {
        let coordinates = Coordinate.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let expectedURL = URL(
            string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))"
        )!

        let url = CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesAtLocationForStreetEndpointReturnsURL() {
        let streetID = 12345
        let dateString = "2021-03"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/crimes-at-location?location_id=\(streetID)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesAtLocationForStreetEndpointWhenNoDateReturnsURL() {
        let streetID = 12345
        let expectedURL = URL(
            string: "/crimes-at-location?location_id=\(streetID)"
        )!

        let url = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesAtLocationAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesAtLocationAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let url = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesWithNoLocationEndpointReturnsURL() {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)&date=\(dateString)"
        )!

        let url = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID,
                                                      date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCrimesWithNoLocationEndpointWhenNoDateReturnsURL() {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let expectedURL = URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)"
        )!

        let url = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testCategoriesEndpointReturnsURL() {
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/crime-categories?date=\(dateString)")!

        let url = CrimesEndpoint.categories(date: date).url

        XCTAssertEqual(url, expectedURL)
    }

}
