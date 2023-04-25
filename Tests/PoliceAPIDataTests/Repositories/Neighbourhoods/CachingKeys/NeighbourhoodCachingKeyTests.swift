@testable import PoliceAPIData
import XCTest

final class NeighbourhoodCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let id = "987zyw"
        let policeForceID = "abc123"

        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)

        XCTAssertEqual(cacheKey.keyValue, "neighbourhood-\(id)-\(policeForceID)")
    }

}
