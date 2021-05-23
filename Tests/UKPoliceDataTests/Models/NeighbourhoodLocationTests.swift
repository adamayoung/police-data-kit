@testable import UKPoliceData
import XCTest

class NeighbourhoodLocationTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testInitWhenLatitudeIsNilSetsCoordinateAsNil() {
        let result = NeighbourhoodLocation(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD", longitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testInitWhenLongitudeIsNilSetsCoordinateAsNil() {
        let result = NeighbourhoodLocation(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD", latitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testCoordinateReturnsCoordinate() throws {
        let expectedResult = NeighbourhoodLocation.mock.coordinate

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location", withExtension: "json")
            .coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenInvalidLatitudeAndLongitudeReturnsZeros() throws {
        let expectedResult = Coordinate(latitude: 0, longitude: 0)

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location-invalid-coordinates",
                    withExtension: "json")
            .coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenLatitudeAndLongitudeIsNilReturnsNil() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location-null-coordinates",
                    withExtension: "json")
            .coordinate

        XCTAssertNil(result)
    }

}
