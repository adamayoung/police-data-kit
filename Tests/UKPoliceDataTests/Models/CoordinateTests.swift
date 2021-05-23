@testable import UKPoliceData
import XCTest

#if canImport(CoreLocation)
import CoreLocation
#endif

class CoordinateTests: XCTestCase {

    func testDecodeReturnsCoordinate() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testLatitudeReturnsValue() throws {
        let expectedResult = Coordinate.mock.latitude

        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate", withExtension: "json").latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLatitudeWhenNotANumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate-invalid", withExtension: "json").latitude

        XCTAssertEqual(result, 0)
    }

    func testLongitudeReturnsValue() throws {
        let expectedResult = Coordinate.mock.longitude

        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate", withExtension: "json").longitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeWhenNotANumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate-invalid", withExtension: "json").longitude

        XCTAssertEqual(result, 0)
    }

    func testDescriptionReturnsString() {
        let coordinate = Coordinate.mock
        let expectedResult = "(\(coordinate.latitude), \(coordinate.longitude))"

        let result = (coordinate as CustomStringConvertible).description

        XCTAssertEqual(result, expectedResult)
    }

}
