import CoreLocation
@testable import PoliceDataKit
import XCTest

final class CrimesEndpointTests: XCTestCase {

    func testStreetLevelCrimesAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointReturnURL() throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-street/all-crime?poly=\(poly)&date=1970-01"))

        let path = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointReturnsURL() throws {
        let streetID = 12345
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-at-location?location_id=\(streetID)&date=1970-01"))

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path

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

    func testCategoriesEndpointReturnsURL() throws {
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crime-categories?date=1970-01"))

        let path = CrimesEndpoint.categories(date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
