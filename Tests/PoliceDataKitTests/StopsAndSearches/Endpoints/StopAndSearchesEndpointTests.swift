import CoreLocation
@testable import PoliceDataKit
import XCTest

final class StopAndSearchesEndpointTests: XCTestCase {

    func testStopAndSearchesByAreaAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/stops-street?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByAreaInAreaEndpointReturnsURL() throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/stops-street?poly=\(poly)&date=1970-01"))

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesAtLocationEndpointReturnsURL() throws {
        let streetID = 883407
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/stops-at-location?location_id=\(streetID)&date=1970-01"))

        let path = StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesWithNoLocationEndpointReturnsURL() throws {
        let policeForceID = "cleveland"
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/stops-no-location?force=\(policeForceID)&date=1970-01"))

        let path = StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByForceReturnsURL() throws {
        let policeForceID = "avon-and-somerset"
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/stops-force?force=\(policeForceID)&date=1970-01"))

        let path = StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
