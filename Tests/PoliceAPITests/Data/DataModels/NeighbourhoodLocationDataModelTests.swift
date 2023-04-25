@testable import PoliceAPI
import XCTest

final class NeighbourhoodLocationDataModelTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenTypeIsNill() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location-null-type")

        XCTAssertNil(result.type)
    }

    func testInitWhenLatitudeIsNilSetsCoordinateAsNil() {
        let result = NeighbourhoodLocationDataModel(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD",
                                                    longitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testInitWhenLongitudeIsNilSetsCoordinateAsNil() {
        let result = NeighbourhoodLocationDataModel(type: "test", address: "123 Kafe Street", postcode: "AB12 3CD",
                                                    latitude: 1)

        XCTAssertNil(result.coordinate)
    }

    func testCoordinateReturnsCoordinate() throws {
        let expectedResult = NeighbourhoodLocationDataModel.mock.coordinate

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenInvalidLatitudeAndLongitudeReturnsZeros() throws {
        let expectedResult = CoordinateDataModel(latitude: 0, longitude: 0)

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location-invalid-coordinates")
            .coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenLatitudeAndLongitudeIsNilReturnsNil() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location-null-coordinates")
            .coordinate

        XCTAssertNil(result)
    }

}
