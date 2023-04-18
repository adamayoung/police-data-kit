@testable import PoliceAPI
import XCTest

final class CrimesEndpointTests: XCTestCase {

    func testStreetLevelCrimesAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedPath = URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointReturnURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/crimes-street/all-crime?poly=\(poly)&date=\(dateString)")!

        let path = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointWhenNoDateReturnURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedPath = URL(string: "/crimes-street/all-crime?poly=\(poly)")!

        let path = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointReturnsURL() {
        let streetID = 12345
        let dateString = "2021-03"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/crimes-at-location?location_id=\(streetID)&date=\(dateString)")!

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointWhenNoDateReturnsURL() {
        let streetID = 12345
        let expectedPath = URL(string: "/crimes-at-location?location_id=\(streetID)")!

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedPath = URL(string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)")!

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesWithNoLocationEndpointReturnsURL() {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)&date=\(dateString)"
        )!

        let path = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID,
                                                       date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesWithNoLocationEndpointWhenNoDateReturnsURL() {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)")!

        let path = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCategoriesEndpointReturnsURL() {
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/crime-categories?date=\(dateString)")!

        let path = CrimesEndpoint.categories(date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
