@testable import PoliceDataKit
import XCTest

final class NeighbourhoodReferenceDataModelTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodReferenceDataModel.self, fromResource: "neighbourhood-reference")

        XCTAssertEqual(result, .mock)
    }

}
