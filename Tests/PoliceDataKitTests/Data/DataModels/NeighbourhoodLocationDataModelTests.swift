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

    func testLatitudeReturnsLatitude() throws {
        let expectedResult = NeighbourhoodLocationDataModel.mock.latitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location").latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeReturnsLongitude() throws {
        let expectedResult = NeighbourhoodLocationDataModel.mock.longitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocationDataModel.self, fromResource: "neighbourhood-location").longitude

        XCTAssertEqual(result, expectedResult)
    }

}
