@testable import UKPoliceData
import XCTest

final class PoliceForceReferenceTests: XCTestCase {

    func testDecodeReturnsPoliceForceReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceForceReference.self, fromResource: "police-force-reference")

        XCTAssertEqual(result, .mock)
    }

}
