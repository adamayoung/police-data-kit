@testable import PoliceDataKit
import XCTest

final class PoliceForceSeniorOfficersCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID = "abc123"

        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "police-force-\(policeForceID)-senior-officers")
    }

}
