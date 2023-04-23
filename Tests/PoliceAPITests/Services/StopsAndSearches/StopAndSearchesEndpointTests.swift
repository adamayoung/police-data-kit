@testable import PoliceAPI
import XCTest

final class StopAndSearchesEndpointTests: XCTestCase {

    func testStopAndSearchesByAreaAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(
            string: "/stops-street?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByAreaInAreaEndpointReturnsURL() {
        let boundary = Boundary.mock
        let poly = boundary.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/stops-street?poly=\(poly)&date=\(dateString)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesAtLocationEndpointReturnsURL() {
        let streetID = 883407
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/stops-at-location?location_id=\(streetID)&date=\(dateString)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesWithNoLocationEndpointReturnsURL() {
        let policeForceID = "cleveland"
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/stops-no-location?force=\(policeForceID)&date=\(dateString)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByForceReturnsURL() {
        let policeForceID = "avon-and-somerset"
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/stops-force?force=\(policeForceID)&date=\(dateString)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
