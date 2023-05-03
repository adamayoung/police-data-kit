@testable import PoliceDataKit
import XCTest

final class LocationTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Location.self, fromResource: "location")

        XCTAssertEqual(result, .mock)
    }

    func testLatitudeReturnsLatitude() throws {
        let expectedResult = Location.mock.coordinate?.latitude

        let result = try JSONDecoder.policeDataAPI.decode(Location.self, fromResource: "location").coordinate?.latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeReturnsLongitude() throws {
        let expectedResult = Location.mock.coordinate?.longitude

        let result = try JSONDecoder.policeDataAPI.decode(Location.self, fromResource: "location").coordinate?.longitude

        XCTAssertEqual(result, expectedResult)
    }

}
