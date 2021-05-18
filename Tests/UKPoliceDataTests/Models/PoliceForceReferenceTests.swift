@testable import UKPoliceData
import XCTest

class PoliceForceReferenceTests: XCTestCase {

    func testDecodeReturnsPoliceForceReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceForceReference.self, fromResource: "police-force-reference", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
