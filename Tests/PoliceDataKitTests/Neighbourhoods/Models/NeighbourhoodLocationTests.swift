@testable import PoliceDataKit
import XCTest

final class NeighbourhoodLocationTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenTypeIsNill() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location-null-type")

        XCTAssertNil(result.type)
    }

    func testLatitudeReturnsLatitude() throws {
        let expectedResult = NeighbourhoodLocation.mock.coordinate?.latitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location").coordinate?.latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeReturnsLongitude() throws {
        let expectedResult = NeighbourhoodLocation.mock.coordinate?.longitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location").coordinate?.longitude

        XCTAssertEqual(result, expectedResult)
    }

}
