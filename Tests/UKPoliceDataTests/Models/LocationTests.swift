@testable import UKPoliceData
import XCTest

class LocationTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testCoordinateReturnsCoordinate() throws {
        let expectedResult = Location.mock.coordinate

        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location", withExtension: "json").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenInvalidReturnsZeroCoordinate() throws {
        let expectedResult = Coordinate(latitude: 0, longitude: 0)

        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location-invalid-coordinate", withExtension: "json")
            .coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testStreetDescriptionReturnsString() {
        let street = Location.mock.street
        let expectedResult = "(\(street.id)) \(street.name)"

        let result = (street as CustomStringConvertible).description

        XCTAssertEqual(result, expectedResult)
    }

}
