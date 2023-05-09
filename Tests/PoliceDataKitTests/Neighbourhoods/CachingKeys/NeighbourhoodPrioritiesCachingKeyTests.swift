@testable import PoliceDataKit
import XCTest

final class NeighbourhoodPrioritiesCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let neighbourhoodID = "987zyw"
        let policeForceID = "abc123"

        let cacheKey = NeighbourhoodPrioritiesCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "neighbourhood-\(neighbourhoodID)-\(policeForceID)-priorities")
    }

}
