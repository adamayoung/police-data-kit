@testable import UKPoliceData
import XCTest

final class CoordinateTests: XCTestCase {

    func testDecodeReturnsCoordinate() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Coordinate.self, fromResource: "coordinate", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
