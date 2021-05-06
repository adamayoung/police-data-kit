@testable import UKPoliceData
import XCTest

final class LocationTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Location.self, fromResource: "location", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
