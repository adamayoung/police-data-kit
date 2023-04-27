@testable import PoliceAPI
import XCTest

final class PoliceForceReferenceDataModelTests: XCTestCase {

    func testDecodeReturnsPoliceForceReference() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceForceReferenceDataModel.self, fromResource: "police-force-reference")

        XCTAssertEqual(result, .mock)
    }

}
