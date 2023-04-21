@testable import PoliceAPI
import XCTest

final class NeighbourhoodPoliceOfficersCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let neighbourhoodID = "987zyw"
        let policeForceID = "abc123"

        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )

        XCTAssertEqual(cacheKey.keyValue, "neighbourhood-police-officers-\(neighbourhoodID)-\(policeForceID)")
    }

}
