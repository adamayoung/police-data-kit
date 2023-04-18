@testable import PoliceAPI
import XCTest

final class NeighbourhoodReferenceTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodReference.self, fromResource: "neighbourhood-reference")

        XCTAssertEqual(result, .mock)
    }

}
