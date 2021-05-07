@testable import UKPoliceData
import XCTest

final class NeighbourhoodReferenceTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodReference.self, fromResource: "neighbourhood-reference", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
