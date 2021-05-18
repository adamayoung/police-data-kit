@testable import UKPoliceData
import XCTest

class LocationTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testInitWhenLatitudeIsNilSetsCoordinateAsNil() {
        let result = Location(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD", longitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testInitWhenLongitudeIsNilSetsCoordinateAsNil() {
        let result = Location(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD", latitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testCoordinateReturnsCoordinate() throws {
        let expectedResult = Location.mock.coordinate

        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location", withExtension: "json").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenInvalidLatitudeAndLongitudeReturnsZeros() throws {
        let expectedResult = Coordinate(latitude: 0, longitude: 0)

        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location-invalid-coordinates", withExtension: "json").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenLatitudeAndLongitudeIsNilReturnsNil() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location-null-coordinates", withExtension: "json").coordinate

        XCTAssertNil(result)
    }

}
