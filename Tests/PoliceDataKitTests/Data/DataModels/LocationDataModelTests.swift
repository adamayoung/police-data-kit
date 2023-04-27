@testable import PoliceAPI
import XCTest

final class LocationDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI.decode(LocationDataModel.self, fromResource: "location")

        XCTAssertEqual(result, .mock)
    }

    func testLatitudeReturnsLatitude() throws {
        let expectedResult = LocationDataModel.mock.latitude

        let result = try JSONDecoder.policeDataAPI.decode(LocationDataModel.self, fromResource: "location").latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeReturnsLongitude() throws {
        let expectedResult = LocationDataModel.mock.longitude

        let result = try JSONDecoder.policeDataAPI.decode(LocationDataModel.self, fromResource: "location").longitude

        XCTAssertEqual(result, expectedResult)
    }

}
