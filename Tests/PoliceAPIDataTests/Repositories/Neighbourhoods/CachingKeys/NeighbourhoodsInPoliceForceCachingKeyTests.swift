@testable import PoliceAPIData
import XCTest

final class NeighbourhoodsInPoliceForceCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID: PoliceForceDataModel.ID = "abc123"

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "neighbourhoods-in-police-force-\(policeForceID)")
    }

}
