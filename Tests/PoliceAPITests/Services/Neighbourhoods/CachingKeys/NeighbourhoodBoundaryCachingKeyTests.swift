@testable import PoliceAPI
import XCTest

final class NeighbourhoodBoundaryCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let neighbourhoodID = "987zyw"
        let policeForceID = "abc123"

        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "neighbourhood-boundary-\(neighbourhoodID)-\(policeForceID)")
    }

}
