@testable import PoliceAPI
import XCTest

final class CrimesEndpointTests: XCTestCase {

    func testStreetLevelCrimesAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = Coordinate.mock
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesAtSpecificPointEndpointWhenNoDateReturnsURL() throws {
        let coordinate = Coordinate.mock
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        ))

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointReturnURL() throws {
        let boundary = Boundary.mock
        let poly = boundary.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-street/all-crime?poly=\(poly)&date=1970-01"))

        let path = CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointWhenNoDateReturnURL() throws {
        let boundary = Boundary.mock
        let poly = boundary.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-street/all-crime?poly=\(poly)"))

        let path = CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointReturnsURL() throws {
        let streetID = 12345
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-at-location?location_id=\(streetID)&date=1970-01"))

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointWhenNoDateReturnsURL() throws {
        let streetID = 12345
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-at-location?location_id=\(streetID)"))

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = Coordinate.mock
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointWhenNoDateReturnsURL() throws {
        let coordinate = Coordinate.mock
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        ))

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesWithNoLocationEndpointReturnsURL() throws {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)&date=1970-01"
        ))

        let path = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID,
                                                       date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesWithNoLocationEndpointWhenNoDateReturnsURL() throws {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)"
        ))

        let path = CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCategoriesEndpointReturnsURL() throws {
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crime-categories?date=1970-01"))

        let path = CrimesEndpoint.categories(date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
