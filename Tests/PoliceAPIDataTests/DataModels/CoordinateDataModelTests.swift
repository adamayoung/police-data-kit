@testable import PoliceAPIData
import XCTest

final class CoordinateDataModelTests: XCTestCase {

    func testDecodeReturnsCoordinate() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CoordinateDataModel.self, fromResource: "coordinate")

        XCTAssertEqual(result, .mock)
    }

    func testLatitudeReturnsValue() throws {
        let expectedResult = CoordinateDataModel.mock.latitude

        let result = try JSONDecoder.policeDataAPI.decode(CoordinateDataModel.self, fromResource: "coordinate").latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLatitudeWhenNotANumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CoordinateDataModel.self, fromResource: "coordinate-invalid")
            .latitude

        XCTAssertEqual(result, 0)
    }

    func testLongitudeReturnsValue() throws {
        let expectedResult = CoordinateDataModel.mock.longitude

        let result = try JSONDecoder.policeDataAPI
            .decode(CoordinateDataModel.self, fromResource: "coordinate")
            .longitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeWhenNotANumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CoordinateDataModel.self, fromResource: "coordinate-invalid")
            .longitude

        XCTAssertEqual(result, 0)
    }

    func testDescriptionReturnsString() {
        let coordinate = CoordinateDataModel.mock
        let expectedResult = "(\(coordinate.latitude), \(coordinate.longitude))"

        let result = (coordinate as CustomStringConvertible).description

        XCTAssertEqual(result, expectedResult)
    }

}
