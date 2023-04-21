@testable import PoliceAPI
import XCTest

final class NeighbourhoodsInPoliceForceCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID: PoliceForce.ID = "abc123"

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "neighbourhoods-in-police-force-\(policeForceID)")
    }

}
