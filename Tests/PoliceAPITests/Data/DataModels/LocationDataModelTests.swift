@testable import PoliceAPI
import XCTest

final class LocationDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI.decode(LocationDataModel.self, fromResource: "location")

        XCTAssertEqual(result, .mock)
    }

    func testCoordinateReturnsCoordinate() throws {
        let expectedResult = LocationDataModel.mock.coordinate

        let result = try JSONDecoder.policeDataAPI.decode(LocationDataModel.self, fromResource: "location").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testCoordinateWhenInvalidReturnsZeroCoordinate() throws {
        let expectedResult = CoordinateDataModel(latitude: 0, longitude: 0)

        let result = try JSONDecoder.policeDataAPI
            .decode(LocationDataModel.self, fromResource: "location-invalid-coordinate").coordinate

        XCTAssertEqual(result, expectedResult)
    }

    func testStreetDescriptionReturnsString() {
        let street = LocationDataModel.mock.street
        let expectedResult = "(\(street.id)) \(street.name)"

        let result = (street as CustomStringConvertible).description

        XCTAssertEqual(result, expectedResult)
    }

}
