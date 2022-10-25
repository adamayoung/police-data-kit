@testable import UKPoliceData
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

    func testStopAndSearchesByAreaAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedPath = URL(
            string: "/stops-street?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByAreaInAreaEndpointReturnsURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedPath = URL(string: "/stops-street?poly=\(poly)&date=\(dateString)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStopAndSearchesByAreaInAreaEndpointWhenNoDateReturnsURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedPath = URL(string: "/stops-street?poly=\(poly)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates).path

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

    func testStopAndSearchesAtLocationEndpointWhenNoDateReturnsURL() {
        let streetID = 883407
        let expectedPath = URL(string: "/stops-at-location?location_id=\(streetID)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID).path

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

    func testStopAndSearchesWithNoLocationEndpointWhenNoDateReturnsURL() {
        let policeForceID = "cleveland"
        let expectedPath = URL(string: "/stops-no-location?force=\(policeForceID)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID).path

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

    func testStopAndSearchesByForceWhenNoDateReturnsURL() {
        let policeForceID = "avon-and-somerset"
        let expectedPath = URL(string: "/stops-force?force=\(policeForceID)")!

        let path = StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

}
