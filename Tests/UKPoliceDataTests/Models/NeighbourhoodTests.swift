@testable import UKPoliceData
import XCTest

final class NeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
