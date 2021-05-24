@testable import UKPoliceData
import XCTest

class StopAndSearchesEndpointTests: XCTestCase {

    func testStopAndSearchesByAreaAtSpecificPointEndpointReturnsURL() {
        let coordinate = Coordinate.mock
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(
            string: "/stops-street?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=\(dateString)"
        )!

        let url = StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesByAreaAtSpecificPointEndpointWhenNoDateReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(
            string: "/stops-street?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)"
        )!

        let url = StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesByAreaInAreaEndpointReturnsURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let dateString = "2021-04"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/stops-street?poly=\(poly)&date=\(dateString)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesByAreaInAreaEndpointWhenNoDateReturnsURL() {
        let coordinates = Coordinate.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedURL = URL(string: "/stops-street?poly=\(poly)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesAtLocationEndpointReturnsURL() {
        let streetID = 883407
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/stops-at-location?location_id=\(streetID)&date=\(dateString)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesAtLocationEndpointWhenNoDateReturnsURL() {
        let streetID = 883407
        let expectedURL = URL(string: "/stops-at-location?location_id=\(streetID)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesWithNoLocationEndpointReturnsURL() {
        let policeForceID = "cleveland"
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/stops-no-location?force=\(policeForceID)&date=\(dateString)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesWithNoLocationEndpointWhenNoDateReturnsURL() {
        let policeForceID = "cleveland"
        let expectedURL = URL(string: "/stops-no-location?force=\(policeForceID)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesByForceReturnsURL() {
        let policeForceID = "avon-and-somerset"
        let dateString = "2017-01"
        let date = DateFormatter.yearMonth.date(from: dateString)!
        let expectedURL = URL(string: "/stops-force?force=\(policeForceID)&date=\(dateString)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date).url

        XCTAssertEqual(url, expectedURL)
    }

    func testStopAndSearchesByForceWhenNoDateReturnsURL() {
        let policeForceID = "avon-and-somerset"
        let expectedURL = URL(string: "/stops-force?force=\(policeForceID)")!

        let url = StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

}
